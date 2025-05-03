import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_scanner/l10n/app_localizations.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _checkPermissionAndInitialize();
      }
    });
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
            _showErrorSnackBar("Permission permanently denied. Please enable in settings.");
          } else if (!status.isRestricted) {
            _showErrorSnackBar("Camera permission is required to scan QR codes.");
          }
        }
      }
    } catch (e, s) {
      _log.severe("Error during permission request: $e", e, s);
      if (mounted) {
        _showErrorSnackBar("Error requesting permission.");
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
      _subscription = controller.barcodes.listen(_handleBarcode, onError: (error) {
        _log.severe("QRScannerScreenState: Error listening to barcode stream: $error");
        _showErrorSnackBar("Error receiving barcode data.");
      });
    } catch (e, s) {
      _log.severe("QRScannerScreenState: Exception setting up barcode listener: $e", e, s);
      _showErrorSnackBar("Failed to set up barcode listener.");
    }
  }

  Future<void> _handleBarcode(BarcodeCapture capture) async {
    if (_isNavigating || !mounted) {
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

        await _subscription?.cancel();
        _subscription = null;
        try {
          if (controller.value.isRunning) {
            _log.fine("Stopping scanner before navigation...");
            await controller.stop();
          }
        } catch (e, s) {
          _log.severe("Error stopping scanner before navigation: $e", e, s);
        }

        if (!mounted) {
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
          setState(() {
            _isNavigating = false;
          });
          await Future.delayed(const Duration(milliseconds: 200));
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
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (!mounted) return;
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
        _log.fine("App resumed. Re-checking permission and potentially resuming scanner.");
        _checkPermissionAndInitialize();
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        if (controller.value.isRunning) {
          _log.fine("App paused/inactive ($state), pausing scanner.");
          _pauseScanner();
        }
        break;
    }
  }

  Future<void> _pauseScanner() async {
    await _subscription?.cancel();
    _subscription = null;
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
    if (_isRequestingPermission || _cameraPermissionStatus != PermissionStatus.granted) {
      _log.severe("_resumeScanner: Aborting resume (requesting permission: $_isRequestingPermission, status: $_cameraPermissionStatus).");
      return;
    }

    if (!mounted || _isNavigating || _isCameraExplicitlyStopped) {
      _log.warning(
          "QRScannerScreenState: Resume conditions not met (mounted:$mounted, navigating:$_isNavigating, explicitStop:$_isCameraExplicitlyStopped, permission:$_cameraPermissionStatus)");
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
      await controller.start();
      if (!mounted) return;

      if (controller.value.isRunning && controller.value.error == null) {
        _log.fine("QRScannerScreenState: controller.start() successful.");
        startSuccess = true;
      } else {
        final error = controller.value.error;
        _log.severe(
            "QRScannerScreenState: controller.start() finished, but state is not running (${controller.value.isRunning}) or has error (${error?.errorCode}, ${error?.errorDetails})");
        if (error?.errorCode == MobileScannerErrorCode.permissionDenied) {
          _log.severe("Scanner reported permission denied during start. Updating state.");
          if (mounted) {
            setState(() => _cameraPermissionStatus = PermissionStatus.denied);
          }
          _showErrorSnackBar("Camera permission denied. Please grant permission in settings.");
        } else {
          _showErrorSnackBar("Failed to start camera. Error: ${error?.errorDetails ?? error?.errorCode ?? 'Unknown'}");
        }
      }
    } on MobileScannerException catch (e, s) {
      _log.severe("QRScannerScreenState: MobileScannerException during start: ${e.errorCode} - ${e.errorDetails}", e, s);
      if (mounted) {
        if (e.errorCode == MobileScannerErrorCode.permissionDenied) {
          setState(() => _cameraPermissionStatus = PermissionStatus.denied);
          _showErrorSnackBar("Camera permission denied. Please grant permission in settings.");
        } else {
          _showErrorSnackBar("Camera Error: ${e.errorDetails ?? e.errorCode.toString()}");
        }
      }
    } catch (e, s) {
      _log.severe("QRScannerScreenState: Generic error during controller.start(): $e", e, s);
      if (mounted) {
        _showErrorSnackBar("An unexpected error occurred while starting the camera.");
      }
    }

    if (startSuccess && mounted) {
      _listenForBarcodes();
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
            ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, state, child) {
                if (!state.isInitialized || !state.isRunning) {
                  return const SizedBox.shrink();
                }
                Widget torchIcon;
                String torchTooltip;
                Color torchColor = Colors.white;

                switch (state.torchState) {
                  case TorchState.off:
                    torchIcon = const Icon(Icons.flash_off);
                    torchTooltip = 'Turn on flash';
                    break;
                  case TorchState.on:
                    torchIcon = const Icon(Icons.flash_on);
                    torchTooltip = 'Turn off flash';
                    torchColor = Colors.yellow;
                    break;
                  case TorchState.auto:
                  case TorchState.unavailable:
                    torchIcon = const Icon(Icons.no_flash);
                    torchTooltip = 'Flash unavailable';
                    torchColor = Colors.grey;
                    return IconButton(
                      color: torchColor,
                      icon: torchIcon,
                      tooltip: torchTooltip,
                      onPressed: null,
                    );
                }
                return IconButton(
                  color: torchColor,
                  icon: torchIcon,
                  tooltip: torchTooltip,
                  onPressed: () async {
                    try {
                      await controller.toggleTorch();
                    } catch (e) {
                      _log.severe("Error toggling torch: $e");
                      _showErrorSnackBar("Could not toggle flash.");
                    }
                  },
                );
              },
            ),
          if (_cameraPermissionStatus == PermissionStatus.granted)
            ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, state, child) {
                if (!state.isInitialized || !state.isRunning || (state.availableCameras ?? 0) <= 1) {
                  return const SizedBox.shrink();
                }
                return IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.switch_camera),
                  tooltip: 'Switch camera',
                  onPressed: () async {
                    try {
                      await controller.switchCamera();
                    } catch (e) {
                      _log.severe("Error switching camera: $e");
                      _showErrorSnackBar("Could not switch camera.");
                    }
                  },
                );
              },
          ),
        ],
      ),
      body: _buildScannerBody(),
    );
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
              String errorMessage = 'An unexpected camera error occurred.';
              bool showSettingsButton = false;

              if (error.errorCode == MobileScannerErrorCode.permissionDenied) {
                errorMessage = 'Camera permission was denied or revoked.\nPlease grant permission in app settings.';
                showSettingsButton = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted && _cameraPermissionStatus != PermissionStatus.denied) {
                    _log.warning("Updating state to denied based on errorBuilder.");
                    setState(() => _cameraPermissionStatus = PermissionStatus.denied);
                  }
                });
              } else {
                errorMessage = 'Camera Error: ${error.errorDetails ?? error.errorCode.toString()}';
                if (error.errorCode == MobileScannerErrorCode.unsupported) {
                  errorMessage = 'Camera is unavailable or not supported on this device.';
                }
              }

              return _buildErrorWidget(errorMessage, showSettingsButton);
            },
            placeholderBuilder: (context, child) {
              _log.finer("Building: Scanner Placeholder UI");
              return const Center(child: CircularProgressIndicator());
            },
            overlayBuilder: (context, constraints) {
              double scanWindowSize = MediaQuery.of(context).size.width * 0.6;
              scanWindowSize = scanWindowSize < 150 ? 150 : scanWindowSize;
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
                color: Colors.black.withAlpha(128),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                l10n.scannerTabScanText,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
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
              ValueListenableBuilder<bool>(
                  valueListenable: ValueNotifier(_isRequestingPermission),
                  builder: (context, isRequesting, child) {
                    return ElevatedButton(
                      onPressed: isRequesting ? null : onPressed,
                      child: isRequesting
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : Text(buttonText),
                    );
                  }
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String message, bool showSettingsButton) {
    final l10n = AppLocalizations.of(context);
  
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error, size: 70),
            const SizedBox(height: 20),
            Text(message, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.error)),
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
    );
  }

}