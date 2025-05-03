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
  String get languageSectionTitle => '语言';

  @override
  String get englishLanguage => '英语';

  @override
  String get spanishLanguage => '西班牙语';

  @override
  String get finnishLanguage => '芬兰';

  @override
  String get chineseLanguage => '中文';

  @override
  String get scannerTabLabel => '相机';

  @override
  String get fileTabLabel => '文件';

  @override
  String get settingsTabLabel => '设置';

  @override
  String get scannerTabTitle => '扫描二维码';

  @override
  String get scannerTabScanText => '将二维码对准取景框进行扫描';

  @override
  String get cameraPermissionRequestText => '扫描二维码需要相机权限，请授予权限。';

  @override
  String get cameraPermissionRestrictedText => '相机访问受限（如被设备策略或家长控制限制）。无法扫描。';

  @override
  String get cameraPermissionPermanentlyDeniedText => '相机权限被永久拒绝。请在应用设置中启用以扫描二维码。';

  @override
  String get openSettingsText => '打开设置';

  @override
  String get grantPermissionText => '授予权限';

  @override
  String couldNotPerformActionText(String uri) {
    return '无法为 $uri 执行操作';
  }

  @override
  String urlLaunchError(String error) {
    return '打开链接出错: $error';
  }

  @override
  String get scanResultTitle => '扫描结果';

  @override
  String get scanSuccessful => '扫描成功！';

  @override
  String get copyRawValue => '复制原始值';

  @override
  String get rawValueCopied => '原始值已复制！';

  @override
  String get linkFound => '发现链接！';

  @override
  String get openLink => '打开链接';

  @override
  String get phoneNumberFound => '发现电话号码！';

  @override
  String get dialNumber => '拨打电话';

  @override
  String get emailAddressFound => '发现电子邮件地址！';

  @override
  String get sendEmail => '发送邮件';

  @override
  String get copyEmailAddress => '复制邮箱地址';

  @override
  String get emailAddressCopied => '邮箱地址已复制！';

  @override
  String get smsDetailsFound => '发现短信详情！';

  @override
  String get sendSms => '发送短信';

  @override
  String get wifiNetworkFound => '发现Wi-Fi网络！';

  @override
  String get copyWifiInfo => '复制Wi-Fi信息';

  @override
  String get wifiCredentialsCopied => 'Wi-Fi凭证已复制到剪贴板！';

  @override
  String get wifiManualNote => '注意：请手动将复制的信息粘贴到Wi-Fi设置中。';

  @override
  String get contactInfoFound => '发现联系人信息！';

  @override
  String get exportVCard => '导出vCard (.vcf)';

  @override
  String get vCardSaved => 'vCard保存成功！';

  @override
  String get vCardExportCancelled => 'vCard导出已取消或失败。';

  @override
  String vCardExportError(String error) {
    return '导出vCard出错: $error';
  }

  @override
  String get locationFound => '发现地理位置！';

  @override
  String get openInMaps => '在地图中打开';

  @override
  String get calendarEventFound => '发现日历事件！';

  @override
  String get textFound => '发现文本';

  @override
  String get isbnFound => '发现ISBN';

  @override
  String get productCodeFound => '发现产品代码';

  @override
  String get driverLicenseFound => '发现驾驶证信息';

  @override
  String get contactInfoLabel => '联系人信息(vCard):';

  @override
  String get saveContactDialogTitle => '保存联系人';

  @override
  String get noneLabel => '(无)';

  @override
  String get calendarEventLabel => '日历事件(iCal):';

  @override
  String get driverLicenseLabel => '驾驶证数据:';

  @override
  String get rawDataLabel => '原始数据:';

  @override
  String get nameLabel => '姓名:';

  @override
  String get organizationLabel => '组织:';

  @override
  String get titleLabel => '职位:';

  @override
  String get phoneLabel => '电话:';

  @override
  String get emailLabel => '邮箱:';

  @override
  String get addressLabel => '地址:';

  @override
  String get websiteLabel => '网站:';

  @override
  String get noteLabel => '备注:';

  @override
  String get wifiNetworkLabel => 'Wi-Fi网络:';

  @override
  String get ssidLabel => 'SSID:';

  @override
  String get typeLabel => '类型:';

  @override
  String get passwordLabel => '密码:';

  @override
  String get noPasswordLabel => '无(可能没有密码)';

  @override
  String get hiddenLabel => '隐藏:';

  @override
  String get toLabel => '收件人:';

  @override
  String get subjectLabel => '主题:';

  @override
  String get bodyLabel => '正文:';

  @override
  String get latitudeLabel => '纬度:';

  @override
  String get longitudeLabel => '经度:';

  @override
  String get altitudeLabel => '海拔:';

  @override
  String get labelLabel => '标签:';

  @override
  String get noVCardData => '没有可导出的vCard数据。';

  @override
  String get hidePasswordTooltip => '隐藏密码';

  @override
  String get showPasswordTooltip => '显示密码';

  @override
  String get yesLabel => '是';

  @override
  String get noLabel => '否';

  @override
  String get errorRequestingPermission => '请求权限出错。';

  @override
  String get errorReceivingBarcodeData => '接收条码数据出错。';

  @override
  String get failedToSetUpBarcodeListener => '设置条码监听器失败。';

  @override
  String get couldNotToggleFlash => '无法切换闪光灯。';

  @override
  String get couldNotSwitchCamera => '无法切换相机。';

  @override
  String cameraStartError(String error) {
    return '启动相机失败。错误: $error';
  }

  @override
  String get cameraGenericError => '启动相机时发生意外错误。';

  @override
  String get cameraPermissionDeniedInSettings => '相机权限被拒绝。请在设置中授予权限。';

  @override
  String get cameraPermissionDeniedOrRevoked => '相机权限被拒绝或撤销。\n请在应用设置中授予权限。';

  @override
  String get cameraNotSupported => '此设备不支持或无法使用相机。';

  @override
  String get fileScreenTitle => '从文件扫描';

  @override
  String get pickImageButtonText => '选择图片并扫描';

  @override
  String get fileScreenInstruction => '从相册中选择包含二维码的图片。';

  @override
  String get chooseImageMessage => '选择图片...';

  @override
  String get processingMessage => '处理中...';

  @override
  String get scanningImageMessage => '正在扫描图片...';

  @override
  String get noCodeFoundMessage => '在二维码中未找到可读代码。';

  @override
  String get noQrCodeFoundMessage => '在所选图片中未找到二维码。';

  @override
  String imageScanError(String error) {
    return '扫描图片出错: $error';
  }

  @override
  String get settingsScreenTitle => '设置';

  @override
  String get appearanceSectionTitle => '外观';

  @override
  String get applicationSectionTitle => '应用';

  @override
  String get lightThemeLabel => '浅色';

  @override
  String get darkThemeLabel => '深色';

  @override
  String get systemThemeLabel => '系统';

  @override
  String get checkForUpdatesLabel => '检查更新';

  @override
  String get versionLoadingText => '加载中...';

  @override
  String get versionErrorText => '加载版本信息出错';

  @override
  String versionFormat(String version, String buildNumber) {
    return '版本 $version ($buildNumber)';
  }

  @override
  String get updateScreenTitle => '应用更新';

  @override
  String get checkingForUpdates => '正在检查更新...';

  @override
  String get updateAvailable => '有可用更新！';

  @override
  String currentVersionLabel(String version) {
    return '当前版本: $version';
  }

  @override
  String newVersionLabel(String version) {
    return '新版本: $version';
  }

  @override
  String latestVersionLabel(String version) {
    return '(最新可用: $version)';
  }

  @override
  String get downloadAndInstallButton => '下载并安装';

  @override
  String downloadingUpdate(String version) {
    return '正在下载更新($version)...';
  }

  @override
  String downloadProgress(String progress) {
    return '$progress%';
  }

  @override
  String get startingInstall => '开始安装...';

  @override
  String get updateFailed => '更新失败';

  @override
  String get retryCheckButton => '重试检查';

  @override
  String get upToDate => '您已是最新版本！';

  @override
  String get checkAgainButton => '再次检查';

  @override
  String get installDialogShown => '安装对话框已显示';

  @override
  String get noUpdateAvailable => '没有可用更新。';

  @override
  String get unexpectedErrorDuringCheck => '检查更新时发生意外错误。';

  @override
  String get updateInfoIncomplete => '更新信息不完整。';

  @override
  String get downloadFailed => '下载失败。请检查连接和权限。';

  @override
  String get installationFailed => '无法开始安装。请检查权限。';
}
