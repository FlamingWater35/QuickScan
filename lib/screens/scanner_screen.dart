import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:logging/logging.dart';
import 'scan_result_screen.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> with WidgetsBindingObserver {
  final _log = Logger('QRScannerScreenState');
  final MobileScannerController controller = MobileScannerController(
    // formats: [BarcodeFormat.qrCode], // Limit to QR codes
    // detectionSpeed: DetectionSpeed.normal, // Adjust speed
    // facing: CameraFacing.back, // Default is back
    // torchEnabled: false, // Default is false
  );

  StreamSubscription<Object?>? _subscription;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _listenForBarcodes();
  }

  void _listenForBarcodes() {
    _subscription?.cancel();
    _subscription = controller.barcodes.listen(_handleBarcode);
  }

  Future<void> _handleBarcode(BarcodeCapture capture) async {
    if (_isNavigating || !mounted) {
      return;
    }

    if (capture.barcodes.isNotEmpty) {
      final Barcode barcode = capture.barcodes.first;
      final String? code = barcode.rawValue;

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
            builder: (context) => ResultScreen(code: code),
          ),
        );

        if (mounted) {
          setState(() {
            _isNavigating = false;
          });
          await Future.delayed(const Duration(milliseconds: 100));

          if(mounted){
            _listenForBarcodes();
            if (!controller.value.isRunning && controller.value.isInitialized) {
              try {
                await controller.start();
              } catch (e) {
                _log.severe("Error restarting scanner: $e");
                if(mounted){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error restarting camera: $e')),
                  );
                }
              }
            } else if (!controller.value.isInitialized && mounted) {
              try {
                await controller.start();
                _listenForBarcodes();
              } catch(e) {
                _log.severe("Error starting scanner initially: $e");
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error starting camera: $e')),
                  );
                }
              }
            }
          }
        } else {
          _isNavigating = false;
        }
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) {
      return;
    }

    if (_isNavigating) {
      return;
    }

    if (!controller.value.isInitialized) {
      if (state == AppLifecycleState.resumed) {
        _tryStartScanner();
      }
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        _pauseScanner();
        break;
      case AppLifecycleState.resumed:
        _resumeScanner();
        break;
      case AppLifecycleState.inactive:
        _pauseScanner();
        break;
    }
  }

  Future<void> _tryStartScanner() async {
    if (!mounted) return;
    try {
      if (!controller.value.isRunning) {
        await controller.start();
        _listenForBarcodes();
      }
    } catch (e) {
      _log.severe("Error starting scanner: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to start camera: ${e.toString()}')),
        );
      }
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
    if (mounted) {
      _listenForBarcodes();
      if (!controller.value.isRunning && controller.value.isInitialized) {
        try {
          await controller.start();
        } catch (e) {
          _log.severe("Error restarting scanner: $e");
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error restarting camera: $e')),
              );
            }
        }
      } else if (!controller.value.isInitialized) {
        await _tryStartScanner();
      }
    }
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await controller.dispose();
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
              if (error.errorCode == MobileScannerErrorCode.permissionDenied) {
                return const Center(
                  child: Text('Camera permission denied. Please grant permission in settings.'),
                );
              } else {
                return Center(
                  child: Text('Scanner error: ${error.errorDetails}'),
                );
              }
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