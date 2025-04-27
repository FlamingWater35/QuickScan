import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:logging/logging.dart';

import '/screens/scan_result_screen.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({super.key});

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  final _log = Logger('FileScannerScreenState');
  final MobileScannerController _scannerController = MobileScannerController(
    // formats: [BarcodeFormat.qrCode],
  );
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  String _loadingMessage = "";

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  Future<void> _pickAndScanImage() async {
    if (_isLoading) return;

    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _loadingMessage = "Choose an image...";
    });

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile == null) {
        if (mounted) {
          setState(() { _isLoading = false; });
        }
        return;
      }

      if (!mounted) return;

      setState(() {
        _loadingMessage = "Processing...";
      });
      await Future.delayed(const Duration(milliseconds: 300));

      if (!mounted) return;

      setState(() {
        _loadingMessage = "Scanning image...";
      });
      final BarcodeCapture? capture = await _scannerController.analyzeImage(pickedFile.path);

      if (!mounted) return;

      if (capture != null && capture.barcodes.isNotEmpty) {
        final Barcode barcode = capture.barcodes.first;
        final String? code = barcode.rawValue;
        final BarcodeType type = barcode.type;

        if (code != null) {
          _log.fine('Barcode found in image: $code');
          await Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => ResultScreen(code: code, type: type),
            ),
          );
        } else {
          _showSnackBar('No readable code found in the QR code.');
        }
      } else {
        _showSnackBar('No QR code found in the selected image.');
      }
    } catch (e) {
      _log.severe('Error scanning image: $e');
      if (mounted) {
        _showSnackBar('Error scanning image: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _loadingMessage = "";
        });
      }
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan from File'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                Column(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 15),
                    Text(
                      _loadingMessage,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                  ],
                )
              else
                Column(
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.image_search),
                      label: const Text('Pick Image & Scan'),
                      onPressed: _isLoading ? null : _pickAndScanImage,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        textStyle: const TextStyle(fontSize: 16)
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Select an image containing a QR code from your gallery.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}