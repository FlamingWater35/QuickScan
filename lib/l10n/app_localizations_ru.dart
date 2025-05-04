// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Простой Сканер';

  @override
  String get languageSectionTitle => 'Язык';

  @override
  String get scannerTabLabel => 'Камера';

  @override
  String get fileTabLabel => 'Файл';

  @override
  String get settingsTabLabel => 'Настройки';

  @override
  String get scannerTabTitle => 'Сканировать QR-код';

  @override
  String get scannerTabScanText => 'Разместите QR-код в рамке для сканирования';

  @override
  String get cameraPermissionRequestText => 'Для сканирования QR-кодов требуется разрешение на использование камеры. Пожалуйста, предоставьте разрешение.';

  @override
  String get cameraPermissionRestrictedText => 'Доступ к камере ограничен (например, политикой устройства или родительским контролем). Сканирование недоступно.';

  @override
  String get cameraPermissionPermanentlyDeniedText => 'Разрешение на использование камеры отклонено навсегда. Пожалуйста, включите его в настройках приложения для сканирования QR-кодов.';

  @override
  String get openSettingsText => 'Открыть настройки';

  @override
  String get grantPermissionText => 'Предоставить разрешение';

  @override
  String couldNotPerformActionText(String uri) {
    return 'Не удалось выполнить действие для $uri';
  }

  @override
  String urlLaunchError(String error) {
    return 'Ошибка при открытии ссылки: $error';
  }

  @override
  String get scanResultTitle => 'Результат сканирования';

  @override
  String get scanSuccessful => 'Сканирование успешно!';

  @override
  String get copyRawValue => 'Копировать исходное значение';

  @override
  String get rawValueCopied => 'Исходное значение скопировано!';

  @override
  String get linkFound => 'Найдена ссылка!';

  @override
  String get openLink => 'Открыть ссылку';

  @override
  String get phoneNumberFound => 'Найден номер телефона!';

  @override
  String get dialNumber => 'Набрать номер';

  @override
  String get emailAddressFound => 'Найден email!';

  @override
  String get sendEmail => 'Отправить email';

  @override
  String get copyEmailAddress => 'Копировать email';

  @override
  String get emailAddressCopied => 'Email скопирован!';

  @override
  String get smsDetailsFound => 'Найдены детали SMS!';

  @override
  String get sendSms => 'Отправить SMS';

  @override
  String get wifiNetworkFound => 'Найдена сеть Wi-Fi!';

  @override
  String get copyWifiInfo => 'Копировать данные Wi-Fi';

  @override
  String get wifiCredentialsCopied => 'Данные Wi-Fi скопированы в буфер обмена!';

  @override
  String get wifiManualNote => 'Примечание: Вставьте скопированные данные в настройки Wi-Fi вручную.';

  @override
  String get contactInfoFound => 'Найдена контактная информация!';

  @override
  String get exportVCard => 'Экспортировать vCard (.vcf)';

  @override
  String get vCardSaved => 'vCard успешно сохранена!';

  @override
  String get vCardExportCancelled => 'Экспорт vCard отменен или не удался.';

  @override
  String vCardExportError(String error) {
    return 'Ошибка при экспорте vCard: $error';
  }

  @override
  String get locationFound => 'Найдено местоположение!';

  @override
  String get openInMaps => 'Открыть в картах';

  @override
  String get calendarEventFound => 'Найдено событие календаря!';

  @override
  String get textFound => 'Найден текст';

  @override
  String get isbnFound => 'Найден ISBN';

  @override
  String get productCodeFound => 'Найден код продукта';

  @override
  String get driverLicenseFound => 'Найдены данные водительского удостоверения';

  @override
  String get contactInfoLabel => 'Контактная информация (vCard):';

  @override
  String get saveContactDialogTitle => 'Сохранить контакт';

  @override
  String get noneLabel => '(нет)';

  @override
  String get calendarEventLabel => 'Событие календаря (iCal):';

  @override
  String get driverLicenseLabel => 'Данные водительского удостоверения:';

  @override
  String get rawDataLabel => 'Исходные данные:';

  @override
  String get nameLabel => 'Имя:';

  @override
  String get organizationLabel => 'Организация:';

  @override
  String get titleLabel => 'Должность:';

  @override
  String get phoneLabel => 'Телефон:';

  @override
  String get emailLabel => 'Email:';

  @override
  String get addressLabel => 'Адрес:';

  @override
  String get websiteLabel => 'Веб-сайт:';

  @override
  String get noteLabel => 'Примечание:';

  @override
  String get wifiNetworkLabel => 'Сеть Wi-Fi:';

  @override
  String get ssidLabel => 'SSID:';

  @override
  String get typeLabel => 'Тип:';

  @override
  String get passwordLabel => 'Пароль:';

  @override
  String get noPasswordLabel => 'N/A (возможно, без пароля)';

  @override
  String get hiddenLabel => 'Скрытая:';

  @override
  String get toLabel => 'Кому:';

  @override
  String get subjectLabel => 'Тема:';

  @override
  String get bodyLabel => 'Текст:';

  @override
  String get latitudeLabel => 'Широта:';

  @override
  String get longitudeLabel => 'Долгота:';

  @override
  String get altitudeLabel => 'Высота:';

  @override
  String get labelLabel => 'Метка:';

  @override
  String get noVCardData => 'Нет данных vCard для экспорта.';

  @override
  String get hidePasswordTooltip => 'Скрыть пароль';

  @override
  String get showPasswordTooltip => 'Показать пароль';

  @override
  String get yesLabel => 'Да';

  @override
  String get noLabel => 'Нет';

  @override
  String get errorRequestingPermission => 'Ошибка при запросе разрешения.';

  @override
  String get errorReceivingBarcodeData => 'Ошибка при получении данных штрих-кода.';

  @override
  String get failedToSetUpBarcodeListener => 'Не удалось настроить слушатель штрих-кода.';

  @override
  String get couldNotToggleFlash => 'Не удалось переключить вспышку.';

  @override
  String get couldNotSwitchCamera => 'Не удалось переключить камеру.';

  @override
  String cameraStartError(String error) {
    return 'Не удалось запустить камеру. Ошибка: $error';
  }

  @override
  String get cameraGenericError => 'Произошла непредвиденная ошибка при запуске камеры.';

  @override
  String get cameraPermissionDeniedInSettings => 'Доступ к камере запрещен. Пожалуйста, предоставьте разрешение в настройках.';

  @override
  String get cameraPermissionDeniedOrRevoked => 'Доступ к камере запрещен или отозван.\nПожалуйста, предоставьте разрешение в настройках приложения.';

  @override
  String get cameraNotSupported => 'Камера недоступна или не поддерживается на этом устройстве.';

  @override
  String get fileScreenTitle => 'Сканировать из файла';

  @override
  String get pickImageButtonText => 'Выбрать изображение и сканировать';

  @override
  String get fileScreenInstruction => 'Выберите изображение с QR-кодом из вашей галереи.';

  @override
  String get chooseImageMessage => 'Выберите изображение...';

  @override
  String get processingMessage => 'Обработка...';

  @override
  String get scanningImageMessage => 'Сканирование изображения...';

  @override
  String get noCodeFoundMessage => 'В QR-коде не найден читаемый код.';

  @override
  String get noQrCodeFoundMessage => 'В выбранном изображении не найден QR-код.';

  @override
  String imageScanError(String error) {
    return 'Ошибка при сканировании изображения: $error';
  }

  @override
  String get settingsScreenTitle => 'Настройки';

  @override
  String get appearanceSectionTitle => 'Внешний вид';

  @override
  String get applicationSectionTitle => 'Приложение';

  @override
  String get lightThemeLabel => 'Светлая';

  @override
  String get darkThemeLabel => 'Темная';

  @override
  String get systemThemeLabel => 'Системная';

  @override
  String get checkForUpdatesLabel => 'Проверить обновления';

  @override
  String get versionLoadingText => 'Загрузка...';

  @override
  String get versionErrorText => 'Ошибка загрузки версии';

  @override
  String versionFormat(String version, String buildNumber) {
    return 'Версия $version ($buildNumber)';
  }

  @override
  String get updateScreenTitle => 'Обновление приложения';

  @override
  String get checkingForUpdates => 'Проверка обновлений...';

  @override
  String get updateAvailable => 'Доступно обновление!';

  @override
  String currentVersionLabel(String version) {
    return 'Текущая версия: $version';
  }

  @override
  String newVersionLabel(String version) {
    return 'Новая версия: $version';
  }

  @override
  String latestVersionLabel(String version) {
    return '(Последняя доступная: $version)';
  }

  @override
  String get downloadAndInstallButton => 'Скачать и установить';

  @override
  String downloadingUpdate(String version) {
    return 'Загрузка обновления ($version)...';
  }

  @override
  String downloadProgress(String progress) {
    return '$progress%';
  }

  @override
  String get startingInstall => 'Начало установки...';

  @override
  String get updateFailed => 'Ошибка обновления';

  @override
  String get retryCheckButton => 'Повторить проверку';

  @override
  String get upToDate => 'У вас последняя версия!';

  @override
  String get checkAgainButton => 'Проверить снова';

  @override
  String get installDialogShown => 'Показано диалоговое окно установки';

  @override
  String get noUpdateAvailable => 'Нет доступных обновлений.';

  @override
  String get unexpectedErrorDuringCheck => 'Произошла непредвиденная ошибка при проверке.';

  @override
  String get updateInfoIncomplete => 'Информация об обновлении неполная.';

  @override
  String get downloadFailed => 'Ошибка загрузки. Проверьте соединение и разрешения.';

  @override
  String get installationFailed => 'Не удалось начать установку. Проверьте разрешения.';
}
