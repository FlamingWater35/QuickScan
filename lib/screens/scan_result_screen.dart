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
  Uri? _urlUri;
  Uri? _phoneNumberUri;
  Map<String, String>? _wifiCredentials;

  @override
  void initState() {
    super.initState();
    _parseCode();
  }

  void _parseCode() {
    final Uri? parsedUrl = Uri.tryParse(widget.code);
    if (parsedUrl != null && parsedUrl.hasScheme && (parsedUrl.scheme == 'http' || parsedUrl.scheme == 'https')) {
      setState(() {
        _urlUri = parsedUrl;
      });
      return;
    }

    if (parsedUrl != null && parsedUrl.hasScheme && parsedUrl.scheme == 'tel') {
      setState(() {
        _phoneNumberUri = parsedUrl;
      });
      return;
    }

    _parseWifiCode(widget.code);
  }

  void _parseWifiCode(String code) {
    if (code.startsWith('WIFI:')) {
      final Map<String, String> credentials = {};
      final String data = code.substring(5).replaceAll(';;', '');
      final List<String> parts = data.split(';');

      for (String part in parts) {
        if (part.isNotEmpty) {
          final List<String> keyValue = part.split(':');
          if (keyValue.length >= 2) {
            final String key = keyValue[0];
            final String value = keyValue.sublist(1).join(':');
            credentials[key] = value;
          }
        }
      }

      if (credentials.containsKey('S')) {
        setState(() {
          _wifiCredentials = credentials;
        });
      }
    }
  }

  Future<void> _launchUri(Uri uri) async {
    try {
      final mode = (uri.scheme == 'http' || uri.scheme == 'https')
        ? LaunchMode.externalApplication
        : LaunchMode.platformDefault;

      bool launched = await launchUrl(uri, mode: mode);
      if (!launched && mounted) {
        _showSnackBar('Could not perform action for $uri');
      }
    } catch (e) {
      _log.severe("Error launching URL: $e");
      if (mounted) {
        _showSnackBar('Error launching link: ${e.toString()}');
      }
    }
  }

  void _copyToClipboard(String text, String confirmationMessage) {
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar(confirmationMessage);
  }

  void _copyWifiCredentials() {
    if (_wifiCredentials == null) return;

    final ssid = _wifiCredentials!['S'] ?? 'N/A';
    final password = _wifiCredentials!['P'] ?? 'N/A (maybe open network)';
    final type = _wifiCredentials!['T'] ?? 'N/A';

    final String credentialsText = 'Wi-Fi Network:\nSSID: $ssid\nPassword: $password\nSecurity Type: $type';

    _copyToClipboard(credentialsText, 'Wi-Fi credentials copied to clipboard!');
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final bool isWebLink = _urlUri != null;
    final bool isPhoneNumber = _phoneNumberUri != null;
    final bool isWifiNetwork = _wifiCredentials != null;

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
                Icon(
                  isWebLink
                      ? Icons.link
                      : isPhoneNumber
                          ? Icons.phone
                          : isWifiNetwork
                              ? Icons.wifi
                              : Icons.check_circle,
                  color: isWifiNetwork || isPhoneNumber || isWebLink
                    ? colorScheme.primary
                    : Colors.green,
                  size: 100.0,
                ),
                const SizedBox(height: 20),
                Text(
                  isWebLink
                    ? 'Link Found!'
                    : isPhoneNumber
                      ? 'Phone Number Found!'
                      : isWifiNetwork
                        ? 'Wi-Fi Network Found!'
                        : 'Scan Successful!',
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
                      label: const Text('Copy Raw Value'),
                      onPressed: () => _copyToClipboard(widget.code, 'Raw value copied!'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 15),

                    if (isWebLink)
                      ElevatedButton.icon(
                        icon: const Icon(Icons.open_in_browser),
                        label: const Text('Open Link'),
                        onPressed: () => _launchUri(_urlUri!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.secondary,
                          foregroundColor: colorScheme.onSecondary,
                        ),
                      ),

                    if (isPhoneNumber)
                        ElevatedButton.icon(
                        icon: const Icon(Icons.phone_in_talk),
                        label: const Text('Dial Number'),
                        onPressed: () => _launchUri(_phoneNumberUri!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          foregroundColor: Colors.white,
                        ),
                      ),

                    if (isWifiNetwork)
                      ElevatedButton.icon(
                        icon: const Icon(Icons.wifi_password),
                        label: const Text('Copy Wi-Fi Info'),
                        onPressed: _copyWifiCredentials,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            foregroundColor: Colors.white,
                        ),
                      ),

                    if (isWifiNetwork)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Note: Due to system restrictions, you need to paste the copied info into your device Wi-Fi settings manually.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withAlpha(128)),
                        ),
                      ),

                      if (isWebLink || isPhoneNumber || isWifiNetwork)
                        const SizedBox(height: 15),

                  ].where((widget) => widget is! SizedBox || (widget.height != null)).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}