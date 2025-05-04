// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'सरल स्कैनर';

  @override
  String get languageSectionTitle => 'भाषा';

  @override
  String get scannerTabLabel => 'कैमरा';

  @override
  String get fileTabLabel => 'फ़ाइल';

  @override
  String get settingsTabLabel => 'सेटिंग्स';

  @override
  String get scannerTabTitle => 'QR कोड स्कैन करें';

  @override
  String get scannerTabScanText => 'स्कैन करने के लिए QR कोड को फ्रेम में संरेखित करें';

  @override
  String get cameraPermissionRequestText => 'QR कोड स्कैन करने के लिए कैमरा अनुमति आवश्यक है। कृपया अनुमति दें।';

  @override
  String get cameraPermissionRestrictedText => 'कैमरा एक्सेस प्रतिबंधित है (जैसे, डिवाइस पॉलिसी या पैरेंटल कंट्रोल द्वारा)। स्कैनिंग उपलब्ध नहीं है।';

  @override
  String get cameraPermissionPermanentlyDeniedText => 'कैमरा अनुमति स्थायी रूप से अस्वीकृत है। QR कोड स्कैन करने के लिए कृपया ऐप सेटिंग्स में इसे सक्षम करें।';

  @override
  String get openSettingsText => 'सेटिंग्स खोलें';

  @override
  String get grantPermissionText => 'अनुमति दें';

  @override
  String couldNotPerformActionText(String uri) {
    return '$uri के लिए कार्रवाई नहीं कर सका';
  }

  @override
  String urlLaunchError(String error) {
    return 'लिंक लॉन्च करने में त्रुटि: $error';
  }

  @override
  String get scanResultTitle => 'स्कैन परिणाम';

  @override
  String get scanSuccessful => 'स्कैन सफल!';

  @override
  String get copyRawValue => 'कच्चा मान कॉपी करें';

  @override
  String get rawValueCopied => 'कच्चा मान कॉपी किया गया!';

  @override
  String get linkFound => 'लिंक मिला!';

  @override
  String get openLink => 'लिंक खोलें';

  @override
  String get phoneNumberFound => 'फोन नंबर मिला!';

  @override
  String get dialNumber => 'नंबर डायल करें';

  @override
  String get emailAddressFound => 'ईमेल पता मिला!';

  @override
  String get sendEmail => 'ईमेल भेजें';

  @override
  String get copyEmailAddress => 'ईमेल पता कॉपी करें';

  @override
  String get emailAddressCopied => 'ईमेल पता कॉपी किया गया!';

  @override
  String get smsDetailsFound => 'SMS विवरण मिला!';

  @override
  String get sendSms => 'SMS भेजें';

  @override
  String get wifiNetworkFound => 'Wi-Fi नेटवर्क मिला!';

  @override
  String get copyWifiInfo => 'Wi-Fi जानकारी कॉपी करें';

  @override
  String get wifiCredentialsCopied => 'Wi-Fi क्रेडेंशियल्स क्लिपबोर्ड पर कॉपी किए गए!';

  @override
  String get wifiManualNote => 'नोट: कॉपी की गई जानकारी को Wi-Fi सेटिंग्स में मैन्युअली पेस्ट करें।';

  @override
  String get contactInfoFound => 'संपर्क जानकारी मिली!';

  @override
  String get exportVCard => 'vCard (.vcf) निर्यात करें';

  @override
  String get vCardSaved => 'vCard सफलतापूर्वक सहेजा गया!';

  @override
  String get vCardExportCancelled => 'vCard निर्यात रद्द या विफल हुआ।';

  @override
  String vCardExportError(String error) {
    return 'vCard निर्यात करने में त्रुटि: $error';
  }

  @override
  String get locationFound => 'स्थान मिला!';

  @override
  String get openInMaps => 'मानचित्र में खोलें';

  @override
  String get calendarEventFound => 'कैलेंडर इवेंट मिला!';

  @override
  String get textFound => 'पाठ मिला';

  @override
  String get isbnFound => 'ISBN मिला';

  @override
  String get productCodeFound => 'उत्पाद कोड मिला';

  @override
  String get driverLicenseFound => 'ड्राइवर लाइसेंस मिला';

  @override
  String get contactInfoLabel => 'संपर्क जानकारी (vCard):';

  @override
  String get saveContactDialogTitle => 'संपर्क सहेजें';

  @override
  String get noneLabel => '(कोई नहीं)';

  @override
  String get calendarEventLabel => 'कैलेंडर इवेंट (iCal):';

  @override
  String get driverLicenseLabel => 'ड्राइवर लाइसेंस डेटा:';

  @override
  String get rawDataLabel => 'कच्चा डेटा:';

  @override
  String get nameLabel => 'नाम:';

  @override
  String get organizationLabel => 'संगठन:';

  @override
  String get titleLabel => 'शीर्षक:';

  @override
  String get phoneLabel => 'फोन:';

  @override
  String get emailLabel => 'ईमेल:';

  @override
  String get addressLabel => 'पता:';

  @override
  String get websiteLabel => 'वेबसाइट:';

  @override
  String get noteLabel => 'नोट:';

  @override
  String get wifiNetworkLabel => 'Wi-Fi नेटवर्क:';

  @override
  String get ssidLabel => 'SSID:';

  @override
  String get typeLabel => 'प्रकार:';

  @override
  String get passwordLabel => 'पासवर्ड:';

  @override
  String get noPasswordLabel => 'N/A (कोई पासवर्ड नहीं)';

  @override
  String get hiddenLabel => 'छिपा हुआ:';

  @override
  String get toLabel => 'को:';

  @override
  String get subjectLabel => 'विषय:';

  @override
  String get bodyLabel => 'बॉडी:';

  @override
  String get latitudeLabel => 'अक्षांश:';

  @override
  String get longitudeLabel => 'देशांतर:';

  @override
  String get altitudeLabel => 'ऊंचाई:';

  @override
  String get labelLabel => 'लेबल:';

  @override
  String get noVCardData => 'निर्यात करने के लिए कोई vCard डेटा नहीं।';

  @override
  String get hidePasswordTooltip => 'पासवर्ड छिपाएं';

  @override
  String get showPasswordTooltip => 'पासवर्ड दिखाएं';

  @override
  String get yesLabel => 'हाँ';

  @override
  String get noLabel => 'नहीं';

  @override
  String get errorRequestingPermission => 'अनुमति अनुरोध करने में त्रुटि।';

  @override
  String get errorReceivingBarcodeData => 'बारकोड डेटा प्राप्त करने में त्रुटि।';

  @override
  String get failedToSetUpBarcodeListener => 'बारकोड लिसनर सेटअप करने में विफल।';

  @override
  String get couldNotToggleFlash => 'फ्लैश टॉगल नहीं कर सका।';

  @override
  String get couldNotSwitchCamera => 'कैमरा स्विच नहीं कर सका।';

  @override
  String cameraStartError(String error) {
    return 'कैमरा शुरू करने में विफल। त्रुटि: $error';
  }

  @override
  String get cameraGenericError => 'कैमरा शुरू करते समय एक अप्रत्याशित त्रुटि हुई।';

  @override
  String get cameraPermissionDeniedInSettings => 'कैमरा अनुमति अस्वीकृत। कृपया सेटिंग्स में अनुमति दें।';

  @override
  String get cameraPermissionDeniedOrRevoked => 'कैमरा अनुमति अस्वीकृत या रद्द कर दी गई।\nकृपया ऐप सेटिंग्स में अनुमति दें।';

  @override
  String get cameraNotSupported => 'इस डिवाइस पर कैमरा अनुपलब्ध या समर्थित नहीं है।';

  @override
  String get fileScreenTitle => 'फ़ाइल से स्कैन करें';

  @override
  String get pickImageButtonText => 'छवि चुनें और स्कैन करें';

  @override
  String get fileScreenInstruction => 'अपने गैलरी से QR कोड वाली एक छवि चुनें।';

  @override
  String get chooseImageMessage => 'एक छवि चुनें...';

  @override
  String get processingMessage => 'प्रसंस्करण...';

  @override
  String get scanningImageMessage => 'छवि स्कैन की जा रही है...';

  @override
  String get noCodeFoundMessage => 'QR कोड में कोई पठनीय कोड नहीं मिला।';

  @override
  String get noQrCodeFoundMessage => 'चयनित छवि में कोई QR कोड नहीं मिला।';

  @override
  String imageScanError(String error) {
    return 'छवि स्कैन करने में त्रुटि: $error';
  }

  @override
  String get settingsScreenTitle => 'सेटिंग्स';

  @override
  String get appearanceSectionTitle => 'दिखावट';

  @override
  String get applicationSectionTitle => 'एप्लिकेशन';

  @override
  String get lightThemeLabel => 'हल्का';

  @override
  String get darkThemeLabel => 'गहरा';

  @override
  String get systemThemeLabel => 'सिस्टम';

  @override
  String get checkForUpdatesLabel => 'अपडेट के लिए जांचें';

  @override
  String get versionLoadingText => 'लोड हो रहा है...';

  @override
  String get versionErrorText => 'संस्करण लोड करने में त्रुटि';

  @override
  String versionFormat(String version, String buildNumber) {
    return 'संस्करण $version ($buildNumber)';
  }

  @override
  String get updateScreenTitle => 'ऐप अपडेट';

  @override
  String get checkingForUpdates => 'अपडेट के लिए जांच की जा रही है...';

  @override
  String get updateAvailable => 'अपडेट उपलब्ध!';

  @override
  String currentVersionLabel(String version) {
    return 'वर्तमान संस्करण: $version';
  }

  @override
  String newVersionLabel(String version) {
    return 'नया संस्करण: $version';
  }

  @override
  String latestVersionLabel(String version) {
    return '(नवीनतम उपलब्ध: $version)';
  }

  @override
  String get downloadAndInstallButton => 'डाउनलोड और इंस्टॉल करें';

  @override
  String downloadingUpdate(String version) {
    return 'अपडेट डाउनलोड हो रहा है ($version)...';
  }

  @override
  String downloadProgress(String progress) {
    return '$progress%';
  }

  @override
  String get startingInstall => 'इंस्टॉलेशन शुरू हो रहा है...';

  @override
  String get updateFailed => 'अपडेट विफल';

  @override
  String get retryCheckButton => 'पुनः जांचें';

  @override
  String get upToDate => 'आप अप-टू-डेट हैं!';

  @override
  String get checkAgainButton => 'फिर से जांचें';

  @override
  String get installDialogShown => 'इंस्टॉल डायलॉग दिखाया गया';

  @override
  String get noUpdateAvailable => 'कोई नया अपडेट उपलब्ध नहीं है।';

  @override
  String get unexpectedErrorDuringCheck => 'जांच के दौरान एक अप्रत्याशित त्रुटि हुई।';

  @override
  String get updateInfoIncomplete => 'अपडेट जानकारी अधूरी है।';

  @override
  String get downloadFailed => 'डाउनलोड विफल। कनेक्शन और अनुमतियाँ जांचें।';

  @override
  String get installationFailed => 'इंस्टॉलेशन शुरू नहीं कर सका। अनुमतियाँ जांचें।';
}
