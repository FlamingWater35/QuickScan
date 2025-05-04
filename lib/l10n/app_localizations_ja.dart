// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'シンプルスキャナー';

  @override
  String get languageSectionTitle => '言語';

  @override
  String get scannerTabLabel => 'カメラ';

  @override
  String get fileTabLabel => 'ファイル';

  @override
  String get settingsTabLabel => '設定';

  @override
  String get scannerTabTitle => 'QRコードをスキャン';

  @override
  String get scannerTabScanText => 'QRコードを枠内に合わせてスキャン';

  @override
  String get cameraPermissionRequestText => 'QRコードをスキャンするにはカメラの許可が必要です。許可してください。';

  @override
  String get cameraPermissionRestrictedText => 'カメラへのアクセスが制限されています（例：デバイスポリシーやペアレンタルコントロールによる）。スキャンは利用できません。';

  @override
  String get cameraPermissionPermanentlyDeniedText => 'カメラの許可が完全に拒否されています。QRコードをスキャンするにはアプリの設定で許可を有効にしてください。';

  @override
  String get openSettingsText => '設定を開く';

  @override
  String get grantPermissionText => '許可を付与';

  @override
  String couldNotPerformActionText(String uri) {
    return '$uri に対してアクションを実行できませんでした';
  }

  @override
  String urlLaunchError(String error) {
    return 'リンクの起動に失敗しました：$error';
  }

  @override
  String get scanResultTitle => 'スキャン結果';

  @override
  String get scanSuccessful => 'スキャン成功！';

  @override
  String get copyRawValue => '生データをコピー';

  @override
  String get rawValueCopied => '生データがコピーされました！';

  @override
  String get linkFound => 'リンクが見つかりました！';

  @override
  String get openLink => 'リンクを開く';

  @override
  String get phoneNumberFound => '電話番号が見つかりました！';

  @override
  String get dialNumber => '電話をかける';

  @override
  String get emailAddressFound => 'メールアドレスが見つかりました！';

  @override
  String get sendEmail => 'メールを送信';

  @override
  String get copyEmailAddress => 'メールアドレスをコピー';

  @override
  String get emailAddressCopied => 'メールアドレスがコピーされました！';

  @override
  String get smsDetailsFound => 'SMSの詳細が見つかりました！';

  @override
  String get sendSms => 'SMSを送信';

  @override
  String get wifiNetworkFound => 'Wi-Fiネットワークが見つかりました！';

  @override
  String get copyWifiInfo => 'Wi-Fi情報をコピー';

  @override
  String get wifiCredentialsCopied => 'Wi-Fi認証情報がクリップボードにコピーされました！';

  @override
  String get wifiManualNote => '注意：コピーした情報をWi-Fi設定に手動で貼り付けてください。';

  @override
  String get contactInfoFound => '連絡先情報が見つかりました！';

  @override
  String get exportVCard => 'vCardをエクスポート（.vcf）';

  @override
  String get vCardSaved => 'vCardが正常に保存されました！';

  @override
  String get vCardExportCancelled => 'vCardのエクスポートがキャンセルされたか失敗しました。';

  @override
  String vCardExportError(String error) {
    return 'vCardのエクスポートエラー：$error';
  }

  @override
  String get locationFound => '位置情報が見つかりました！';

  @override
  String get openInMaps => 'マップで開く';

  @override
  String get calendarEventFound => 'カレンダーイベントが見つかりました！';

  @override
  String get textFound => 'テキストが見つかりました';

  @override
  String get isbnFound => 'ISBNが見つかりました';

  @override
  String get productCodeFound => '商品コードが見つかりました';

  @override
  String get driverLicenseFound => '運転免許証が見つかりました';

  @override
  String get contactInfoLabel => '連絡先情報（vCard）：';

  @override
  String get saveContactDialogTitle => '連絡先を保存';

  @override
  String get noneLabel => '（なし）';

  @override
  String get calendarEventLabel => 'カレンダーイベント（iCal）：';

  @override
  String get driverLicenseLabel => '運転免許証データ：';

  @override
  String get rawDataLabel => '生データ：';

  @override
  String get nameLabel => '名前：';

  @override
  String get organizationLabel => '組織：';

  @override
  String get titleLabel => '役職：';

  @override
  String get phoneLabel => '電話：';

  @override
  String get emailLabel => 'メール：';

  @override
  String get addressLabel => '住所：';

  @override
  String get websiteLabel => 'ウェブサイト：';

  @override
  String get noteLabel => 'メモ：';

  @override
  String get wifiNetworkLabel => 'Wi-Fiネットワーク：';

  @override
  String get ssidLabel => 'SSID：';

  @override
  String get typeLabel => 'タイプ：';

  @override
  String get passwordLabel => 'パスワード：';

  @override
  String get noPasswordLabel => 'N/A（パスワードなしの可能性）';

  @override
  String get hiddenLabel => '非表示：';

  @override
  String get toLabel => '宛先：';

  @override
  String get subjectLabel => '件名：';

  @override
  String get bodyLabel => '本文：';

  @override
  String get latitudeLabel => '緯度：';

  @override
  String get longitudeLabel => '経度：';

  @override
  String get altitudeLabel => '高度：';

  @override
  String get labelLabel => 'ラベル：';

  @override
  String get noVCardData => 'エクスポートするvCardデータがありません。';

  @override
  String get hidePasswordTooltip => 'パスワードを非表示';

  @override
  String get showPasswordTooltip => 'パスワードを表示';

  @override
  String get yesLabel => 'はい';

  @override
  String get noLabel => 'いいえ';

  @override
  String get errorRequestingPermission => '許可の要求にエラーが発生しました。';

  @override
  String get errorReceivingBarcodeData => 'バーコードデータの受信にエラーが発生しました。';

  @override
  String get failedToSetUpBarcodeListener => 'バーコードリスナーの設定に失敗しました。';

  @override
  String get couldNotToggleFlash => 'フラッシュを切り替えられませんでした。';

  @override
  String get couldNotSwitchCamera => 'カメラを切り替えられませんでした。';

  @override
  String cameraStartError(String error) {
    return 'カメラの起動に失敗しました。エラー：$error';
  }

  @override
  String get cameraGenericError => 'カメラの起動中に予期しないエラーが発生しました。';

  @override
  String get cameraPermissionDeniedInSettings => 'カメラの許可が拒否されています。設定で許可してください。';

  @override
  String get cameraPermissionDeniedOrRevoked => 'カメラの許可が拒否または取り消されました。\nアプリの設定で許可してください。';

  @override
  String get cameraNotSupported => 'カメラが利用できないか、このデバイスでサポートされていません。';

  @override
  String get fileScreenTitle => 'ファイルからスキャン';

  @override
  String get pickImageButtonText => '画像を選択してスキャン';

  @override
  String get fileScreenInstruction => 'ギャラリーからQRコードを含む画像を選択してください。';

  @override
  String get chooseImageMessage => '画像を選択...';

  @override
  String get processingMessage => '処理中...';

  @override
  String get scanningImageMessage => '画像をスキャン中...';

  @override
  String get noCodeFoundMessage => 'QRコードに読み取れるコードが見つかりませんでした。';

  @override
  String get noQrCodeFoundMessage => '選択した画像にQRコードが見つかりませんでした。';

  @override
  String imageScanError(String error) {
    return '画像のスキャンエラー：$error';
  }

  @override
  String get settingsScreenTitle => '設定';

  @override
  String get appearanceSectionTitle => '外観';

  @override
  String get applicationSectionTitle => 'アプリケーション';

  @override
  String get lightThemeLabel => 'ライト';

  @override
  String get darkThemeLabel => 'ダーク';

  @override
  String get systemThemeLabel => 'システム';

  @override
  String get checkForUpdatesLabel => 'アップデートの確認';

  @override
  String get versionLoadingText => '読み込み中...';

  @override
  String get versionErrorText => 'バージョンの読み込みエラー';

  @override
  String versionFormat(String version, String buildNumber) {
    return 'バージョン $version ($buildNumber)';
  }

  @override
  String get updateScreenTitle => 'アプリのアップデート';

  @override
  String get checkingForUpdates => 'アップデートを確認中...';

  @override
  String get updateAvailable => 'アップデートが利用可能です！';

  @override
  String currentVersionLabel(String version) {
    return '現在のバージョン：$version';
  }

  @override
  String newVersionLabel(String version) {
    return '新しいバージョン：$version';
  }

  @override
  String latestVersionLabel(String version) {
    return '（最新バージョン：$version）';
  }

  @override
  String get downloadAndInstallButton => 'ダウンロードしてインストール';

  @override
  String downloadingUpdate(String version) {
    return 'アップデートをダウンロード中（$version）...';
  }

  @override
  String downloadProgress(String progress) {
    return '$progress%';
  }

  @override
  String get startingInstall => 'インストールを開始中...';

  @override
  String get updateFailed => 'アップデートに失敗しました';

  @override
  String get retryCheckButton => '再確認';

  @override
  String get upToDate => '最新の状態です！';

  @override
  String get checkAgainButton => '再度確認';

  @override
  String get installDialogShown => 'インストールダイアログが表示されました';

  @override
  String get noUpdateAvailable => '新しいアップデートはありません。';

  @override
  String get unexpectedErrorDuringCheck => '確認中に予期しないエラーが発生しました。';

  @override
  String get updateInfoIncomplete => 'アップデート情報が不完全です。';

  @override
  String get downloadFailed => 'ダウンロードに失敗しました。接続と許可を確認してください。';

  @override
  String get installationFailed => 'インストールを開始できませんでした。許可を確認してください。';
}
