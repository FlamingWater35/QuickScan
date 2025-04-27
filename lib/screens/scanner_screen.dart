import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:logging/logging.dart';

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
  bool _hasFatalError = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> startCamera() async {
    _isCameraExplicitlyStopped = false;
    _hasFatalError = false;
    if (controller.value.isRunning || !mounted) return;
    _log.fine("QRScannerScreen: Received startCamera command");
    await _resumeScanner();
  }

  Future<void> stopCamera() async {
    _isCameraExplicitlyStopped = true;
    if (!controller.value.isRunning || !mounted) return;
    _log.fine("QRScannerScreen: Received stopCamera command");
    await _pauseScanner();
  }

  void _listenForBarcodes() {
    if (!mounted || !controller.value.isInitialized || !controller.value.isRunning) {
      _log.severe("QRScannerScreen: Conditions not met to listen for barcodes.");
      return;
    }
    _subscription?.cancel();
    _subscription = null;

    _log.fine("QRScannerScreen: Starting to listen for barcodes.");
    try {
      _subscription = controller.barcodes.listen(_handleBarcode, onError: (error) {
        _log.severe("QRScannerScreenState: Error listening to barcode stream: $error");
        _showErrorSnackBar("Error receiving barcode data.");
      });
    } catch (e) {
      _log.severe("QRScannerScreenState: Exception setting up barcode listener: $e");
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
        setState(() {
          _isNavigating = true;
        });

        _log.info('Barcode found! $code');

        await _subscription?.cancel();
        _subscription = null;

        try {
          if (controller.value.isRunning) {
            await controller.stop();
          }
        } catch (e) {
          _log.severe("Error stopping scanner: $e");
        }

        if (!mounted) {
          setState(() { _isNavigating = false; });
          return;
        }

        await Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) => ResultScreen(code: code, type: type),
          ),
        );

        if (mounted) {
          setState(() {
            _isNavigating = false;
          });
          await Future.delayed(const Duration(milliseconds: 100));
          if (mounted && !_isCameraExplicitlyStopped) {
            await _resumeScanner();
          }
        } else {
          _isNavigating = false;
        }
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) return;
    if (_isNavigating) return;

    if (_hasFatalError && state == AppLifecycleState.resumed) {
      _log.severe("QRScannerScreenState: App resumed but fatal error occurred, not resuming scanner.");
      return;
    }

    switch (state) {
      case AppLifecycleState.resumed:
        if (!_isCameraExplicitlyStopped) {
          _log.fine("QRScannerScreenState: App resumed, resuming scanner.");
          _resumeScanner();
        } else {
          _log.severe("QRScannerScreenState: App resumed but camera explicitly stopped or has error, not resuming.");
        }
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        _log.fine("QRScannerScreenState: App lifecycle changed to $state, pausing scanner.");
        _pauseScanner();
        break;
    }
  }

  Future<void> _pauseScanner() async {
    await _subscription?.cancel();
    _subscription = null;
    if (controller.value.isRunning) {
      try {
        await controller.stop();
      } catch(e) {
        _log.severe("Error stopping scanner: $e");
      }
    }
  }

  Future<void> _resumeScanner() async {
    if (!mounted || _isNavigating || _isCameraExplicitlyStopped || _hasFatalError) {
      _log.severe("QRScannerScreenState: Resume conditions not met (mounted:$mounted, navigating:$_isNavigating, explicitStop:$_isCameraExplicitlyStopped, error:$_hasFatalError)");
      return;
    }
    _log.fine("QRScannerScreen: Resuming scanner...");

    if (!controller.value.isRunning) {
      bool startSuccess = false;
      try {
        _log.fine("QRScannerScreenState: Calling controller.start()...");
        await controller.start();
        if (!mounted) return;
        if (controller.value.isRunning && controller.value.error == null) {
          _log.fine("QRScannerScreenState: controller.start() confirmed running and no error.");
          startSuccess = true;
        } else {
          _log.warning("QRScannerScreenState: controller.start() finished, but controller state is not running (${controller.value.isRunning}) or has error (${controller.value.error}, code: ${controller.value.error?.errorCode})");
          _hasFatalError = true;
          _showErrorSnackBar("Failed to start camera. Check permissions or camera availability.");
        }
      } on MobileScannerException catch (e) {
        _log.severe("QRScannerScreenState: MobileScannerException during start: ${e.errorCode} - ${e.errorDetails}");
        setState(() { _hasFatalError = true; });
        _showErrorSnackBar("Camera Error: ${e.errorDetails ?? e.errorCode.toString()}");
        if (e.errorCode == MobileScannerErrorCode.permissionDenied) {
          _log.severe("QRScannerScreenState: Camera permission denied.");
        }
      } catch (e) {
        _log.severe("QRScannerScreenState: Generic error during controller.start(): $e");
        _hasFatalError = true;
        _showErrorSnackBar("Failed to start camera: $e");
      }

      if (startSuccess && mounted) {
        _listenForBarcodes();
      }
    } else {
      _log.fine("QRScannerScreenState: Scanner already running, ensuring listener is active.");
      if (mounted) {
        _listenForBarcodes();
      }
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      )
    );
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    await _subscription?.cancel();
    _subscription = null;
    await controller.dispose();
    super.dispose();
    _log.fine("QRScannerScreenState: Disposed.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, state, child) {
              if (!state.isInitialized || !state.isRunning) {
                return const SizedBox.shrink();
              }
              final torchState = state.torchState;
              switch (torchState) {
                case TorchState.off:
                  return IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.flash_off),
                    tooltip: 'Turn on flash',
                    onPressed: () => controller.toggleTorch(),
                  );
                case TorchState.on:
                  return IconButton(
                    color: Colors.yellow,
                    icon: const Icon(Icons.flash_on),
                    tooltip: 'Turn off flash',
                    onPressed: () => controller.toggleTorch(),
                  );
                case TorchState.auto:
                  return IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.flash_auto),
                    tooltip: 'Flash is auto',
                    onPressed: () => controller.toggleTorch(),
                  );
                case TorchState.unavailable:
                  return const IconButton(
                    color: Colors.grey,
                    icon: Icon(Icons.no_flash),
                    tooltip: 'Flash unavailable',
                    onPressed: null,
                  );
              }
            },
          ),

          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, state, child) {
              if (!state.isInitialized || !state.isRunning || (state.availableCameras ?? 0) <= 1 ) {
                return const SizedBox.shrink();
              }
              return IconButton(
                color: Colors.white,
                icon: const Icon(Icons.switch_camera),
                tooltip: 'Switch camera',
                onPressed: () => controller.switchCamera(),
              );
            }
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            overlayBuilder: (context, constraints) {
              return Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
             },
            errorBuilder: (context, error, child) {
              String errorMessage = 'Camera Error';
              if (error.errorCode == MobileScannerErrorCode.permissionDenied) {
                errorMessage = 'Camera permission denied.\nPlease grant permission in app settings.';
              } else {
                errorMessage = 'Error: ${error.errorDetails ?? error.errorCode.toString()}';
              }
                _log.severe("MobileScanner errorBuilder: ${error.errorCode}");
              
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 60),
                      const SizedBox(height: 15),
                      Text(errorMessage, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              );
            },
            placeholderBuilder: (context, child) {
              return const Center(child: CircularProgressIndicator());
            },
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(128),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Align QR code within frame to scan',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}