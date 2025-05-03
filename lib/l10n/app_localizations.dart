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
  /// **'Could not perform action for \"{uri}\"'**
  String couldNotPerformActionText(String uri);

  /// No description provided for @genericErrorText.
  ///
  /// In en, this message translates to:
  /// **'Error \"{errorCause}\": \"{error}\"'**
  String genericErrorText(String errorCause, String error);
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
