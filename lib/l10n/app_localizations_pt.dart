// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Scanner Simples';

  @override
  String get languageSectionTitle => 'Idioma';

  @override
  String get scannerTabLabel => 'Câmera';

  @override
  String get fileTabLabel => 'Arquivo';

  @override
  String get settingsTabLabel => 'Configurações';

  @override
  String get scannerTabTitle => 'Escanear Código QR';

  @override
  String get scannerTabScanText => 'Alinhe o código QR dentro do quadro para escanear';

  @override
  String get cameraPermissionRequestText => 'É necessária permissão da câmera para escanear códigos QR. Por favor, conceda a permissão.';

  @override
  String get cameraPermissionRestrictedText => 'O acesso à câmera está restrito (por exemplo, por política do dispositivo ou controles parentais). O escaneamento não está disponível.';

  @override
  String get cameraPermissionPermanentlyDeniedText => 'A permissão da câmera foi permanentemente negada. Por favor, habilite-a nas configurações do aplicativo para escanear códigos QR.';

  @override
  String get openSettingsText => 'Abrir Configurações';

  @override
  String get grantPermissionText => 'Conceder Permissão';

  @override
  String couldNotPerformActionText(String uri) {
    return 'Não foi possível realizar a ação para $uri';
  }

  @override
  String urlLaunchError(String error) {
    return 'Erro ao abrir o link: $error';
  }

  @override
  String get scanResultTitle => 'Resultado do Escaneamento';

  @override
  String get scanSuccessful => 'Escaneamento Bem-Sucedido!';

  @override
  String get copyRawValue => 'Copiar Valor Bruto';

  @override
  String get rawValueCopied => 'Valor bruto copiado!';

  @override
  String get linkFound => 'Link Encontrado!';

  @override
  String get openLink => 'Abrir Link';

  @override
  String get phoneNumberFound => 'Número de Telefone Encontrado!';

  @override
  String get dialNumber => 'Discar Número';

  @override
  String get emailAddressFound => 'Endereço de E-mail Encontrado!';

  @override
  String get sendEmail => 'Enviar E-mail';

  @override
  String get copyEmailAddress => 'Copiar Endereço de E-mail';

  @override
  String get emailAddressCopied => 'Endereço de e-mail copiado!';

  @override
  String get smsDetailsFound => 'Detalhes de SMS Encontrados!';

  @override
  String get sendSms => 'Enviar SMS';

  @override
  String get wifiNetworkFound => 'Rede Wi-Fi Encontrada!';

  @override
  String get copyWifiInfo => 'Copiar Informações do Wi-Fi';

  @override
  String get wifiCredentialsCopied => 'Credenciais do Wi-Fi copiadas para a área de transferência!';

  @override
  String get wifiManualNote => 'Nota: Cole as informações copiadas nas configurações de Wi-Fi manualmente.';

  @override
  String get contactInfoFound => 'Informações de Contato Encontradas!';

  @override
  String get exportVCard => 'Exportar vCard (.vcf)';

  @override
  String get vCardSaved => 'vCard salvo com sucesso!';

  @override
  String get vCardExportCancelled => 'Exportação de vCard cancelada ou falhou.';

  @override
  String vCardExportError(String error) {
    return 'Erro ao exportar vCard: $error';
  }

  @override
  String get locationFound => 'Localização Encontrada!';

  @override
  String get openInMaps => 'Abrir no Mapas';

  @override
  String get calendarEventFound => 'Evento de Calendário Encontrado!';

  @override
  String get textFound => 'Texto Encontrado';

  @override
  String get isbnFound => 'ISBN Encontrado';

  @override
  String get productCodeFound => 'Código de Produto Encontrado';

  @override
  String get driverLicenseFound => 'Carteira de Motorista Encontrada';

  @override
  String get contactInfoLabel => 'Informações de Contato (vCard):';

  @override
  String get saveContactDialogTitle => 'Salvar Contato';

  @override
  String get noneLabel => '(nenhum)';

  @override
  String get calendarEventLabel => 'Evento de Calendário (iCal):';

  @override
  String get driverLicenseLabel => 'Dados da Carteira de Motorista:';

  @override
  String get rawDataLabel => 'Dados Brutos:';

  @override
  String get nameLabel => 'Nome:';

  @override
  String get organizationLabel => 'Organização:';

  @override
  String get titleLabel => 'Título:';

  @override
  String get phoneLabel => 'Telefone:';

  @override
  String get emailLabel => 'E-mail:';

  @override
  String get addressLabel => 'Endereço:';

  @override
  String get websiteLabel => 'Website:';

  @override
  String get noteLabel => 'Nota:';

  @override
  String get wifiNetworkLabel => 'Rede Wi-Fi:';

  @override
  String get ssidLabel => 'SSID:';

  @override
  String get typeLabel => 'Tipo:';

  @override
  String get passwordLabel => 'Senha:';

  @override
  String get noPasswordLabel => 'N/D (talvez sem senha)';

  @override
  String get hiddenLabel => 'Oculto:';

  @override
  String get toLabel => 'Para:';

  @override
  String get subjectLabel => 'Assunto:';

  @override
  String get bodyLabel => 'Corpo:';

  @override
  String get latitudeLabel => 'Latitude:';

  @override
  String get longitudeLabel => 'Longitude:';

  @override
  String get altitudeLabel => 'Altitude:';

  @override
  String get labelLabel => 'Rótulo:';

  @override
  String get noVCardData => 'Nenhum dado vCard para exportar.';

  @override
  String get hidePasswordTooltip => 'Ocultar senha';

  @override
  String get showPasswordTooltip => 'Mostrar senha';

  @override
  String get yesLabel => 'Sim';

  @override
  String get noLabel => 'Não';

  @override
  String get errorRequestingPermission => 'Erro ao solicitar permissão.';

  @override
  String get errorReceivingBarcodeData => 'Erro ao receber dados do código de barras.';

  @override
  String get failedToSetUpBarcodeListener => 'Falha ao configurar o ouvinte de código de barras.';

  @override
  String get couldNotToggleFlash => 'Não foi possível alternar o flash.';

  @override
  String get couldNotSwitchCamera => 'Não foi possível trocar a câmera.';

  @override
  String cameraStartError(String error) {
    return 'Falha ao iniciar a câmera. Erro: $error';
  }

  @override
  String get cameraGenericError => 'Ocorreu um erro inesperado ao iniciar a câmera.';

  @override
  String get cameraPermissionDeniedInSettings => 'Permissão da câmera negada. Por favor, conceda a permissão nas configurações.';

  @override
  String get cameraPermissionDeniedOrRevoked => 'A permissão da câmera foi negada ou revogada.\nPor favor, conceda a permissão nas configurações do aplicativo.';

  @override
  String get cameraNotSupported => 'A câmera não está disponível ou não é suportada neste dispositivo.';

  @override
  String get fileScreenTitle => 'Escanear de Arquivo';

  @override
  String get pickImageButtonText => 'Escolher Imagem e Escanear';

  @override
  String get fileScreenInstruction => 'Selecione uma imagem contendo um código QR da sua galeria.';

  @override
  String get chooseImageMessage => 'Escolher uma imagem...';

  @override
  String get processingMessage => 'Processando...';

  @override
  String get scanningImageMessage => 'Escaneando imagem...';

  @override
  String get noCodeFoundMessage => 'Nenhum código legível encontrado no código QR.';

  @override
  String get noQrCodeFoundMessage => 'Nenhum código QR encontrado na imagem selecionada.';

  @override
  String imageScanError(String error) {
    return 'Erro ao escanear a imagem: $error';
  }

  @override
  String get settingsScreenTitle => 'Configurações';

  @override
  String get appearanceSectionTitle => 'Aparência';

  @override
  String get applicationSectionTitle => 'Aplicativo';

  @override
  String get lightThemeLabel => 'Claro';

  @override
  String get darkThemeLabel => 'Escuro';

  @override
  String get systemThemeLabel => 'Sistema';

  @override
  String get checkForUpdatesLabel => 'Verificar Atualizações';

  @override
  String get versionLoadingText => 'Carregando...';

  @override
  String get versionErrorText => 'Erro ao carregar a versão';

  @override
  String versionFormat(String version, String buildNumber) {
    return 'Versão $version ($buildNumber)';
  }

  @override
  String get updateScreenTitle => 'Atualização do Aplicativo';

  @override
  String get checkingForUpdates => 'Verificando atualizações...';

  @override
  String get updateAvailable => 'Atualização Disponível!';

  @override
  String currentVersionLabel(String version) {
    return 'Versão atual: $version';
  }

  @override
  String newVersionLabel(String version) {
    return 'Nova versão: $version';
  }

  @override
  String latestVersionLabel(String version) {
    return '(Última disponível: $version)';
  }

  @override
  String get downloadAndInstallButton => 'Baixar e Instalar';

  @override
  String downloadingUpdate(String version) {
    return 'Baixando atualização ($version)...';
  }

  @override
  String downloadProgress(String progress) {
    return '$progress%';
  }

  @override
  String get startingInstall => 'Iniciando instalação...';

  @override
  String get updateFailed => 'Atualização Falhou';

  @override
  String get retryCheckButton => 'Tentar Novamente';

  @override
  String get upToDate => 'Você está atualizado!';

  @override
  String get checkAgainButton => 'Verificar Novamente';

  @override
  String get installDialogShown => 'Diálogo de instalação exibido';

  @override
  String get noUpdateAvailable => 'Nenhuma nova atualização disponível.';

  @override
  String get unexpectedErrorDuringCheck => 'Ocorreu um erro inesperado durante a verificação.';

  @override
  String get updateInfoIncomplete => 'Informações de atualização incompletas.';

  @override
  String get downloadFailed => 'Falha no download. Verifique a conexão e permissões.';

  @override
  String get installationFailed => 'Não foi possível iniciar a instalação. Verifique as permissões.';
}
