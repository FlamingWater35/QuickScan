import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';
import '/l10n/app_localizations.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'scan_result_screen.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => QRScannerScreenState();
}

class QRScannerScreenState extends State<QRScannerScreen> with WidgetsBindingObserver {
  final _log = Logger('CameraScannerScreenState');
  late final MobileScannerController controller;

  StreamSubscription<Object?>? _subscription;
  bool _isNavigating = false;
  bool _isCameraExplicitlyStopped = false;
  PermissionStatus? _cameraPermissionStatus;
  bool _isCheckingPermission = true;
  bool _isRequestingPermission = false;

  double _currentZoomScale = 0.0;
  CameraFacing? _lastKnownCameraDirection;

  bool _isProcessingScannerStateChange = false;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
      detectionSpeed: DetectionSpeed.normal,
      returnImage: false,
      autoStart: false,
    );

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _checkPermissionAndInitialize();
      }
    });
    controller.addListener(_handleControllerStateChange);
    _log.fine("QRScannerScreenState initState completed.");
  }

  void _handleControllerStateChange() {
    if (!mounted) return;
    final state = controller.value;
    if (state.isInitialized && state.isRunning) {
      final currentCamera = state.cameraDirection;
      if (_lastKnownCameraDirection != null && _lastKnownCameraDirection != currentCamera) {
        _log.fine("Camera changed, resetting zoom slider to 0.0");
        if (mounted) {
          setState(() {
            _currentZoomScale = 0.0;
          });
        }
      }
      _lastKnownCameraDirection = currentCamera;
    }
  }

  Future<void> enableKeepAwake() async {
    try {
      if (!await WakelockPlus.enabled) {
        await WakelockPlus.enable();
        _log.fine("Wakelock explicitly enabled by external request.");
      }
    } catch (e, s) {
      _log.severe("Error enabling wakelock: $e", e, s);
    }
  }

  Future<void> disableKeepAwake() async {
    try {
      if (await WakelockPlus.enabled) {
        await WakelockPlus.disable();
        _log.fine("Wakelock explicitly disabled by external request.");
      }
    } catch (e, s) {
      _log.severe("Error disabling wakelock: $e", e, s);
    }
  }

  Future<void> _checkPermissionAndInitialize() async {
    if (_isRequestingPermission || !mounted) return;

    _log.fine("Checking camera permission...");
    if (mounted) {
      setState(() {
        _isCheckingPermission = true;
      });
    }

    final status = await Permission.camera.status;
    _log.fine("Initial camera permission status: $status");

    if (!mounted) return;

    setState(() {
      _cameraPermissionStatus = status;
      _isCheckingPermission = false;
    });

    if (status.isGranted) {
      _log.fine("Permission already granted. Initializing scanner if not explicitly stopped.");
      if (!_isCameraExplicitlyStopped) {
        await startCamera();
      } else {
        _log.fine("Scanner start skipped: _isCameraExplicitlyStopped is true.");
      }
    } else if (status.isPermanentlyDenied || status.isRestricted) {
      _log.warning("Permission permanently denied or restricted ($status). Cannot request.");
    } else {
      _log.fine("Camera permission is not granted ($status). Requesting...");
      await _requestPermission();
    }
  }

  Future<void> _requestPermission() async {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);

    if (_isRequestingPermission) {
      _log.warning("Permission request attempted while another is active. Skipping.");
      return;
    }

    _log.fine("Requesting camera permission...");
    PermissionStatus status;

    try {
      if (mounted) {
        setState(() { _isRequestingPermission = true; });
      } else { return; }

      status = await Permission.camera.request();
      _log.fine("Permission request result: $status");

      if (!mounted) return;

      setState(() { _cameraPermissionStatus = status; });

      if (status.isGranted) {
        _log.fine("Permission granted after request. Initializing scanner.");
        if (!_isCameraExplicitlyStopped) {
          await startCamera();
        } else {
          _log.fine("Scanner start skipped post-permission: _isCameraExplicitlyStopped is true.");
        }
      } else {
        _log.warning("Permission denied after request ($status).");
        if (mounted) {
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
        setState(() { _cameraPermissionStatus = PermissionStatus.denied; });
      }
    } finally {
      if (mounted) {
        setState(() { _isRequestingPermission = false; });
      } else {
        _isRequestingPermission = false;
      }
      _log.finer("Permission request flag reset.");
    }
  }

  Future<void> startCamera() async {
    if (!mounted) return;
    _log.fine("QRScannerScreen: Received startCamera command.");

    final currentStatus = await Permission.camera.status;
    if (mounted && _cameraPermissionStatus != currentStatus) {
      setState(() => _cameraPermissionStatus = currentStatus);
    } else if (!mounted) {
      return;
    }

    if (currentStatus != PermissionStatus.granted) {
      _log.warning("startCamera called but permission is not granted ($currentStatus). Attempting to re-request (if possible).");
      if (currentStatus.isDenied) {
        await _requestPermission();
        final statusAfterRequest = await Permission.camera.status;
        if (mounted) setState(() => _cameraPermissionStatus = statusAfterRequest);
        if (statusAfterRequest != PermissionStatus.granted) {
          _log.severe("Permission denied after re-request in startCamera. Aborting start.");
          return;
        }
      } else {
        _log.severe("Permission not granted ($currentStatus) and cannot re-request. Aborting start.");
        return;
      }
    }

    _isCameraExplicitlyStopped = false;
    if (controller.value.isRunning && !_isProcessingScannerStateChange) {
      _log.fine("startCamera: Already running and not processing. Ensuring listener and wakelock.");
      if(mounted) _listenForBarcodes();
      if(mounted && !await WakelockPlus.enabled) await WakelockPlus.enable().catchError((e,s) => _log.severe("Wakelock enable error", e, s));
      return;
    }
    await _resumeScanner();
  }

  Future<void> stopCamera() async {
    if (!mounted && !controller.value.isRunning) {
      _log.fine("stopCamera: Not mounted and controller not running. Skipping.");
      return;
    }
    _log.fine("QRScannerScreen: Received stopCamera command.");
    _isCameraExplicitlyStopped = true;

    if (mounted) {
      resetZoom();
    }

    await _pauseScanner();
  }

  void _listenForBarcodes() {
    if (!mounted || _cameraPermissionStatus != PermissionStatus.granted ||
        !controller.value.isInitialized || !controller.value.isRunning || _subscription != null) {
      _log.warning(
          "QRScannerScreen: Conditions not met to listen for barcodes (mounted:$mounted, permission:$_cameraPermissionStatus, initialized:${controller.value.isInitialized}, running:${controller.value.isRunning}, hasSubscription:${_subscription != null}).");
      return;
    }

    final l10n = AppLocalizations.of(context);
    _log.fine("QRScannerScreen: Starting to listen for barcodes.");
    try {
      _subscription = controller.barcodes.listen(_handleBarcode, onError: (error) {
        _log.severe("QRScannerScreenState: Error listening to barcode stream: $error");
        if (mounted) _showErrorSnackBar(l10n.errorReceivingBarcodeData);
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
      if (mounted) _showErrorSnackBar(l10n.failedToSetUpBarcodeListener);
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
        if (!mounted) return;
        
        setState(() { _isNavigating = true; });

        await _pauseScanner();

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
          setState(() { _isNavigating = false; });

          await Future.delayed(const Duration(milliseconds: 150)); 

          if (mounted && !_isCameraExplicitlyStopped) {
            _log.fine("Attempting to resume scanner after returning from ResultScreen.");
            final currentStatus = await Permission.camera.status;
            if (mounted) {
              setState(() { _cameraPermissionStatus = currentStatus; });
              if (currentStatus.isGranted) {
                await _resumeScanner();
              } else {
                _log.warning("Permission no longer granted after returning. UI should reflect this.");
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

    _log.fine("App lifecycle state changed: $state");

    if (_isNavigating || _isRequestingPermission) {
      _log.finer("App lifecycle ($state) change ignored: navigating:$_isNavigating, requestingPerm:$_isRequestingPermission");
      return;
    }

    switch (state) {
      case AppLifecycleState.resumed:
        _log.fine("App resumed.");
        _checkPermissionAndInitialize();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        if (controller.value.isRunning && _cameraPermissionStatus == PermissionStatus.granted) {
          _log.fine("App inactive/paused ($state), pausing scanner.");
          _pauseScanner();
        } else {
          _log.fine("App inactive/paused ($state), but scanner not running or no permission.");
        }
        break;
      case AppLifecycleState.inactive:
        break;
    }
  }

  Future<void> _pauseScanner() async {
    if (_isProcessingScannerStateChange && controller.value.isRunning) {
      _log.warning("_pauseScanner: Already processing a scanner state change AND scanner is running. Potential issue. Skipping this pause.");
      return;
    }
     if (_isProcessingScannerStateChange) {
      _log.fine("_pauseScanner: Already processing a scanner state change. Skipping current stop attempt.");
      return;
    }
    _isProcessingScannerStateChange = true;
    _log.fine("Pausing scanner controller (ProcessingFlag set)...");

    try {
      if (_subscription != null) {
        await _subscription?.cancel();
        _subscription = null;
        _log.fine("Barcode subscription cancelled.");
      }

      if (controller.value.isRunning) {
        _log.fine("Controller is running. Attempting to stop scanner controller...");
        await controller.stop();
        _log.fine("Scanner controller stopped.");
      } else {
        _log.fine("Pause requested but scanner controller already reported as stopped.");
      }
      if (await WakelockPlus.enabled) {
        await WakelockPlus.disable();
        _log.fine("Wakelock disabled during pause scanner.");
      }
    } catch (e, s) {
      _log.severe("Error during _pauseScanner's critical section (stopping controller): $e", e, s);
      try {
        if (await WakelockPlus.enabled) await WakelockPlus.disable();
      } catch (we, ws) {
        _log.severe("Error disabling wakelock during _pauseScanner error handling: $we", we, ws);
      }
    } finally {
      _isProcessingScannerStateChange = false;
      _log.fine("QRScannerScreen: Pause scanner processing finished (ProcessingFlag unset).");
    }
  }

  Future<void> _resumeScanner() async {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);

    final freshStatus = await Permission.camera.status;
    if (mounted && _cameraPermissionStatus != freshStatus) {
      setState(() { _cameraPermissionStatus = freshStatus; });
    } else if (!mounted) {return;}

    if (_isRequestingPermission || freshStatus != PermissionStatus.granted) {
      _log.warning("_resumeScanner: Aborting (requestingPerm:$_isRequestingPermission, status:$freshStatus).");
      if (await WakelockPlus.enabled) await WakelockPlus.disable();
      return;
    }

    if (_isNavigating || _isCameraExplicitlyStopped) {
      _log.warning("_resumeScanner: Aborting (navigating:$_isNavigating, explicitStop:$_isCameraExplicitlyStopped).");
      if (_isCameraExplicitlyStopped && await WakelockPlus.enabled) await WakelockPlus.disable();
      return;
    }

    if (controller.value.isRunning) {
      _log.fine("Scanner already running. Ensuring listener and wakelock.");
      if(!await WakelockPlus.enabled) await WakelockPlus.enable().catchError((e,s) => _log.severe("Wakelock enable error", e, s));
      _listenForBarcodes();
      return;
    }

    if (_isProcessingScannerStateChange) {
      _log.fine("_resumeScanner: Already processing a scanner state change. Skipping current start attempt.");
      return;
    }
    _isProcessingScannerStateChange = true;
    _log.fine("QRScannerScreen: Resuming scanner (ProcessingFlag set)...");

    bool startSuccess = false;

    try {
      _log.fine("QRScannerScreenState: Calling controller.start()...");
      await WakelockPlus.enable().catchError((e,s) => _log.severe("Wakelock enable error pre-start",e,s));

      await controller.start();

      if (!mounted) {
        _log.warning("QRScannerScreenState: Unmounted after controller.start(). Attempting to stop.");
        await controller.stop().catchError((e,s) => _log.severe("Error stopping controller post-unmount", e, s));
        if (await WakelockPlus.enabled) await WakelockPlus.disable();
        return;
      }

      if (controller.value.isRunning && controller.value.error == null) {
        _log.fine("QRScannerScreenState: controller.start() successful.");
        startSuccess = true;
      } else {
        final error = controller.value.error;
        _log.severe("QRScannerScreenState: controller.start() finished, but not running or has error (${error?.errorCode}, ${error?.errorDetails})");
        if (await WakelockPlus.enabled) await WakelockPlus.disable();
        if (mounted && error != null) {
          if (error.errorCode == MobileScannerErrorCode.permissionDenied) {
            final currentSystemPermission = await Permission.camera.status;
            if (mounted) setState(() => _cameraPermissionStatus = currentSystemPermission);
            _showErrorSnackBar(l10n.cameraPermissionDeniedInSettings);
          } else {
            _showErrorSnackBar(l10n.cameraStartError(error.errorDetails?.message ?? error.errorCode.toString()));
          }
        } else if (mounted && !controller.value.isRunning) {
          _showErrorSnackBar(l10n.cameraGenericError);
        }
      }
    } on MobileScannerException catch (e, s) {
      _log.severe("MobileScannerException during start: ${e.errorCode} - ${e.errorDetails}", e, s);
      if (await WakelockPlus.enabled) await WakelockPlus.disable();
        if (mounted) {
          if (e.errorCode == MobileScannerErrorCode.permissionDenied) {
            final currentSystemPermission = await Permission.camera.status;
            if (mounted) setState(() => _cameraPermissionStatus = currentSystemPermission);
            _showErrorSnackBar(l10n.cameraPermissionDeniedInSettings);
          } else {
            _showErrorSnackBar(l10n.cameraStartError(e.errorDetails?.message ?? e.errorCode.toString()));
          }
       }
    } catch (e, s) {
      _log.severe("Generic error during controller.start(): $e", e, s);
      if (await WakelockPlus.enabled) await WakelockPlus.disable();
      if (mounted) _showErrorSnackBar(l10n.cameraGenericError);
    } finally {
      _isProcessingScannerStateChange = false;
      _log.fine("QRScannerScreen: Resume scanner processing finished (ProcessingFlag unset).");
    }

    if (startSuccess && mounted) {
      _listenForBarcodes();
    } else if (!startSuccess && mounted) {
      _log.warning("Scanner start was not successful, barcode listening skipped.");
    }
  }

  void _setZoom(double value) {
    if (!mounted || !controller.value.isInitialized || !controller.value.isRunning) return;
    try {
      controller.setZoomScale(value);
    } catch (e, s) {
      _log.severe("Error setting zoom scale: $e", e, s);
    }
  }

  void resetZoom() {
    if (!mounted || !controller.value.isInitialized || !controller.value.isRunning) return;
    try {
      controller.resetZoomScale();
      if (mounted) {
        setState(() { _currentZoomScale = 0; });
      }
      _log.finer("Reset zoom scale");
    } catch (e, s) {
      _log.severe("Error resetting zoom scale: $e", e, s);
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted || !context.mounted) return;
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

    await controller.dispose();
    _log.fine("QRScannerScreenState: controller.dispose() called.");

    try {
      if (await WakelockPlus.enabled) {
        await WakelockPlus.disable();
        _log.fine("QRScannerScreenState: Wakelock explicitly disabled on dispose.");
      }
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
                      if (mounted) _showErrorSnackBar(l10n.couldNotToggleFlash);
                    });
                    break;
                  case TorchState.on:
                    torchIcon = const Icon(Icons.flash_on);
                    torchTooltip = 'Turn off flash';
                    torchColor = Colors.yellow.shade700;
                    onTorchPressed = () => controller.toggleTorch().catchError((e) {
                      _log.severe("Error toggling torch: $e");
                      if (mounted) _showErrorSnackBar(l10n.couldNotToggleFlash);
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
                    if (mounted) _showErrorSnackBar(l10n.couldNotSwitchCamera);
                  }),
                );
              },
            ),
        ],
      ),
      body: _buildScannerBody(),
    );
  }

  Widget _buildVerticalZoomSlider() {
    return ValueListenableBuilder<MobileScannerState>(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return const SizedBox.shrink();
        }

        final double sliderTrackVisualLength = MediaQuery.of(context).size.height * 0.3;

        return Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(120),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.zoom_in, color: Colors.white, size: 24.0),
                  SizedBox(
                    height: sliderTrackVisualLength.clamp(100.0, 300.0),
                    width: 30,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 2.0,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 18.0),
                        ),
                        child: Slider(
                          value: _currentZoomScale.clamp(0.0, 1.0),
                          min: 0.0,
                          max: 1.0,
                          activeColor: Theme.of(context).colorScheme.primary,
                          inactiveColor: Colors.grey.shade300,
                          onChanged: (value) {
                            if (mounted) {
                              setState(() { _currentZoomScale = value; });
                              _setZoom(value);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const Icon(Icons.zoom_out, color: Colors.white, size: 24.0),
                ],
              ),
            ),
          ),
        ).animate().fadeIn(duration: const Duration(milliseconds: 200)).scaleY(duration: const Duration(milliseconds: 200));
      },
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
              _log.severe("MobileScanner errorBuilder: ${error.errorCode} ${error.errorDetails?.message}");
              String errorMessage;
              bool showSettingsButtonForError = false;

              WidgetsBinding.instance.addPostFrameCallback((_) async {
                if (!mounted) return;
                final currentSystemPermission = await Permission.camera.status;

                if (error.errorCode == MobileScannerErrorCode.permissionDenied) {
                  if (currentSystemPermission.isGranted) {
                    _log.warning("MobileScanner.errorBuilder: Controller reported PermissionDenied, but system permission IS granted. UI shows component error.");
                  } else {
                    _log.warning("MobileScanner.errorBuilder: Controller reported PermissionDenied, and system concurs. Updating UI to reflect denial.");
                    if (_cameraPermissionStatus != currentSystemPermission) {
                      setState(() => _cameraPermissionStatus = currentSystemPermission);
                    }
                  }
                } else if (_cameraPermissionStatus == PermissionStatus.granted && !currentSystemPermission.isGranted) {
                  _log.warning("MobileScanner.errorBuilder: System permission changed to !granted while scanner was active. Updating UI.");
                  if (_cameraPermissionStatus != currentSystemPermission) {
                    setState(() => _cameraPermissionStatus = currentSystemPermission);
                  }
                }
              });

              if (error.errorCode == MobileScannerErrorCode.permissionDenied) {
                errorMessage = l10n.cameraPermissionDeniedOrRevoked;
                showSettingsButtonForError = true;
              } else if (error.errorCode == MobileScannerErrorCode.unsupported) {
                errorMessage = l10n.cameraNotSupported;
              } else {
                errorMessage = l10n.cameraStartError(error.errorDetails?.message ?? error.errorCode.toString());
              }
              return _buildErrorWidget(errorMessage, showSettingsButtonForError);
            },
            placeholderBuilder: (context, child) {
              _log.finer("Building: Scanner Placeholder UI (while MobileScanner initializes)");
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
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    l10n.scannerTabScanText,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 16.0),
                    textAlign: TextAlign.center,
                    speed: const Duration(milliseconds: 10)
                  ),
                ],
                isRepeatingAnimation: false,
                displayFullTextOnTap: true,
              ),
            ),
          ),
          _buildVerticalZoomSlider(),
        ],
      );
    } else {
      _log.finer("Building: Permission Denied/Required UI ($_cameraPermissionStatus)");
      return _buildPermissionDeniedWidget();
    }
  }

  Widget _buildPermissionDeniedWidget() {
    final l10n = AppLocalizations.of(context);

    bool isPermanentlyDenied = _cameraPermissionStatus == PermissionStatus.permanentlyDenied;
    bool isRestricted = _cameraPermissionStatus == PermissionStatus.restricted;

    String message;
    String buttonText = "";
    VoidCallback? onPressed;

    if (isPermanentlyDenied) {
      message = l10n.cameraPermissionPermanentlyDeniedText;
      buttonText = l10n.openSettingsText;
      onPressed = () async {
        _log.fine("Opening app settings due to permanent denial...");
        await openAppSettings();
      };
    } else if (isRestricted) {
      message = l10n.cameraPermissionRestrictedText;
      onPressed = null;
    } else {
      message = l10n.cameraPermissionRequestText;
      buttonText = l10n.grantPermissionText;
      onPressed = _isRequestingPermission ? null : _requestPermission;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.no_photography_outlined, size: 70, color: Theme.of(context).colorScheme.error.withAlpha(200)),
            const SizedBox(height: 20),
            Text(message, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 25),
            if (onPressed != null && buttonText.isNotEmpty)
              ElevatedButton(
                onPressed: onPressed,
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
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70)
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