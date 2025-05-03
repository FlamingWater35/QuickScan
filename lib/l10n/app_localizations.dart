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

  /// No description provided for @scannerTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get scannerTabLabel;

  /// No description provided for @fileTabLabel.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get fileTabLabel;

  /// No description provided for @settingsTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTabLabel;

  /// No description provided for @scannerTabTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scannerTabTitle;

  /// No description provided for @scannerTabScanText.
  ///
  /// In en, this message translates to:
  /// **'Align QR code within frame to scan'**
  String get scannerTabScanText;

  /// No description provided for @cameraPermissionRequestText.
  ///
  /// In en, this message translates to:
  /// **'Camera permission is required to scan QR codes. Please grant permission.'**
  String get cameraPermissionRequestText;

  /// No description provided for @cameraPermissionRestrictedText.
  ///
  /// In en, this message translates to:
  /// **'Camera access is restricted (e.g., by device policy or parental controls). Scanning is unavailable.'**
  String get cameraPermissionRestrictedText;

  /// No description provided for @cameraPermissionPermanentlyDeniedText.
  ///
  /// In en, this message translates to:
  /// **'Camera permission is permanently denied. Please enable it in app settings to scan QR codes.'**
  String get cameraPermissionPermanentlyDeniedText;

  /// No description provided for @openSettingsText.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettingsText;

  /// No description provided for @grantPermissionText.
  ///
  /// In en, this message translates to:
  /// **'Grant Permission'**
  String get grantPermissionText;

  /// No description provided for @couldNotPerformActionText.
  ///
  /// In en, this message translates to:
  /// **'Could not perform action for {uri}'**
  String couldNotPerformActionText(String uri);

  /// No description provided for @urlLaunchError.
  ///
  /// In en, this message translates to:
  /// **'Error launching link: {error}'**
  String urlLaunchError(String error);

  /// No description provided for @scanResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan Result'**
  String get scanResultTitle;

  /// No description provided for @scanSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Scan Successful!'**
  String get scanSuccessful;

  /// No description provided for @copyRawValue.
  ///
  /// In en, this message translates to:
  /// **'Copy Raw Value'**
  String get copyRawValue;

  /// No description provided for @rawValueCopied.
  ///
  /// In en, this message translates to:
  /// **'Raw value copied!'**
  String get rawValueCopied;

  /// No description provided for @linkFound.
  ///
  /// In en, this message translates to:
  /// **'Link Found!'**
  String get linkFound;

  /// No description provided for @openLink.
  ///
  /// In en, this message translates to:
  /// **'Open Link'**
  String get openLink;

  /// No description provided for @phoneNumberFound.
  ///
  /// In en, this message translates to:
  /// **'Phone Number Found!'**
  String get phoneNumberFound;

  /// No description provided for @dialNumber.
  ///
  /// In en, this message translates to:
  /// **'Dial Number'**
  String get dialNumber;

  /// No description provided for @emailAddressFound.
  ///
  /// In en, this message translates to:
  /// **'Email Address Found!'**
  String get emailAddressFound;

  /// No description provided for @sendEmail.
  ///
  /// In en, this message translates to:
  /// **'Send Email'**
  String get sendEmail;

  /// No description provided for @copyEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Copy Email Address'**
  String get copyEmailAddress;

  /// No description provided for @emailAddressCopied.
  ///
  /// In en, this message translates to:
  /// **'Email address copied!'**
  String get emailAddressCopied;

  /// No description provided for @smsDetailsFound.
  ///
  /// In en, this message translates to:
  /// **'SMS Details Found!'**
  String get smsDetailsFound;

  /// No description provided for @sendSms.
  ///
  /// In en, this message translates to:
  /// **'Send SMS'**
  String get sendSms;

  /// No description provided for @wifiNetworkFound.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi Network Found!'**
  String get wifiNetworkFound;

  /// No description provided for @copyWifiInfo.
  ///
  /// In en, this message translates to:
  /// **'Copy Wi-Fi Info'**
  String get copyWifiInfo;

  /// No description provided for @wifiCredentialsCopied.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi credentials copied to clipboard!'**
  String get wifiCredentialsCopied;

  /// No description provided for @wifiManualNote.
  ///
  /// In en, this message translates to:
  /// **'Note: Paste copied info into Wi-Fi settings manually.'**
  String get wifiManualNote;

  /// No description provided for @contactInfoFound.
  ///
  /// In en, this message translates to:
  /// **'Contact Info Found!'**
  String get contactInfoFound;

  /// No description provided for @exportVCard.
  ///
  /// In en, this message translates to:
  /// **'Export vCard (.vcf)'**
  String get exportVCard;

  /// No description provided for @vCardSaved.
  ///
  /// In en, this message translates to:
  /// **'vCard saved successfully!'**
  String get vCardSaved;

  /// No description provided for @vCardExportCancelled.
  ///
  /// In en, this message translates to:
  /// **'vCard export cancelled or failed.'**
  String get vCardExportCancelled;

  /// No description provided for @vCardExportError.
  ///
  /// In en, this message translates to:
  /// **'Error exporting vCard: {error}'**
  String vCardExportError(String error);

  /// No description provided for @locationFound.
  ///
  /// In en, this message translates to:
  /// **'Location Found!'**
  String get locationFound;

  /// No description provided for @openInMaps.
  ///
  /// In en, this message translates to:
  /// **'Open in Maps'**
  String get openInMaps;

  /// No description provided for @calendarEventFound.
  ///
  /// In en, this message translates to:
  /// **'Calendar Event Found!'**
  String get calendarEventFound;

  /// No description provided for @textFound.
  ///
  /// In en, this message translates to:
  /// **'Text Found'**
  String get textFound;

  /// No description provided for @isbnFound.
  ///
  /// In en, this message translates to:
  /// **'ISBN Found'**
  String get isbnFound;

  /// No description provided for @productCodeFound.
  ///
  /// In en, this message translates to:
  /// **'Product Code Found'**
  String get productCodeFound;

  /// No description provided for @driverLicenseFound.
  ///
  /// In en, this message translates to:
  /// **'Driver License Found'**
  String get driverLicenseFound;

  /// No description provided for @contactInfoLabel.
  ///
  /// In en, this message translates to:
  /// **'Contact Info (vCard):'**
  String get contactInfoLabel;

  /// No description provided for @calendarEventLabel.
  ///
  /// In en, this message translates to:
  /// **'Calendar Event (iCal):'**
  String get calendarEventLabel;

  /// No description provided for @driverLicenseLabel.
  ///
  /// In en, this message translates to:
  /// **'Driver License Data:'**
  String get driverLicenseLabel;

  /// No description provided for @rawDataLabel.
  ///
  /// In en, this message translates to:
  /// **'Raw Data:'**
  String get rawDataLabel;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name:'**
  String get nameLabel;

  /// No description provided for @organizationLabel.
  ///
  /// In en, this message translates to:
  /// **'Organization:'**
  String get organizationLabel;

  /// No description provided for @titleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title:'**
  String get titleLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone:'**
  String get phoneLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email:'**
  String get emailLabel;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address:'**
  String get addressLabel;

  /// No description provided for @websiteLabel.
  ///
  /// In en, this message translates to:
  /// **'Website:'**
  String get websiteLabel;

  /// No description provided for @noteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note:'**
  String get noteLabel;

  /// No description provided for @ssidLabel.
  ///
  /// In en, this message translates to:
  /// **'SSID:'**
  String get ssidLabel;

  /// No description provided for @typeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type:'**
  String get typeLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password:'**
  String get passwordLabel;

  /// No description provided for @hiddenLabel.
  ///
  /// In en, this message translates to:
  /// **'Hidden:'**
  String get hiddenLabel;

  /// No description provided for @toLabel.
  ///
  /// In en, this message translates to:
  /// **'To:'**
  String get toLabel;

  /// No description provided for @subjectLabel.
  ///
  /// In en, this message translates to:
  /// **'Subject:'**
  String get subjectLabel;

  /// No description provided for @bodyLabel.
  ///
  /// In en, this message translates to:
  /// **'Body:'**
  String get bodyLabel;

  /// No description provided for @latitudeLabel.
  ///
  /// In en, this message translates to:
  /// **'Latitude:'**
  String get latitudeLabel;

  /// No description provided for @longitudeLabel.
  ///
  /// In en, this message translates to:
  /// **'Longitude:'**
  String get longitudeLabel;

  /// No description provided for @altitudeLabel.
  ///
  /// In en, this message translates to:
  /// **'Altitude:'**
  String get altitudeLabel;

  /// No description provided for @labelLabel.
  ///
  /// In en, this message translates to:
  /// **'Label:'**
  String get labelLabel;

  /// No description provided for @noVCardData.
  ///
  /// In en, this message translates to:
  /// **'No vCard data to export.'**
  String get noVCardData;
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
