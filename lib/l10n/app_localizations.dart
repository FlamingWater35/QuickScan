import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Simple Scanner'**
  String get appTitle;

  /// Label for the camera tab in the app's navigation
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get scannerTabLabel;

  /// Label for the file tab in the app's navigation
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get fileTabLabel;

  /// Label for the settings tab in the app's navigation
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTabLabel;

  /// Title displayed on the QR code scanning screen
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scannerTabTitle;

  /// Instruction text shown on the QR code scanning screen
  ///
  /// In en, this message translates to:
  /// **'Align QR code within frame to scan'**
  String get scannerTabScanText;

  /// Message prompting the user to grant camera permission for scanning
  ///
  /// In en, this message translates to:
  /// **'Camera permission is required to scan QR codes. Please grant permission.'**
  String get cameraPermissionRequestText;

  /// Message shown when camera access is restricted by external policies
  ///
  /// In en, this message translates to:
  /// **'Camera access is restricted (e.g., by device policy or parental controls). Scanning is unavailable.'**
  String get cameraPermissionRestrictedText;

  /// Message shown when camera permission is permanently denied, directing user to app settings
  ///
  /// In en, this message translates to:
  /// **'Camera permission is permanently denied. Please enable it in app settings to scan QR codes.'**
  String get cameraPermissionPermanentlyDeniedText;

  /// Button text to open device settings for enabling permissions
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettingsText;

  /// Button text to request permission from the user
  ///
  /// In en, this message translates to:
  /// **'Grant Permission'**
  String get grantPermissionText;

  /// Error message when an action fails for a given URI
  ///
  /// In en, this message translates to:
  /// **'Could not perform action for {uri}'**
  String couldNotPerformActionText(String uri);

  /// Error message when launching a URL fails
  ///
  /// In en, this message translates to:
  /// **'Error launching link: {error}'**
  String urlLaunchError(String error);

  /// Title for the scan result screen
  ///
  /// In en, this message translates to:
  /// **'Scan Result'**
  String get scanResultTitle;

  /// Message displayed when a QR code is successfully scanned
  ///
  /// In en, this message translates to:
  /// **'Scan Successful!'**
  String get scanSuccessful;

  /// Button text to copy the raw data from a scanned QR code
  ///
  /// In en, this message translates to:
  /// **'Copy Raw Value'**
  String get copyRawValue;

  /// Confirmation message when raw QR code data is copied to clipboard
  ///
  /// In en, this message translates to:
  /// **'Raw value copied!'**
  String get rawValueCopied;

  /// Message indicating a URL was found in the scanned QR code
  ///
  /// In en, this message translates to:
  /// **'Link Found!'**
  String get linkFound;

  /// Button text to open a URL found in the QR code
  ///
  /// In en, this message translates to:
  /// **'Open Link'**
  String get openLink;

  /// Message indicating a phone number was found in the scanned QR code
  ///
  /// In en, this message translates to:
  /// **'Phone Number Found!'**
  String get phoneNumberFound;

  /// Button text to initiate a call to the phone number found
  ///
  /// In en, this message translates to:
  /// **'Dial Number'**
  String get dialNumber;

  /// Message indicating an email address was found in the scanned QR code
  ///
  /// In en, this message translates to:
  /// **'Email Address Found!'**
  String get emailAddressFound;

  /// Button text to compose an email to the found email address
  ///
  /// In en, this message translates to:
  /// **'Send Email'**
  String get sendEmail;

  /// Button text to copy the email address to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy Email Address'**
  String get copyEmailAddress;

  /// Confirmation message when the email address is copied to clipboard
  ///
  /// In en, this message translates to:
  /// **'Email address copied!'**
  String get emailAddressCopied;

  /// Message indicating SMS details were found in the scanned QR code
  ///
  /// In en, this message translates to:
  /// **'SMS Details Found!'**
  String get smsDetailsFound;

  /// Button text to send an SMS using the found details
  ///
  /// In en, this message translates to:
  /// **'Send SMS'**
  String get sendSms;

  /// Message indicating Wi-Fi network details were found in the scanned QR code
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi Network Found!'**
  String get wifiNetworkFound;

  /// Button text to copy Wi-Fi network credentials to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy Wi-Fi Info'**
  String get copyWifiInfo;

  /// Confirmation message when Wi-Fi credentials are copied
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi credentials copied to clipboard!'**
  String get wifiCredentialsCopied;

  /// Instruction to manually paste Wi-Fi credentials into device settings
  ///
  /// In en, this message translates to:
  /// **'Note: Paste copied info into Wi-Fi settings manually.'**
  String get wifiManualNote;

  /// Message indicating contact information was found in the scanned QR code
  ///
  /// In en, this message translates to:
  /// **'Contact Info Found!'**
  String get contactInfoFound;

  /// Button text to export contact information as a vCard file
  ///
  /// In en, this message translates to:
  /// **'Export vCard (.vcf)'**
  String get exportVCard;

  /// Confirmation message when a vCard is successfully saved
  ///
  /// In en, this message translates to:
  /// **'vCard saved successfully!'**
  String get vCardSaved;

  /// Message when vCard export is cancelled or fails
  ///
  /// In en, this message translates to:
  /// **'vCard export cancelled or failed.'**
  String get vCardExportCancelled;

  /// Error message when vCard export fails
  ///
  /// In en, this message translates to:
  /// **'Error exporting vCard: {error}'**
  String vCardExportError(String error);

  /// Message indicating geographic coordinates were found in the scanned QR code
  ///
  /// In en, this message translates to:
  /// **'Location Found!'**
  String get locationFound;

  /// Button text to open the found location in a maps application
  ///
  /// In en, this message translates to:
  /// **'Open in Maps'**
  String get openInMaps;

  /// Message indicating a calendar event was found in the scanned QR code
  ///
  /// In en, this message translates to:
  /// **'Calendar Event Found!'**
  String get calendarEventFound;

  /// Message indicating plain text was found in the scanned QR code
  ///
  /// In en, this message translates to:
  /// **'Text Found'**
  String get textFound;

  /// Message indicating an ISBN was found in the scanned QR code
  ///
  /// In en, this message translates to:
  /// **'ISBN Found'**
  String get isbnFound;

  /// Message indicating a product code was found in the scanned QR code
  ///
  /// In en, this message translates to:
  /// **'Product Code Found'**
  String get productCodeFound;

  /// Message indicating driver license data was found in the scanned QR code
  ///
  /// In en, this message translates to:
  /// **'Driver License Found'**
  String get driverLicenseFound;

  /// Label for contact information section in scan results
  ///
  /// In en, this message translates to:
  /// **'Contact Info (vCard):'**
  String get contactInfoLabel;

  /// Title for the dialog to save contact information
  ///
  /// In en, this message translates to:
  /// **'Save Contact'**
  String get saveContactDialogTitle;

  /// Label used when no data is available for a field
  ///
  /// In en, this message translates to:
  /// **'(none)'**
  String get noneLabel;

  /// Label for calendar event section in scan results
  ///
  /// In en, this message translates to:
  /// **'Calendar Event (iCal):'**
  String get calendarEventLabel;

  /// Label for driver license data section in scan results
  ///
  /// In en, this message translates to:
  /// **'Driver License Data:'**
  String get driverLicenseLabel;

  /// Label for raw QR code data section in scan results
  ///
  /// In en, this message translates to:
  /// **'Raw Data:'**
  String get rawDataLabel;

  /// Label for name field in contact information
  ///
  /// In en, this message translates to:
  /// **'Name:'**
  String get nameLabel;

  /// Label for organization field in contact information
  ///
  /// In en, this message translates to:
  /// **'Organization:'**
  String get organizationLabel;

  /// Label for job title field in contact information
  ///
  /// In en, this message translates to:
  /// **'Title:'**
  String get titleLabel;

  /// Label for phone number field in contact information
  ///
  /// In en, this message translates to:
  /// **'Phone:'**
  String get phoneLabel;

  /// Label for email address field in contact information
  ///
  /// In en, this message translates to:
  /// **'Email:'**
  String get emailLabel;

  /// Label for address field in contact information
  ///
  /// In en, this message translates to:
  /// **'Address:'**
  String get addressLabel;

  /// Label for website field in contact information
  ///
  /// In en, this message translates to:
  /// **'Website:'**
  String get websiteLabel;

  /// Label for note field in contact information
  ///
  /// In en, this message translates to:
  /// **'Note:'**
  String get noteLabel;

  /// Label for Wi-Fi network section in scan results
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi Network:'**
  String get wifiNetworkLabel;

  /// Label for Wi-Fi network SSID field
  ///
  /// In en, this message translates to:
  /// **'SSID:'**
  String get ssidLabel;

  /// Label for Wi-Fi network type field
  ///
  /// In en, this message translates to:
  /// **'Type:'**
  String get typeLabel;

  /// Label for Wi-Fi network password field
  ///
  /// In en, this message translates to:
  /// **'Password:'**
  String get passwordLabel;

  /// Label used when no Wi-Fi password is provided
  ///
  /// In en, this message translates to:
  /// **'N/A (maybe no password)'**
  String get noPasswordLabel;

  /// Label for Wi-Fi network hidden status field
  ///
  /// In en, this message translates to:
  /// **'Hidden:'**
  String get hiddenLabel;

  /// Label for recipient field in SMS or email details
  ///
  /// In en, this message translates to:
  /// **'To:'**
  String get toLabel;

  /// Label for subject field in email or calendar event
  ///
  /// In en, this message translates to:
  /// **'Subject:'**
  String get subjectLabel;

  /// Label for body field in SMS or email details
  ///
  /// In en, this message translates to:
  /// **'Body:'**
  String get bodyLabel;

  /// Label for latitude field in location data
  ///
  /// In en, this message translates to:
  /// **'Latitude:'**
  String get latitudeLabel;

  /// Label for longitude field in location data
  ///
  /// In en, this message translates to:
  /// **'Longitude:'**
  String get longitudeLabel;

  /// Label for altitude field in location data
  ///
  /// In en, this message translates to:
  /// **'Altitude:'**
  String get altitudeLabel;

  /// Label for generic label field in scan results
  ///
  /// In en, this message translates to:
  /// **'Label:'**
  String get labelLabel;

  /// Message shown when there is no vCard data available to export
  ///
  /// In en, this message translates to:
  /// **'No vCard data to export.'**
  String get noVCardData;

  /// Tooltip text for hiding Wi-Fi password
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePasswordTooltip;

  /// Tooltip text for showing Wi-Fi password
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPasswordTooltip;

  /// Label for affirmative response
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesLabel;

  /// Label for negative response
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noLabel;

  /// Error message shown when permission request fails
  ///
  /// In en, this message translates to:
  /// **'Error requesting permission.'**
  String get errorRequestingPermission;

  /// Error message shown when there is an error listening to barcode stream
  ///
  /// In en, this message translates to:
  /// **'Error receiving barcode data.'**
  String get errorReceivingBarcodeData;

  /// Error message shown when setting up the barcode listener fails
  ///
  /// In en, this message translates to:
  /// **'Failed to set up barcode listener.'**
  String get failedToSetUpBarcodeListener;

  /// Error message shown when toggling the flash fails
  ///
  /// In en, this message translates to:
  /// **'Could not toggle flash.'**
  String get couldNotToggleFlash;

  /// Error message shown when switching the camera fails
  ///
  /// In en, this message translates to:
  /// **'Could not switch camera.'**
  String get couldNotSwitchCamera;

  /// Error message shown when starting the camera fails
  ///
  /// In en, this message translates to:
  /// **'Failed to start camera. Error: {error}'**
  String cameraStartError(String error);

  /// Generic error message shown when an unexpected error occurs during camera start
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred while starting the camera.'**
  String get cameraGenericError;

  /// Error message shown when camera permission is denied and requires settings adjustment
  ///
  /// In en, this message translates to:
  /// **'Camera permission denied. Please grant permission in settings.'**
  String get cameraPermissionDeniedInSettings;

  /// Error message shown when camera permission is denied or revoked during runtime
  ///
  /// In en, this message translates to:
  /// **'Camera permission was denied or revoked.\nPlease grant permission in app settings.'**
  String get cameraPermissionDeniedOrRevoked;

  /// Error message shown when camera isn't detected
  ///
  /// In en, this message translates to:
  /// **'Camera is unavailable or not supported on this device.'**
  String get cameraNotSupported;

  /// Title for the file scanning screen
  ///
  /// In en, this message translates to:
  /// **'Scan from File'**
  String get fileScreenTitle;

  /// Button text for selecting an image to scan
  ///
  /// In en, this message translates to:
  /// **'Pick Image & Scan'**
  String get pickImageButtonText;

  /// Instruction text on the file scanning screen
  ///
  /// In en, this message translates to:
  /// **'Select an image containing a QR code from your gallery.'**
  String get fileScreenInstruction;

  /// Loading message when selecting an image
  ///
  /// In en, this message translates to:
  /// **'Choose an image...'**
  String get chooseImageMessage;

  /// Loading message while processing the image
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processingMessage;

  /// Loading message while scanning the image for QR codes
  ///
  /// In en, this message translates to:
  /// **'Scanning image...'**
  String get scanningImageMessage;

  /// Message shown when a QR code is found but can't be read
  ///
  /// In en, this message translates to:
  /// **'No readable code found in the QR code.'**
  String get noCodeFoundMessage;

  /// Message shown when no QR code is found in the image
  ///
  /// In en, this message translates to:
  /// **'No QR code found in the selected image.'**
  String get noQrCodeFoundMessage;

  /// Error message when scanning an image fails
  ///
  /// In en, this message translates to:
  /// **'Error scanning image: {error}'**
  String imageScanError(String error);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
