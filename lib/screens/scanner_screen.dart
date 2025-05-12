import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_scanner/l10n/app_localizations.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'scan_result_screen.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => QRScannerScreenState();
}

class QRScannerScreenState extends State<QRScannerScreen> with WidgetsBindingObserver {
  final _log = Logger('CameraScannerScreenState');
  final MobileScannerController controller = MobileScannerController(
    // formats: [BarcodeFormat.qrCode], // Limit to QR codes
    // detectionSpeed: DetectionSpeed.normal, // Adjust speed
  );

  StreamSubscription<Object?>? _subscription;
  bool _isNavigating = false;
  bool _isCameraExplicitlyStopped = false;
  PermissionStatus? _cameraPermissionStatus;
  bool _isCheckingPermission = true;
  bool _isRequestingPermission = false;

  double _currentZoomScale = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _checkPermissionAndInitialize();
      }
    });
    controller.addListener(_handleControllerStateChange);
  }

  void _handleControllerStateChange() {
    if (!mounted) return;
    final state = controller.value;
    if (state.isInitialized && state.isRunning) {
      final currentCamera = state.cameraDirection;
      if (_lastKnownCameraDirection != null && _lastKnownCameraDirection != currentCamera) {
        _log.fine("Camera changed, resetting zoom slider to 0.0");
        setState(() {
          _currentZoomScale = 0.0;
        });
        // Optionally call setZoomScale(0.0) if the controller doesn't reset automatically
        // controller.setZoomScale(0.0);
      }
      _lastKnownCameraDirection = currentCamera;
    }
  }
  CameraFacing? _lastKnownCameraDirection;

  Future<void> enableKeepAwake() async {
    try {
      await WakelockPlus.enable();
      _log.fine("Wakelock explicitly enabled by external request.");
    } catch (e, s) {
      _log.severe("Error enabling wakelock: $e", e, s);
    }
  }

  Future<void> disableKeepAwake() async {
    try {
      await WakelockPlus.disable();
      _log.fine("Wakelock explicitly disabled by external request.");
    } catch (e, s) {
      _log.severe("Error disabling wakelock: $e", e, s);
    }
  }

  Future<void> _checkPermissionAndInitialize() async {
    if (_isRequestingPermission || !mounted) return;

    _log.fine("Checking camera permission...");

    final status = await Permission.camera.status;
    _log.fine("Initial camera permission status: $status");

    if (mounted) {
      setState(() {
        _cameraPermissionStatus = status;
        _isCheckingPermission = false;
      });

      if (status.isGranted) {
        _log.fine("Permission already granted. Initializing scanner.");
        if (!_isCameraExplicitlyStopped) {
          await startCamera();
        }
      } else if (status.isPermanentlyDenied || status.isRestricted) {
        _log.warning("Permission permanently denied or restricted ($status). Cannot request.");
      }
      else {
        _log.warning("Camera permission is not granted ($status). Requesting...");
        await _requestPermission();
      }
    }
  }

  Future<void> _requestPermission() async {
    final l10n = AppLocalizations.of(context);

    if (_isRequestingPermission || !mounted) {
      _log.warning("Permission request attempted while another is active or widget is unmounted. Skipping.");
      return;
    }

    _log.fine("Requesting camera permission...");
    PermissionStatus status;

    try {
      setState(() {
        _isRequestingPermission = true;
      });

      status = await Permission.camera.request();
      _log.fine("Permission request result: $status");

      if (mounted) {
        setState(() {
          _cameraPermissionStatus = status;
        });

        if (status.isGranted) {
          _log.fine("Permission granted after request. Initializing scanner.");
          if (!_isCameraExplicitlyStopped) {
            await startCamera();
          }
        } else {
          _log.warning("Permission denied after request ($status).");
          if (status.isPermanentlyDenied) {
            _showErrorSnackBar(l10n.cameraPermissionDeniedInSettings);
          } else if (!status.isRestricted) {
            _showErrorSnackBar(l10n.cameraPermissionRequestText);
          }
        }
      }
    } catch (e, s) {
      _log.severe("Error during permission request: $e", e, s);
      if (mounted) {
        _showErrorSnackBar(l10n.errorRequestingPermission);
        setState(() {
          _cameraPermissionStatus = PermissionStatus.denied;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isRequestingPermission = false;
        });
      } else {
        _isRequestingPermission = false;
      }
      _log.finer("Permission request flag reset.");
    }
  }

  Future<void> startCamera() async {
    final currentStatus = await Permission.camera.status;
    if (mounted) {
      if (_cameraPermissionStatus != currentStatus) {
        setState(() => _cameraPermissionStatus = currentStatus);
      }
    } else {
      return;
    }

    if (currentStatus != PermissionStatus.granted) {
      _log.warning("startCamera called but permission is not granted ($currentStatus). Requesting again (if possible).");
      await _requestPermission();
      final statusAfterRequest = await Permission.camera.status;
      if (mounted && _cameraPermissionStatus != statusAfterRequest) {
        setState(() => _cameraPermissionStatus = statusAfterRequest);
      }

      if (statusAfterRequest != PermissionStatus.granted) {
        _log.severe("Permission denied after re-request in startCamera. Aborting start.");
        return;
      }
    }

    _isCameraExplicitlyStopped = false;
    if (controller.value.isRunning || !mounted) {
      _log.fine("startCamera: Already running or not mounted.");
      if (controller.value.isRunning) _listenForBarcodes();
      return;
    }
    _log.fine("QRScannerScreen: Received startCamera command (Permission Granted)");
    await _resumeScanner();
  }

  Future<void> stopCamera() async {
    _isCameraExplicitlyStopped = true;
    if (!controller.value.isRunning || !mounted) {
      _log.fine("stopCamera: Already stopped or not mounted.");
      return;
    }
    _log.fine("QRScannerScreen: Received stopCamera command");
    await _pauseScanner();
  }

  void _listenForBarcodes() {
    final l10n = AppLocalizations.of(context);

    if (!mounted ||
        _cameraPermissionStatus != PermissionStatus.granted ||
        !controller.value.isInitialized ||
        !controller.value.isRunning ||
        _subscription != null)
    {
      _log.warning(
          "QRScannerScreen: Conditions not met to listen for barcodes (mounted:$mounted, permission:$_cameraPermissionStatus, initialized:${controller.value.isInitialized}, running:${controller.value.isRunning}, hasSubscription:${_subscription != null}).");
      return;
    }

    _log.fine("QRScannerScreen: Starting to listen for barcodes.");
    try {
      _subscription?.cancel();
      _subscription = controller.barcodes.listen(_handleBarcode, onError: (error) {
        _log.severe("QRScannerScreenState: Error listening to barcode stream: $error");
        _showErrorSnackBar(l10n.errorReceivingBarcodeData);
      }, onDone: () {
        _log.warning("Barcode stream closed unexpectedly.");
        _subscription = null;
        if (mounted && controller.value.isRunning && !_isNavigating && !_isCameraExplicitlyStopped) {
          _log.fine("Attempting to re-listen to barcode stream after it closed.");
          _listenForBarcodes();
        }
      });
    } catch (e, s) {
      _log.severe("QRScannerScreenState: Exception setting up barcode listener: $e", e, s);
      _showErrorSnackBar(l10n.failedToSetUpBarcodeListener);
    }
  }

  Future<void> _handleBarcode(BarcodeCapture capture) async {
    if (_isNavigating || !mounted) {
      _log.finer("Barcode detected but navigation in progress or widget unmounted. Ignoring.");
      return;
    }

    if (capture.barcodes.isNotEmpty) {
      final Barcode barcode = capture.barcodes.first;
      final String? code = barcode.rawValue;
      final BarcodeType type = barcode.type;

      if (code != null) {
        _log.info('Barcode found! Type: $type, Data: $code');
        setState(() {
          _isNavigating = true;
        });

        await _pauseScanner();
        try {
          _log.fine("Disabling wakelock before navigation.");
          await WakelockPlus.disable();
        } catch (e, s) {
          _log.severe("Error disabling wakelock before navigation: $e", e, s);
        }

        if (!mounted) {
          _log.warning("Widget unmounted before navigation could start.");
          _isNavigating = false;
          return;
        }

        await Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) => ResultScreen(code: code, type: type),
          ),
        );

        if (mounted) {
          _log.fine("Returned from ResultScreen.");
          try {
            _log.fine("Re-enabling wakelock after returning.");
            await WakelockPlus.enable();
          } catch (e, s) {
            _log.severe("Error enabling wakelock after returning: $e", e, s);
          }

          setState(() {
            _isNavigating = false;
          });
          await Future.delayed(const Duration(milliseconds: 150));

          if (mounted && !_isCameraExplicitlyStopped) {
            _log.fine("Attempting to resume scanner after returning.");
            final currentStatus = await Permission.camera.status;
            if (mounted) {
              setState(() { _cameraPermissionStatus = currentStatus; });
              if (currentStatus.isGranted) {
                await _resumeScanner();
              } else {
                _log.warning("Permission no longer granted after returning from result screen.");
              }
            }
          } else {
            _log.fine("Scanner restart skipped (unmounted or explicitly stopped).");
          }
        } else {
          _log.fine("Widget unmounted after returning from ResultScreen.");
          _isNavigating = false;
        }
      } else {
        _log.warning("Barcode detected but rawValue is null.");
      }
    } else {
      // _log.finer("BarcodeCapture received but contains no barcodes.");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (!mounted) return;
    if (_cameraPermissionStatus != PermissionStatus.granted) {
      _log.finer("App lifecycle changed ($state) but no camera permission. Ignoring pause/resume.");
      return;
    }

    if (_isNavigating) {
      _log.finer("App lifecycle changed ($state) but currently navigating, ignoring.");
      return;
    }
    if (_isRequestingPermission) {
      _log.finer("App lifecycle changed ($state) but requesting permission, ignoring pause/resume.");
      return;
    }

    _log.fine("App lifecycle state changed: $state");

    switch (state) {
      case AppLifecycleState.resumed:
        _log.fine("App resumed.");
        _checkPermissionAndInitialize();
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        if (controller.value.isRunning) {
          _log.fine("App paused/inactive ($state), pausing scanner.");
          _pauseScanner();
        } else {
          _log.fine("App paused/inactive ($state), but scanner already stopped.");
        }
        break;
    }
  }

  Future<void> _pauseScanner() async {
    if (_subscription != null) {
      await _subscription?.cancel();
      _subscription = null;
      _log.fine("Barcode subscription cancelled.");
    } else {
      _log.finer("Pause requested but no active barcode subscription.");
    }

    if (controller.value.isRunning) {
      try {
        _log.fine("Pausing scanner controller...");
        await controller.stop();
        _log.fine("Scanner controller stopped.");
      } catch (e, s) {
        _log.severe("Error stopping scanner during pause: $e", e, s);
      }
    } else {
      _log.fine("Pause requested but scanner controller already stopped.");
    }
  }

  Future<void> _resumeScanner() async {
    final l10n = AppLocalizations.of(context);

    if (_isRequestingPermission || _cameraPermissionStatus != PermissionStatus.granted) {
      _log.warning("_resumeScanner: Aborting resume (requesting permission: $_isRequestingPermission, status: $_cameraPermissionStatus).");
      return;
    }

    if (!mounted || _isNavigating || _isCameraExplicitlyStopped) {
      _log.warning(
        "_resumeScanner: Conditions not met (mounted:$mounted, navigating:$_isNavigating, explicitStop:$_isCameraExplicitlyStopped, permission:$_cameraPermissionStatus)");
      return;
    }

    if (controller.value.isRunning) {
      _log.fine("Scanner already running, ensuring listener is active.");
      _listenForBarcodes();
      return;
    }

    _log.fine("QRScannerScreen: Resuming scanner...");
    bool startSuccess = false;
    try {
      _log.fine("QRScannerScreenState: Calling controller.start()...");
      await enableKeepAwake();
      await controller.start();
      if (!mounted) return;

      if (controller.value.isRunning && controller.value.error == null) {
        _log.fine("QRScannerScreenState: controller.start() successful.");
        startSuccess = true;
      } else {
        final error = controller.value.error;
        _log.severe(
          "QRScannerScreenState: controller.start() finished, but state is not running (${controller.value.isRunning}) or has error (${error?.errorCode}, ${error?.errorDetails})");
        await disableKeepAwake();

        if (error?.errorCode == MobileScannerErrorCode.permissionDenied) {
          _log.severe("Scanner reported permission denied during start. Updating state and showing error.");
          if (mounted) {
            setState(() => _cameraPermissionStatus = PermissionStatus.denied);
            _showErrorSnackBar(l10n.cameraPermissionDeniedInSettings);
          }
        } else if (error != null) {
          _showErrorSnackBar(l10n.cameraStartError(error.errorDetails.toString()));
        } else if (!controller.value.isRunning) {
          _showErrorSnackBar(l10n.cameraGenericError);
        }
      }
    } on MobileScannerException catch (e, s) {
      _log.severe("QRScannerScreenState: MobileScannerException during start: ${e.errorCode} - ${e.errorDetails}", e, s);
      await disableKeepAwake();
      if (mounted) {
        if (e.errorCode == MobileScannerErrorCode.permissionDenied) {
          setState(() => _cameraPermissionStatus = PermissionStatus.denied);
          _showErrorSnackBar(l10n.cameraPermissionDeniedInSettings);
        } else {
          _showErrorSnackBar(l10n.cameraStartError(e.errorDetails.toString()));
        }
      }
    } catch (e, s) {
      _log.severe("QRScannerScreenState: Generic error during controller.start(): $e", e, s);
      await disableKeepAwake();
      if (mounted) {
        _showErrorSnackBar(l10n.cameraGenericError);
      }
    }

    if (startSuccess && mounted) {
      _listenForBarcodes();
    }
  }

  void _setZoom(double value) {
    if (!mounted || !controller.value.isInitialized || !controller.value.isRunning) {
      _log.finer("Conditions not met (mounted, initialized, running). Skipping setZoomScale.");
      return;
    }
    
    try {
      controller.setZoomScale(value);
      _log.finer("Set zoom scale to: $value");
    } catch (e, s) {
      _log.severe("Error setting zoom scale: $e", e, s);
    }
  }

  void resetZoom() {
    if (!mounted || !controller.value.isInitialized || !controller.value.isRunning) {
      _log.finer("Conditions not met (initialized, running). Skipping resetZoomScale.");
      return;
    }

    try {
      controller.resetZoomScale();
      setState(() { _currentZoomScale = 0; });
      _log.finer("Reset zoom scale");
    } catch (e, s) {
      _log.severe("Error resetting zoom scale: $e", e, s);
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Future<void> dispose() async {
    _log.fine("QRScannerScreenState: Disposing...");
    WidgetsBinding.instance.removeObserver(this);
    controller.removeListener(_handleControllerStateChange);

    await _subscription?.cancel();
    _subscription = null;

    try {
      if (controller.value.isRunning) {
        await controller.stop();
      }
    } catch (e) {
      _log.warning("Error stopping controller during dispose: $e");
    }
    await controller.dispose();

    try {
      await WakelockPlus.disable();
      _log.fine("QRScannerScreenState: Wakelock disabled on dispose.");
    } catch (e,s) {
      _log.severe("Error disabling wakelock during dispose: $e", e, s);
    }
    _log.fine("QRScannerScreenState: Disposed.");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.scannerTabTitle),
        actions: [
          if (_cameraPermissionStatus == PermissionStatus.granted)
            ValueListenableBuilder<MobileScannerState>(
              valueListenable: controller,
              builder: (context, state, child) {
                if (!state.isInitialized || !state.isRunning) {
                  return const SizedBox.shrink();
                }
                Widget torchIcon;
                String torchTooltip;
                VoidCallback? onTorchPressed;
                Color torchColor = Theme.of(context).iconTheme.color ?? Colors.white;

                switch (state.torchState) {
                  case TorchState.off:
                    torchIcon = const Icon(Icons.flash_off);
                    torchTooltip = 'Turn on flash';
                    onTorchPressed = () => controller.toggleTorch().catchError((e) {
                      _log.severe("Error toggling torch: $e");
                      _showErrorSnackBar(l10n.couldNotToggleFlash);
                    });
                    break;
                  case TorchState.on:
                    torchIcon = const Icon(Icons.flash_on);
                    torchTooltip = 'Turn off flash';
                    torchColor = Colors.yellow.shade700;
                    onTorchPressed = () => controller.toggleTorch().catchError((e) {
                      _log.severe("Error toggling torch: $e");
                      _showErrorSnackBar(l10n.couldNotToggleFlash);
                    });
                    break;
                  case TorchState.auto:
                  case TorchState.unavailable:
                    torchIcon = const Icon(Icons.no_flash);
                    torchTooltip = 'Flash unavailable';
                    torchColor = Colors.grey;
                    onTorchPressed = null;
                    break;
                }
                return IconButton(
                  color: torchColor,
                  icon: torchIcon,
                  tooltip: torchTooltip,
                  onPressed: onTorchPressed,
                );
              },
            ),
          if (_cameraPermissionStatus == PermissionStatus.granted)
            ValueListenableBuilder<MobileScannerState>(
              valueListenable: controller,
              builder: (context, state, child) {
                if (!state.isInitialized || !state.isRunning || (state.availableCameras ?? 0) <= 1) {
                  return const SizedBox.shrink();
                }
                return IconButton(
                  color: Theme.of(context).iconTheme.color ?? Colors.white,
                  icon: const Icon(Icons.switch_camera),
                  tooltip: 'Switch camera',
                  onPressed: () => controller.switchCamera().catchError((e) {
                    _log.severe("Error switching camera: $e");
                    _showErrorSnackBar(l10n.couldNotSwitchCamera);
                  }),
                );
              },
            ),
        ],
      ),
      body: _buildScannerBody(),
      persistentFooterButtons: _buildPersistentFooter(l10n),
    );
  }

  List<Widget>? _buildPersistentFooter(AppLocalizations l10n) {
    if (_cameraPermissionStatus != PermissionStatus.granted) {
      return null;
    }

    return [
      ValueListenableBuilder<MobileScannerState>(
        valueListenable: controller,
        builder: (context, state, child) {
          if (!state.isInitialized || !state.isRunning) {
            return const SizedBox.shrink();
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(Icons.zoom_out, color: Colors.grey),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2.0,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
                    ),
                    child: Slider(
                      value: _currentZoomScale,
                      min: 0.0,
                      max: 1.0,
                      activeColor: Theme.of(context).colorScheme.primary,
                      inactiveColor: Colors.grey.shade400,
                      onChanged: (value) {
                        if (mounted) {
                          setState(() { _currentZoomScale = value; });
                          _setZoom(value);
                        }
                      },
                    ),
                  ),
                ),
                const Icon(Icons.zoom_in, color: Colors.grey),
              ],
            ),
          );
        },
      ),
    ];
  }

  Widget _buildScannerBody() {
    final l10n = AppLocalizations.of(context);

    if (_isCheckingPermission) {
      _log.finer("Building: Checking Permissions UI");
      return const Center(child: CircularProgressIndicator());
    }

    if (_cameraPermissionStatus == PermissionStatus.granted) {
      _log.finer("Building: Scanner UI (Permission Granted)");
      return Stack(
        children: [
          MobileScanner(
            controller: controller,
            errorBuilder: (context, error, child) {
              _log.severe("MobileScanner errorBuilder: ${error.errorCode} ${error.errorDetails}");
              String errorMessage = l10n.cameraGenericError;
              bool showSettingsButton = false;

              if (error.errorCode == MobileScannerErrorCode.permissionDenied) {
                errorMessage = l10n.cameraPermissionDeniedOrRevoked;
                showSettingsButton = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted && _cameraPermissionStatus != PermissionStatus.denied) {
                    _log.warning("Updating state to denied based on errorBuilder reporting permissionDenied.");
                    setState(() => _cameraPermissionStatus = PermissionStatus.denied);
                  }
                });
              } else if (error.errorCode == MobileScannerErrorCode.unsupported) {
                errorMessage = l10n.cameraNotSupported;
              } else if (error.errorDetails != null) {
                errorMessage = l10n.cameraStartError(error.errorDetails.toString());
              } else {
                errorMessage = l10n.cameraStartError(error.errorCode.toString());
              }

              return _buildErrorWidget(errorMessage, showSettingsButton);
            },
            placeholderBuilder: (context, child) {
              _log.finer("Building: Scanner Placeholder UI");
              return Container(
                color: Colors.black,
                child: const Center(child: CircularProgressIndicator()),
              );
            },
            overlayBuilder: (context, constraints) {
              double shortestSide = constraints.biggest.shortestSide;
              double scanWindowSize = shortestSide * 0.6;
              scanWindowSize = scanWindowSize.clamp(150.0, 400.0);

              return Center(
                child: Container(
                  width: scanWindowSize,
                  height: scanWindowSize,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.redAccent, width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(140),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                l10n.scannerTabScanText,
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }
    else {
      _log.finer("Building: Permission Denied/Required UI ($_cameraPermissionStatus)");
      return _buildPermissionDeniedWidget();
    }
  }

  Widget _buildPermissionDeniedWidget() {
    final l10n = AppLocalizations.of(context);

    bool isPermanentlyDenied = _cameraPermissionStatus == PermissionStatus.permanentlyDenied;
    bool isRestricted = _cameraPermissionStatus == PermissionStatus.restricted;

    String message;
    String buttonText;
    VoidCallback? onPressed;

    if (isPermanentlyDenied) {
      message = l10n.cameraPermissionPermanentlyDeniedText;
      buttonText = l10n.openSettingsText;
      onPressed = () async {
        _log.fine("Opening app settings...");
        await openAppSettings();
      };
    } else if (isRestricted) {
      message = l10n.cameraPermissionRestrictedText;
      buttonText = '';
      onPressed = null;
    } else {
      message = l10n.cameraPermissionRequestText;
      buttonText = l10n.grantPermissionText;
      onPressed = _requestPermission;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.no_photography_outlined, size: 70, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 20),
            Text(message, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 25),
            if (onPressed != null)
              ElevatedButton(
                onPressed: _isRequestingPermission ? null : onPressed,
                child: _isRequestingPermission
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text(buttonText),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String message, bool showSettingsButton) {
    final l10n = AppLocalizations.of(context);

    return Container(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error, size: 70),
              const SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.error)
              ),
              const SizedBox(height: 25),
              if (showSettingsButton)
                ElevatedButton(
                  onPressed: () async {
                    _log.fine("Opening app settings from error widget...");
                    await openAppSettings();
                  },
                  child: Text(l10n.openSettingsText),
                ),
            ],
          ),
        ),
      ),
    );
  }
}