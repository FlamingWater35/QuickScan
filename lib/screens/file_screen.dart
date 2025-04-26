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
  bool _isScanning = false;

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  Future<void> _pickAndScanImage() async {
    if (_isScanning) return;

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile == null) {
        return;
      }

      if (!mounted) return;

      setState(() {
        _isScanning = true;
      });

      final BarcodeCapture? capture = await _scannerController.analyzeImage(pickedFile.path);

      if (!mounted) return;

      if (capture != null && capture.barcodes.isNotEmpty) {
        final Barcode barcode = capture.barcodes.first;
        final String? code = barcode.rawValue;

        if (code != null) {
          _log.fine('Barcode found in image: $code');
          await Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => ResultScreen(code: code),
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
          _isScanning = false;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isScanning)
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: CircularProgressIndicator(),
              ),
            ElevatedButton.icon(
              icon: const Icon(Icons.image_search),
              label: const Text('Pick Image & Scan'),
              onPressed: _isScanning ? null : _pickAndScanImage,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 16)
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'Select an image containing a QR code.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}