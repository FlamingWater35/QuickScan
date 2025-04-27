import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:logging/logging.dart';

class ResultScreen extends StatefulWidget {
  final String code;
  final BarcodeType type;

  const ResultScreen({
    super.key,
    required this.code,
    required this.type,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final _log = Logger('ScannerResultsScreenState');
  Uri? _launchableUri;
  Map<String, String>? _wifiCredentials;

  @override
  void initState() {
    super.initState();
    _parseDataBasedOnType();
  }

  void _parseDataBasedOnType() {
    switch (widget.type) {
      case BarcodeType.url:
      case BarcodeType.phone:
      case BarcodeType.email:
      case BarcodeType.sms:
        _launchableUri = Uri.tryParse(widget.code);
        if (_launchableUri?.scheme == null ||
            (_launchableUri!.scheme != 'http' && widget.type == BarcodeType.url) &&
            (_launchableUri!.scheme != 'https' && widget.type == BarcodeType.url) &&
             (_launchableUri!.scheme != 'tel' && widget.type == BarcodeType.phone) &&
             (_launchableUri!.scheme != 'mailto' && widget.type == BarcodeType.email) &&
             (_launchableUri!.scheme != 'sms' && widget.type == BarcodeType.sms)
            ) {
              _launchableUri = null;
              _log.severe("Warning: Parsed URI scheme doesn't match BarcodeType ${widget.type}");
            }
        break;
      case BarcodeType.wifi:
        _parseWifiCode(widget.code);
        break;
      case BarcodeType.contactInfo:
      case BarcodeType.geo:
      case BarcodeType.calendarEvent:
      case BarcodeType.isbn:
      case BarcodeType.product:
      case BarcodeType.text:
      case BarcodeType.driverLicense:
      case BarcodeType.unknown:
        break;
    }
     if (mounted) {
        setState(() {});
     }
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
        _wifiCredentials = credentials;
      }
    }
  }

  Future<void> _launchUriAction(Uri uri) async {
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

    IconData topIcon = Icons.check_circle;
    Color topIconColor = Colors.green;
    String titleText = 'Scan Successful!';
    List<Widget> actionButtons = [];

    actionButtons.add(
      ElevatedButton.icon(
        icon: const Icon(Icons.copy),
        label: const Text('Copy Raw Value'),
        onPressed: () => _copyToClipboard(widget.code, 'Raw value copied!'),
      )
    );

    switch (widget.type) {
      case BarcodeType.url:
        if (_launchableUri != null) {
          topIcon = Icons.link;
          topIconColor = colorScheme.primary;
          titleText = 'Link Found!';
          actionButtons.add(const SizedBox(height: 15));
          actionButtons.add(ElevatedButton.icon(
            icon: const Icon(Icons.open_in_browser),
            label: const Text('Open Link'),
            onPressed: () => _launchUriAction(_launchableUri!),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.secondary,
              foregroundColor: colorScheme.onSecondary,
            ),
          ));
        }
        break;

      case BarcodeType.phone:
        if (_launchableUri != null) {
          topIcon = Icons.phone;
          topIconColor = colorScheme.primary;
          titleText = 'Phone Number Found!';
          actionButtons.add(const SizedBox(height: 15));
          actionButtons.add(ElevatedButton.icon(
            icon: const Icon(Icons.phone_in_talk),
            label: const Text('Dial Number'),
            onPressed: () => _launchUriAction(_launchableUri!),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700], foregroundColor: Colors.white),
          ));
        }
        break;

      case BarcodeType.email:
        if (_launchableUri != null) {
          topIcon = Icons.email;
          topIconColor = colorScheme.primary;
          titleText = 'Email Address Found!';
          actionButtons.add(const SizedBox(height: 15));
          actionButtons.add(ElevatedButton.icon(
            icon: const Icon(Icons.email_outlined),
            label: const Text('Send Email'),
            onPressed: () => _launchUriAction(_launchableUri!),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[600], foregroundColor: Colors.white),
          ));
         }
        break;

      case BarcodeType.sms:
        if (_launchableUri != null) {
          topIcon = Icons.sms;
          topIconColor = colorScheme.primary;
          titleText = 'SMS Details Found!';
          actionButtons.add(const SizedBox(height: 15));
          actionButtons.add(ElevatedButton.icon(
            icon: const Icon(Icons.sms_outlined),
            label: const Text('Send SMS'),
            onPressed: () => _launchUriAction(_launchableUri!),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple[600], foregroundColor: Colors.white),
          ));
         }
        break;

      case BarcodeType.wifi:
        if (_wifiCredentials != null) {
          topIcon = Icons.wifi;
          topIconColor = colorScheme.primary;
          titleText = 'Wi-Fi Network Found!';
          actionButtons.add(const SizedBox(height: 15));
          actionButtons.add(ElevatedButton.icon(
            icon: const Icon(Icons.wifi_password),
            label: const Text('Copy Wi-Fi Info'),
            onPressed: _copyWifiCredentials,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[700], foregroundColor: Colors.white),
          ));
          actionButtons.add(Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              'Note: Paste copied info into Wi-Fi settings manually.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withAlpha(128)),
            ),
          ));
        }
        break;

      case BarcodeType.contactInfo:
        topIcon = Icons.contact_page;
        topIconColor = colorScheme.primary;
        titleText = 'Contact Info Found!';
        break;
      case BarcodeType.geo:
        topIcon = Icons.location_on;
        topIconColor = colorScheme.primary;
        titleText = 'Location Found!';
        break;
      case BarcodeType.calendarEvent:
        topIcon = Icons.event;
        topIconColor = colorScheme.primary;
        titleText = 'Calendar Event Found!';
        break;
      case BarcodeType.text:
        topIcon = Icons.article;
        topIconColor = colorScheme.primary;
        titleText = 'Text Found';
        break;
      case BarcodeType.isbn:
        topIcon = Icons.book;
        topIconColor = colorScheme.primary;
        titleText = 'ISBN Found';
        break;
      case BarcodeType.product:
        topIcon = Icons.inventory_2;
        topIconColor = colorScheme.primary;
        titleText = 'Product Code Found';
        break;
      case BarcodeType.driverLicense:
        topIcon = Icons.badge;
        topIconColor = colorScheme.primary;
        titleText = 'Driver License Found';
        break;
      case BarcodeType.unknown:
        break;
    }


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
                Icon(topIcon, color: topIconColor, size: 100.0),
                const SizedBox(height: 20),
                Text(
                  titleText,
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
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
                  children: actionButtons,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}