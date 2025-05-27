import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:logging/logging.dart';
import '/l10n/app_localizations.dart';

import '/screens/scan_result_screen.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({super.key});

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  bool _isLoading = false;
  String _loadingMessage = "";
  final _log = Logger('FileScannerScreenState');
  final ImagePicker _picker = ImagePicker();
  final MobileScannerController _scannerController = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
  );

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  Future<void> _pickAndScanImage() async {
    final l10n = AppLocalizations.of(context);

    if (_isLoading) return;

    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _loadingMessage = l10n.chooseImageMessage;
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
        _loadingMessage = l10n.processingMessage;
      });
      await Future.delayed(const Duration(milliseconds: 300));

      if (!mounted) return;

      setState(() {
        _loadingMessage = l10n.scanningImageMessage;
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
          _showSnackBar(l10n.noCodeFoundMessage);
        }
      } else {
        _showSnackBar(l10n.noQrCodeFoundMessage);
      }
    } catch (e) {
      _log.severe('Error scanning image: $e');
      if (mounted) {
        _showSnackBar(l10n.imageScanError(e.toString()));
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
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.fileScreenTitle),
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
                      label: Text(l10n.pickImageButtonText, textAlign: TextAlign.center),
                      onPressed: _isLoading ? null : _pickAndScanImage,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        textStyle: const TextStyle(fontSize: 16)
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        l10n.fileScreenInstruction,
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