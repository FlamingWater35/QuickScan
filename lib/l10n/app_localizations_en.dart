// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Simple Scanner';

  @override
  String get scannerTabLabel => 'Camera';

  @override
  String get fileTabLabel => 'File';

  @override
  String get settingsTabLabel => 'Settings';

  @override
  String get scannerTabTitle => 'Scan QR Code';

  @override
  String get scannerTabScanText => 'Align QR code within frame to scan';

  @override
  String get cameraPermissionRequestText => 'Camera permission is required to scan QR codes. Please grant permission.';

  @override
  String get cameraPermissionRestrictedText => 'Camera access is restricted (e.g., by device policy or parental controls). Scanning is unavailable.';

  @override
  String get cameraPermissionPermanentlyDeniedText => 'Camera permission is permanently denied. Please enable it in app settings to scan QR codes.';

  @override
  String get openSettingsText => 'Open Settings';

  @override
  String get grantPermissionText => 'Grant Permission';

  @override
  String couldNotPerformActionText(String uri) {
    return 'Could not perform action for \"$uri\"';
  }

  @override
  String genericErrorText(String errorCause, String error) {
    return 'Error \"$errorCause\": \"$error\"';
  }
}
