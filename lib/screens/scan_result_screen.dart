import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logging/logging.dart';

class ResultScreen extends StatefulWidget {
  final String code;

  const ResultScreen({super.key, required this.code});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final _log = Logger('ScannerResultsScreenState');
  Uri? _uri;

  @override
  void initState() {
    super.initState();
    _parseUri();
  }

  void _parseUri() {
    final Uri? parsedUri = Uri.tryParse(widget.code);
    if (parsedUri != null && parsedUri.hasScheme && (parsedUri.scheme == 'http' || parsedUri.scheme == 'https')) {
      setState(() {
        _uri = parsedUri;
      });
    }
  }

  Future<void> _launchURL(Uri url) async {
    try {
      bool launched = await launchUrl(url, mode: LaunchMode.externalApplication);
      if (!launched && mounted) {
        _showSnackBar('Could not launch $url');
      }
    } catch (e) {
      _log.severe("Error launching URL: $e");
      if (mounted) {
        _showSnackBar('Error launching link: ${e.toString()}');
      }
    }
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.code));
    _showSnackBar('Copied to Clipboard!');
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final bool isLink = _uri != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Result'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 100.0,
                ),
                const SizedBox(height: 20),
                Text(
                  'Scan Successful!',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: colorScheme.outline)
                  ),
                  child: SelectableText(
                    widget.code,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.copy),
                      label: const Text('Copy to Clipboard'),
                      onPressed: _copyToClipboard,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),

                    if (isLink) ...[
                      const SizedBox(height: 15),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.open_in_browser),
                        label: const Text('Open Link'),
                        onPressed: () => _launchURL(_uri!),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: colorScheme.secondary,
                          foregroundColor: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}