import 'package:flutter/material.dart';

class FileScreen extends StatelessWidget {
  const FileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Files'),
      ),
      body: const Center(
        child: Text(
          'File Scanner',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}