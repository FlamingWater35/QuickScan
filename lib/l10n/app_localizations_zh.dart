// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '简易扫描器';

  @override
  String get scannerTabLabel => '相机';

  @override
  String get fileTabLabel => '文件';

  @override
  String get settingsTabLabel => '设置';

  @override
  String get scannerTabTitle => '扫描二维码';

  @override
  String get scannerTabScanText => '将二维码对准框内进行扫描';

  @override
  String get cameraPermissionRequestText => '扫描二维码需要相机权限。请授予权限。';

  @override
  String get cameraPermissionRestrictedText => '相机访问受限（例如，由于设备策略或家长控制）。无法使用扫描功能。';

  @override
  String get cameraPermissionPermanentlyDeniedText => '相机权限被永久拒绝。请在应用设置中启用它以扫描二维码。';

  @override
  String get openSettingsText => '打开设置';

  @override
  String get grantPermissionText => '授予权限';

  @override
  String couldNotPerformActionText(String uri) {
    return '无法对 \"$uri\" 执行操作';
  }

  @override
  String genericErrorText(String errorCause, String error) {
    return '错误 \"$errorCause\": \"$error\"';
  }
}
