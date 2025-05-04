// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'ماسح بسيط';

  @override
  String get languageSectionTitle => 'اللغة';

  @override
  String get scannerTabLabel => 'الكاميرا';

  @override
  String get fileTabLabel => 'ملف';

  @override
  String get settingsTabLabel => 'الإعدادات';

  @override
  String get scannerTabTitle => 'مسح رمز QR';

  @override
  String get scannerTabScanText => 'قم بمحاذاة رمز QR داخل الإطار للمسح';

  @override
  String get cameraPermissionRequestText => 'يتطلب مسح رموز QR إذن الكاميرا. يرجى منح الإذن.';

  @override
  String get cameraPermissionRestrictedText => 'تم تقييد الوصول إلى الكاميرا (على سبيل المثال، بواسطة سياسة الجهاز أو ضوابط الوالدين). المسح غير متاح.';

  @override
  String get cameraPermissionPermanentlyDeniedText => 'تم رفض إذن الكاميرا بشكل دائم. يرجى تمكينه في إعدادات التطبيق لمسح رموز QR.';

  @override
  String get openSettingsText => 'فتح الإعدادات';

  @override
  String get grantPermissionText => 'منح الإذن';

  @override
  String couldNotPerformActionText(String uri) {
    return 'تعذر تنفيذ الإجراء لـ $uri';
  }

  @override
  String urlLaunchError(String error) {
    return 'خطأ في فتح الرابط: $error';
  }

  @override
  String get scanResultTitle => 'نتيجة المسح';

  @override
  String get scanSuccessful => 'تم المسح بنجاح!';

  @override
  String get copyRawValue => 'نسخ القيمة الخام';

  @override
  String get rawValueCopied => 'تم نسخ القيمة الخام!';

  @override
  String get linkFound => 'تم العثور على رابط!';

  @override
  String get openLink => 'فتح الرابط';

  @override
  String get phoneNumberFound => 'تم العثور على رقم هاتف!';

  @override
  String get dialNumber => 'اتصال بالرقم';

  @override
  String get emailAddressFound => 'تم العثور على عنوان بريد إلكتروني!';

  @override
  String get sendEmail => 'إرسال بريد إلكتروني';

  @override
  String get copyEmailAddress => 'نسخ عنوان البريد الإلكتروني';

  @override
  String get emailAddressCopied => 'تم نسخ عنوان البريد الإلكتروني!';

  @override
  String get smsDetailsFound => 'تم العثور على تفاصيل SMS!';

  @override
  String get sendSms => 'إرسال SMS';

  @override
  String get wifiNetworkFound => 'تم العثور على شبكة Wi-Fi!';

  @override
  String get copyWifiInfo => 'نسخ معلومات Wi-Fi';

  @override
  String get wifiCredentialsCopied => 'تم نسخ بيانات اعتماد Wi-Fi!';

  @override
  String get wifiManualNote => 'ملاحظة: الصق المعلومات المنسوخة في إعدادات Wi-Fi يدويًا.';

  @override
  String get contactInfoFound => 'تم العثور على معلومات الاتصال!';

  @override
  String get exportVCard => 'تصدير vCard (.vcf)';

  @override
  String get vCardSaved => 'تم حفظ vCard بنجاح!';

  @override
  String get vCardExportCancelled => 'تم إلغاء تصدير vCard أو فشل.';

  @override
  String vCardExportError(String error) {
    return 'خطأ في تصدير vCard: $error';
  }

  @override
  String get locationFound => 'تم العثور على موقع!';

  @override
  String get openInMaps => 'فتح في الخرائط';

  @override
  String get calendarEventFound => 'تم العثور على حدث تقويم!';

  @override
  String get textFound => 'تم العثور على نص';

  @override
  String get isbnFound => 'تم العثور على ISBN';

  @override
  String get productCodeFound => 'تم العثور على رمز منتج';

  @override
  String get driverLicenseFound => 'تم العثور على رخصة قيادة';

  @override
  String get contactInfoLabel => 'معلومات الاتصال (vCard):';

  @override
  String get saveContactDialogTitle => 'حفظ جهة اتصال';

  @override
  String get noneLabel => '(لا شيء)';

  @override
  String get calendarEventLabel => 'حدث التقويم (iCal):';

  @override
  String get driverLicenseLabel => 'بيانات رخصة القيادة:';

  @override
  String get rawDataLabel => 'بيانات خام:';

  @override
  String get nameLabel => 'الاسم:';

  @override
  String get organizationLabel => 'المنظمة:';

  @override
  String get titleLabel => 'المسمى الوظيفي:';

  @override
  String get phoneLabel => 'الهاتف:';

  @override
  String get emailLabel => 'البريد الإلكتروني:';

  @override
  String get addressLabel => 'العنوان:';

  @override
  String get websiteLabel => 'الموقع الإلكتروني:';

  @override
  String get noteLabel => 'ملاحظة:';

  @override
  String get wifiNetworkLabel => 'شبكة Wi-Fi:';

  @override
  String get ssidLabel => 'SSID:';

  @override
  String get typeLabel => 'النوع:';

  @override
  String get passwordLabel => 'كلمة المرور:';

  @override
  String get noPasswordLabel => 'N/A (ربما لا توجد كلمة مرور)';

  @override
  String get hiddenLabel => 'مخفي:';

  @override
  String get toLabel => 'إلى:';

  @override
  String get subjectLabel => 'الموضوع:';

  @override
  String get bodyLabel => 'المحتوى:';

  @override
  String get latitudeLabel => 'خط العرض:';

  @override
  String get longitudeLabel => 'خط الطول:';

  @override
  String get altitudeLabel => 'الارتفاع:';

  @override
  String get labelLabel => 'تسمية:';

  @override
  String get noVCardData => 'لا توجد بيانات vCard للتصدير.';

  @override
  String get hidePasswordTooltip => 'إخفاء كلمة المرور';

  @override
  String get showPasswordTooltip => 'إظهار كلمة المرور';

  @override
  String get yesLabel => 'نعم';

  @override
  String get noLabel => 'لا';

  @override
  String get errorRequestingPermission => 'خطأ في طلب الإذن.';

  @override
  String get errorReceivingBarcodeData => 'خطأ في استقبال بيانات الباركود.';

  @override
  String get failedToSetUpBarcodeListener => 'فشل في إعداد مستمع الباركود.';

  @override
  String get couldNotToggleFlash => 'تعذر تبديل الفلاش.';

  @override
  String get couldNotSwitchCamera => 'تعذر تبديل الكاميرا.';

  @override
  String cameraStartError(String error) {
    return 'فشل في بدء الكاميرا. الخطأ: $error';
  }

  @override
  String get cameraGenericError => 'حدث خطأ غير متوقع أثناء بدء الكاميرا.';

  @override
  String get cameraPermissionDeniedInSettings => 'تم رفض إذن الكاميرا. يرجى منح الإذن في الإعدادات.';

  @override
  String get cameraPermissionDeniedOrRevoked => 'تم رفض إذن الكاميرا أو إلغاؤه.\nيرجى منح الإذن في إعدادات التطبيق.';

  @override
  String get cameraNotSupported => 'الكاميرا غير متوفرة أو غير مدعومة على هذا الجهاز.';

  @override
  String get fileScreenTitle => 'مسح من ملف';

  @override
  String get pickImageButtonText => 'اختيار صورة ومسح';

  @override
  String get fileScreenInstruction => 'حدد صورة تحتوي على رمز QR من معرضك.';

  @override
  String get chooseImageMessage => 'اختيار صورة...';

  @override
  String get processingMessage => 'جاري المعالجة...';

  @override
  String get scanningImageMessage => 'جاري مسح الصورة...';

  @override
  String get noCodeFoundMessage => 'لم يتم العثور على أي رمز قابل للقراءة في رمز QR.';

  @override
  String get noQrCodeFoundMessage => 'لم يتم العثور على رمز QR في الصورة المحددة.';

  @override
  String imageScanError(String error) {
    return 'خطأ في مسح الصورة: $error';
  }

  @override
  String get settingsScreenTitle => 'الإعدادات';

  @override
  String get appearanceSectionTitle => 'المظهر';

  @override
  String get applicationSectionTitle => 'التطبيق';

  @override
  String get lightThemeLabel => 'فاتح';

  @override
  String get darkThemeLabel => 'غامق';

  @override
  String get systemThemeLabel => 'النظام';

  @override
  String get checkForUpdatesLabel => 'التحقق من التحديثات';

  @override
  String get versionLoadingText => 'جاري التحميل...';

  @override
  String get versionErrorText => 'خطأ في تحميل الإصدار';

  @override
  String versionFormat(String version, String buildNumber) {
    return 'الإصدار $version ($buildNumber)';
  }

  @override
  String get updateScreenTitle => 'تحديث التطبيق';

  @override
  String get checkingForUpdates => 'جاري التحقق من التحديثات...';

  @override
  String get updateAvailable => 'تحديث متاح!';

  @override
  String currentVersionLabel(String version) {
    return 'الإصدار الحالي: $version';
  }

  @override
  String newVersionLabel(String version) {
    return 'الإصدار الجديد: $version';
  }

  @override
  String latestVersionLabel(String version) {
    return '(أحدث إصدار متاح: $version)';
  }

  @override
  String get downloadAndInstallButton => 'تنزيل وتثبيت';

  @override
  String downloadingUpdate(String version) {
    return 'جاري تنزيل التحديث ($version)...';
  }

  @override
  String downloadProgress(String progress) {
    return '$progress%';
  }

  @override
  String get startingInstall => 'جاري بدء التثبيت...';

  @override
  String get updateFailed => 'فشل التحديث';

  @override
  String get retryCheckButton => 'إعادة المحاولة';

  @override
  String get upToDate => 'أنت محدث!';

  @override
  String get checkAgainButton => 'تحقق مرة أخرى';

  @override
  String get installDialogShown => 'تم عرض مربع حوار التثبيت';

  @override
  String get noUpdateAvailable => 'لا تتوفر تحديثات جديدة.';

  @override
  String get unexpectedErrorDuringCheck => 'حدث خطأ غير متوقع أثناء التحقق.';

  @override
  String get updateInfoIncomplete => 'معلومات التحديث غير مكتملة.';

  @override
  String get downloadFailed => 'فشل التنزيل. تحقق من الاتصال والأذونات.';

  @override
  String get installationFailed => 'تعذر بدء التثبيت. تحقق من الأذونات.';
}
