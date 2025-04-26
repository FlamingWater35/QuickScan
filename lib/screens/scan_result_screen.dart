import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultScreen extends StatelessWidget {
  final String code;

  const ResultScreen({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Result'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Scanned Code:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              
              SelectableText(
                code,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              ElevatedButton.icon(
                icon: const Icon(Icons.copy),
                label: const Text('Copy to Clipboard'),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to Clipboard!')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}