// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Escáner Simple';

  @override
  String get languageSectionTitle => 'Idioma';

  @override
  String get scannerTabLabel => 'Cámara';

  @override
  String get fileTabLabel => 'Archivo';

  @override
  String get settingsTabLabel => 'Configuración';

  @override
  String get scannerTabTitle => 'Escanear Código QR';

  @override
  String get scannerTabScanText => 'Alinea el código QR dentro del marco para escanear';

  @override
  String get cameraPermissionRequestText => 'Se requiere permiso de cámara para escanear códigos QR. Por favor, concede el permiso.';

  @override
  String get cameraPermissionRestrictedText => 'El acceso a la cámara está restringido (por ejemplo, por políticas del dispositivo o controles parentales). El escaneo no está disponible.';

  @override
  String get cameraPermissionPermanentlyDeniedText => 'El permiso de cámara está denegado permanentemente. Por favor, actívalo en la configuración de la aplicación para escanear códigos QR.';

  @override
  String get openSettingsText => 'Abrir Configuración';

  @override
  String get grantPermissionText => 'Conceder Permiso';

  @override
  String couldNotPerformActionText(String uri) {
    return 'No se pudo realizar la acción para $uri';
  }

  @override
  String urlLaunchError(String error) {
    return 'Error al abrir el enlace: $error';
  }

  @override
  String get scanResultTitle => 'Resultado del Escaneo';

  @override
  String get scanSuccessful => '¡Escaneo Exitoso!';

  @override
  String get copyRawValue => 'Copiar Valor Original';

  @override
  String get rawValueCopied => '¡Valor original copiado!';

  @override
  String get linkFound => '¡Enlace Encontrado!';

  @override
  String get openLink => 'Abrir Enlace';

  @override
  String get phoneNumberFound => '¡Número de Teléfono Encontrado!';

  @override
  String get dialNumber => 'Marcar Número';

  @override
  String get emailAddressFound => '¡Correo Electrónico Encontrado!';

  @override
  String get sendEmail => 'Enviar Correo';

  @override
  String get copyEmailAddress => 'Copiar Correo Electrónico';

  @override
  String get emailAddressCopied => '¡Correo electrónico copiado!';

  @override
  String get smsDetailsFound => '¡Detalles de SMS Encontrados!';

  @override
  String get sendSms => 'Enviar SMS';

  @override
  String get wifiNetworkFound => '¡Red Wi-Fi Encontrada!';

  @override
  String get copyWifiInfo => 'Copiar Información Wi-Fi';

  @override
  String get wifiCredentialsCopied => '¡Credenciales Wi-Fi copiadas al portapapeles!';

  @override
  String get wifiManualNote => 'Nota: Pega la información copiada en la configuración de Wi-Fi manualmente.';

  @override
  String get contactInfoFound => '¡Información de Contacto Encontrada!';

  @override
  String get exportVCard => 'Exportar vCard (.vcf)';

  @override
  String get vCardSaved => '¡vCard guardada con éxito!';

  @override
  String get vCardExportCancelled => 'Exportación de vCard cancelada o fallida.';

  @override
  String vCardExportError(String error) {
    return 'Error al exportar vCard: $error';
  }

  @override
  String get locationFound => '¡Ubicación Encontrada!';

  @override
  String get openInMaps => 'Abrir en Mapas';

  @override
  String get calendarEventFound => '¡Evento de Calendario Encontrado!';

  @override
  String get textFound => 'Texto Encontrado';

  @override
  String get isbnFound => 'ISBN Encontrado';

  @override
  String get productCodeFound => 'Código de Producto Encontrado';

  @override
  String get driverLicenseFound => 'Licencia de Conducir Encontrada';

  @override
  String get contactInfoLabel => 'Información de Contacto (vCard):';

  @override
  String get saveContactDialogTitle => 'Guardar Contacto';

  @override
  String get noneLabel => '(ninguno)';

  @override
  String get calendarEventLabel => 'Evento de Calendario (iCal):';

  @override
  String get driverLicenseLabel => 'Datos de Licencia de Conducir:';

  @override
  String get rawDataLabel => 'Datos Originales:';

  @override
  String get nameLabel => 'Nombre:';

  @override
  String get organizationLabel => 'Organización:';

  @override
  String get titleLabel => 'Título:';

  @override
  String get phoneLabel => 'Teléfono:';

  @override
  String get emailLabel => 'Correo Electrónico:';

  @override
  String get addressLabel => 'Dirección:';

  @override
  String get websiteLabel => 'Sitio Web:';

  @override
  String get noteLabel => 'Nota:';

  @override
  String get wifiNetworkLabel => 'Red Wi-Fi:';

  @override
  String get ssidLabel => 'SSID:';

  @override
  String get typeLabel => 'Tipo:';

  @override
  String get passwordLabel => 'Contraseña:';

  @override
  String get noPasswordLabel => 'N/A (puede que no tenga contraseña)';

  @override
  String get hiddenLabel => 'Oculto:';

  @override
  String get toLabel => 'Para:';

  @override
  String get subjectLabel => 'Asunto:';

  @override
  String get bodyLabel => 'Cuerpo:';

  @override
  String get latitudeLabel => 'Latitud:';

  @override
  String get longitudeLabel => 'Longitud:';

  @override
  String get altitudeLabel => 'Altitud:';

  @override
  String get labelLabel => 'Etiqueta:';

  @override
  String get noVCardData => 'No hay datos vCard para exportar.';

  @override
  String get hidePasswordTooltip => 'Ocultar contraseña';

  @override
  String get showPasswordTooltip => 'Mostrar contraseña';

  @override
  String get yesLabel => 'Sí';

  @override
  String get noLabel => 'No';

  @override
  String get errorRequestingPermission => 'Error al solicitar permiso.';

  @override
  String get errorReceivingBarcodeData => 'Error al recibir datos del código de barras.';

  @override
  String get failedToSetUpBarcodeListener => 'Error al configurar el escuchador de códigos de barras.';

  @override
  String get couldNotToggleFlash => 'No se pudo alternar el flash.';

  @override
  String get couldNotSwitchCamera => 'No se pudo cambiar de cámara.';

  @override
  String cameraStartError(String error) {
    return 'Error al iniciar la cámara. Error: $error';
  }

  @override
  String get cameraGenericError => 'Ocurrió un error inesperado al iniciar la cámara.';

  @override
  String get cameraPermissionDeniedInSettings => 'Permiso de cámara denegado. Por favor, concede el permiso en la configuración.';

  @override
  String get cameraPermissionDeniedOrRevoked => 'El permiso de cámara fue denegado o revocado.\nPor favor, concede el permiso en la configuración de la aplicación.';

  @override
  String get cameraNotSupported => 'La cámara no está disponible o no es compatible con este dispositivo.';

  @override
  String get fileScreenTitle => 'Escanear desde Archivo';

  @override
  String get pickImageButtonText => 'Seleccionar Imagen y Escanear';

  @override
  String get fileScreenInstruction => 'Selecciona una imagen que contenga un código QR de tu galería.';

  @override
  String get chooseImageMessage => 'Elige una imagen...';

  @override
  String get processingMessage => 'Procesando...';

  @override
  String get scanningImageMessage => 'Escaneando imagen...';

  @override
  String get noCodeFoundMessage => 'No se encontró un código legible en el código QR.';

  @override
  String get noQrCodeFoundMessage => 'No se encontró ningún código QR en la imagen seleccionada.';

  @override
  String imageScanError(String error) {
    return 'Error al escanear la imagen: $error';
  }

  @override
  String get settingsScreenTitle => 'Configuración';

  @override
  String get appearanceSectionTitle => 'Apariencia';

  @override
  String get applicationSectionTitle => 'Aplicación';

  @override
  String get lightThemeLabel => 'Claro';

  @override
  String get darkThemeLabel => 'Oscuro';

  @override
  String get systemThemeLabel => 'Sistema';

  @override
  String get checkForUpdatesLabel => 'Buscar Actualizaciones';

  @override
  String get versionLoadingText => 'Cargando...';

  @override
  String get versionErrorText => 'Error al cargar la versión';

  @override
  String versionFormat(String version, String buildNumber) {
    return 'Versión $version ($buildNumber)';
  }

  @override
  String get updateScreenTitle => 'Actualización de la Aplicación';

  @override
  String get checkingForUpdates => 'Buscando actualizaciones...';

  @override
  String get updateAvailable => '¡Actualización Disponible!';

  @override
  String currentVersionLabel(String version) {
    return 'Versión actual: $version';
  }

  @override
  String newVersionLabel(String version) {
    return 'Nueva versión: $version';
  }

  @override
  String latestVersionLabel(String version) {
    return '(Última disponible: $version)';
  }

  @override
  String get downloadAndInstallButton => 'Descargar e Instalar';

  @override
  String downloadingUpdate(String version) {
    return 'Descargando actualización ($version)...';
  }

  @override
  String downloadProgress(String progress) {
    return '$progress%';
  }

  @override
  String get startingInstall => 'Iniciando instalación...';

  @override
  String get updateFailed => 'Actualización Fallida';

  @override
  String get retryCheckButton => 'Reintentar Búsqueda';

  @override
  String get upToDate => '¡Estás al día!';

  @override
  String get checkAgainButton => 'Buscar de Nuevo';

  @override
  String get installDialogShown => 'Diálogo de instalación mostrado';

  @override
  String get noUpdateAvailable => 'No hay actualizaciones disponibles.';

  @override
  String get unexpectedErrorDuringCheck => 'Ocurrió un error inesperado durante la búsqueda.';

  @override
  String get updateInfoIncomplete => 'La información de actualización está incompleta.';

  @override
  String get downloadFailed => 'Descarga fallida. Verifica la conexión y los permisos.';

  @override
  String get installationFailed => 'No se pudo iniciar la instalación. Verifica los permisos.';
}
