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
    return 'Could not perform action for $uri';
  }

  @override
  String urlLaunchError(String error) {
    return 'Error launching link: $error';
  }

  @override
  String get scanResultTitle => 'Scan Result';

  @override
  String get scanSuccessful => 'Scan Successful!';

  @override
  String get copyRawValue => 'Copy Raw Value';

  @override
  String get rawValueCopied => 'Raw value copied!';

  @override
  String get linkFound => 'Link Found!';

  @override
  String get openLink => 'Open Link';

  @override
  String get phoneNumberFound => 'Phone Number Found!';

  @override
  String get dialNumber => 'Dial Number';

  @override
  String get emailAddressFound => 'Email Address Found!';

  @override
  String get sendEmail => 'Send Email';

  @override
  String get copyEmailAddress => 'Copy Email Address';

  @override
  String get emailAddressCopied => 'Email address copied!';

  @override
  String get smsDetailsFound => 'SMS Details Found!';

  @override
  String get sendSms => 'Send SMS';

  @override
  String get wifiNetworkFound => 'Wi-Fi Network Found!';

  @override
  String get copyWifiInfo => 'Copy Wi-Fi Info';

  @override
  String get wifiCredentialsCopied => 'Wi-Fi credentials copied to clipboard!';

  @override
  String get wifiManualNote => 'Note: Paste copied info into Wi-Fi settings manually.';

  @override
  String get contactInfoFound => 'Contact Info Found!';

  @override
  String get exportVCard => 'Export vCard (.vcf)';

  @override
  String get vCardSaved => 'vCard saved successfully!';

  @override
  String get vCardExportCancelled => 'vCard export cancelled or failed.';

  @override
  String vCardExportError(String error) {
    return 'Error exporting vCard: $error';
  }

  @override
  String get locationFound => 'Location Found!';

  @override
  String get openInMaps => 'Open in Maps';

  @override
  String get calendarEventFound => 'Calendar Event Found!';

  @override
  String get textFound => 'Text Found';

  @override
  String get isbnFound => 'ISBN Found';

  @override
  String get productCodeFound => 'Product Code Found';

  @override
  String get driverLicenseFound => 'Driver License Found';

  @override
  String get contactInfoLabel => 'Contact Info (vCard):';

  @override
  String get saveContactDialogTitle => 'Save Contact';

  @override
  String get noneLabel => '(none)';

  @override
  String get calendarEventLabel => 'Calendar Event (iCal):';

  @override
  String get driverLicenseLabel => 'Driver License Data:';

  @override
  String get rawDataLabel => 'Raw Data:';

  @override
  String get nameLabel => 'Name:';

  @override
  String get organizationLabel => 'Organization:';

  @override
  String get titleLabel => 'Title:';

  @override
  String get phoneLabel => 'Phone:';

  @override
  String get emailLabel => 'Email:';

  @override
  String get addressLabel => 'Address:';

  @override
  String get websiteLabel => 'Website:';

  @override
  String get noteLabel => 'Note:';

  @override
  String get wifiNetworkLabel => 'Wi-Fi Network:';

  @override
  String get ssidLabel => 'SSID:';

  @override
  String get typeLabel => 'Type:';

  @override
  String get passwordLabel => 'Password:';

  @override
  String get noPasswordLabel => 'N/A (maybe no password)';

  @override
  String get hiddenLabel => 'Hidden:';

  @override
  String get toLabel => 'To:';

  @override
  String get subjectLabel => 'Subject:';

  @override
  String get bodyLabel => 'Body:';

  @override
  String get latitudeLabel => 'Latitude:';

  @override
  String get longitudeLabel => 'Longitude:';

  @override
  String get altitudeLabel => 'Altitude:';

  @override
  String get labelLabel => 'Label:';

  @override
  String get noVCardData => 'No vCard data to export.';

  @override
  String get hidePasswordTooltip => 'Hide password';

  @override
  String get showPasswordTooltip => 'Show password';

  @override
  String get yesLabel => 'Yes';

  @override
  String get noLabel => 'No';

  @override
  String get errorRequestingPermission => 'Error requesting permission.';

  @override
  String get errorReceivingBarcodeData => 'Error receiving barcode data.';

  @override
  String get failedToSetUpBarcodeListener => 'Failed to set up barcode listener.';

  @override
  String get couldNotToggleFlash => 'Could not toggle flash.';

  @override
  String get couldNotSwitchCamera => 'Could not switch camera.';

  @override
  String cameraStartError(String error) {
    return 'Failed to start camera. Error: $error';
  }

  @override
  String get cameraGenericError => 'An unexpected error occurred while starting the camera.';

  @override
  String get cameraPermissionDeniedInSettings => 'Camera permission denied. Please grant permission in settings.';

  @override
  String get cameraPermissionDeniedOrRevoked => 'Camera permission was denied or revoked.\nPlease grant permission in app settings.';

  @override
  String get cameraNotSupported => 'Camera is unavailable or not supported on this device.';

  @override
  String get fileScreenTitle => 'Scan from File';

  @override
  String get pickImageButtonText => 'Pick Image & Scan';

  @override
  String get fileScreenInstruction => 'Select an image containing a QR code from your gallery.';

  @override
  String get chooseImageMessage => 'Choose an image...';

  @override
  String get processingMessage => 'Processing...';

  @override
  String get scanningImageMessage => 'Scanning image...';

  @override
  String get noCodeFoundMessage => 'No readable code found in the QR code.';

  @override
  String get noQrCodeFoundMessage => 'No QR code found in the selected image.';

  @override
  String imageScanError(String error) {
    return 'Error scanning image: $error';
  }

  @override
  String get settingsScreenTitle => 'Settings';

  @override
  String get appearanceSectionTitle => 'Appearance';

  @override
  String get applicationSectionTitle => 'Application';

  @override
  String get lightThemeLabel => 'Light';

  @override
  String get darkThemeLabel => 'Dark';

  @override
  String get systemThemeLabel => 'System';

  @override
  String get checkForUpdatesLabel => 'Check for Updates';

  @override
  String get versionLoadingText => 'Loading...';

  @override
  String get versionErrorText => 'Error loading version';

  @override
  String versionFormat(String version, String buildNumber) {
    return 'Version $version ($buildNumber)';
  }

  @override
  String get updateScreenTitle => 'App Update';

  @override
  String get checkingForUpdates => 'Checking for updates...';

  @override
  String get updateAvailable => 'Update Available!';

  @override
  String currentVersionLabel(String version) {
    return 'Current version: $version';
  }

  @override
  String newVersionLabel(String version) {
    return 'New version: $version';
  }

  @override
  String latestVersionLabel(String version) {
    return '(Latest available: $version)';
  }

  @override
  String get downloadAndInstallButton => 'Download & Install';

  @override
  String downloadingUpdate(String version) {
    return 'Downloading update ($version)...';
  }

  @override
  String downloadProgress(String progress) {
    return '$progress%';
  }

  @override
  String get startingInstall => 'Starting install...';

  @override
  String get updateFailed => 'Update Failed';

  @override
  String get retryCheckButton => 'Retry Check';

  @override
  String get upToDate => 'You\'re up to date!';

  @override
  String get checkAgainButton => 'Check Again';

  @override
  String get installDialogShown => 'Install dialog shown';

  @override
  String get noUpdateAvailable => 'No new update available.';

  @override
  String get unexpectedErrorDuringCheck => 'An unexpected error occurred during check.';

  @override
  String get updateInfoIncomplete => 'Update information is incomplete.';

  @override
  String get downloadFailed => 'Download failed. Check connection and permissions.';

  @override
  String get installationFailed => 'Could not start installation. Check permissions.';
}
