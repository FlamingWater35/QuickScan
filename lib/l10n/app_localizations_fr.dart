// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Scanner Simple';

  @override
  String get languageSectionTitle => 'Langue';

  @override
  String get scannerTabLabel => 'Caméra';

  @override
  String get fileTabLabel => 'Fichier';

  @override
  String get settingsTabLabel => 'Paramètres';

  @override
  String get scannerTabTitle => 'Scanner un QR Code';

  @override
  String get scannerTabScanText => 'Alignez le QR code dans le cadre pour le scanner';

  @override
  String get cameraPermissionRequestText => 'L\'autorisation de la caméra est requise pour scanner les QR codes. Veuillez accorder la permission.';

  @override
  String get cameraPermissionRestrictedText => 'L\'accès à la caméra est restreint (par exemple, par une politique d\'appareil ou des contrôles parentaux). Le scan est indisponible.';

  @override
  String get cameraPermissionPermanentlyDeniedText => 'L\'autorisation de la caméra est refusée de manière permanente. Veuillez l\'activer dans les paramètres de l\'application pour scanner les QR codes.';

  @override
  String get openSettingsText => 'Ouvrir les Paramètres';

  @override
  String get grantPermissionText => 'Accorder la Permission';

  @override
  String couldNotPerformActionText(String uri) {
    return 'Impossible d\'effectuer l\'action pour $uri';
  }

  @override
  String urlLaunchError(String error) {
    return 'Erreur lors du lancement du lien : $error';
  }

  @override
  String get scanResultTitle => 'Résultat du Scan';

  @override
  String get scanSuccessful => 'Scan Réussi !';

  @override
  String get copyRawValue => 'Copier la Valeur Brute';

  @override
  String get rawValueCopied => 'Valeur brute copiée !';

  @override
  String get linkFound => 'Lien Trouvé !';

  @override
  String get openLink => 'Ouvrir le Lien';

  @override
  String get phoneNumberFound => 'Numéro de Téléphone Trouvé !';

  @override
  String get dialNumber => 'Composer le Numéro';

  @override
  String get emailAddressFound => 'Adresse Email Trouvée !';

  @override
  String get sendEmail => 'Envoyer un Email';

  @override
  String get copyEmailAddress => 'Copier l\'Adresse Email';

  @override
  String get emailAddressCopied => 'Adresse email copiée !';

  @override
  String get smsDetailsFound => 'Détails de SMS Trouvés !';

  @override
  String get sendSms => 'Envoyer un SMS';

  @override
  String get wifiNetworkFound => 'Réseau Wi-Fi Trouvé !';

  @override
  String get copyWifiInfo => 'Copier les Infos Wi-Fi';

  @override
  String get wifiCredentialsCopied => 'Identifiants Wi-Fi copiés !';

  @override
  String get wifiManualNote => 'Note : Collez les informations copiées dans les paramètres Wi-Fi manuellement.';

  @override
  String get contactInfoFound => 'Informations de Contact Trouvées !';

  @override
  String get exportVCard => 'Exporter vCard (.vcf)';

  @override
  String get vCardSaved => 'vCard enregistrée avec succès !';

  @override
  String get vCardExportCancelled => 'Export de vCard annulé ou échoué.';

  @override
  String vCardExportError(String error) {
    return 'Erreur lors de l\'export de la vCard : $error';
  }

  @override
  String get locationFound => 'Localisation Trouvée !';

  @override
  String get openInMaps => 'Ouvrir dans les Cartes';

  @override
  String get calendarEventFound => 'Événement Calendrier Trouvé !';

  @override
  String get textFound => 'Texte Trouvé';

  @override
  String get isbnFound => 'ISBN Trouvé';

  @override
  String get productCodeFound => 'Code Produit Trouvé';

  @override
  String get driverLicenseFound => 'Permis de Conduire Trouvé';

  @override
  String get contactInfoLabel => 'Informations de Contact (vCard) :';

  @override
  String get saveContactDialogTitle => 'Enregistrer le Contact';

  @override
  String get noneLabel => '(aucun)';

  @override
  String get calendarEventLabel => 'Événement Calendrier (iCal) :';

  @override
  String get driverLicenseLabel => 'Données du Permis de Conduire :';

  @override
  String get rawDataLabel => 'Données Brutes :';

  @override
  String get nameLabel => 'Nom :';

  @override
  String get organizationLabel => 'Organisation :';

  @override
  String get titleLabel => 'Titre :';

  @override
  String get phoneLabel => 'Téléphone :';

  @override
  String get emailLabel => 'Email :';

  @override
  String get addressLabel => 'Adresse :';

  @override
  String get websiteLabel => 'Site Web :';

  @override
  String get noteLabel => 'Note :';

  @override
  String get wifiNetworkLabel => 'Réseau Wi-Fi :';

  @override
  String get ssidLabel => 'SSID :';

  @override
  String get typeLabel => 'Type :';

  @override
  String get passwordLabel => 'Mot de Passe :';

  @override
  String get noPasswordLabel => 'N/A (peut-être sans mot de passe)';

  @override
  String get hiddenLabel => 'Caché :';

  @override
  String get toLabel => 'À :';

  @override
  String get subjectLabel => 'Sujet :';

  @override
  String get bodyLabel => 'Corps :';

  @override
  String get latitudeLabel => 'Latitude :';

  @override
  String get longitudeLabel => 'Longitude :';

  @override
  String get altitudeLabel => 'Altitude :';

  @override
  String get labelLabel => 'Étiquette :';

  @override
  String get noVCardData => 'Aucune donnée vCard à exporter.';

  @override
  String get hidePasswordTooltip => 'Masquer le mot de passe';

  @override
  String get showPasswordTooltip => 'Afficher le mot de passe';

  @override
  String get yesLabel => 'Oui';

  @override
  String get noLabel => 'Non';

  @override
  String get errorRequestingPermission => 'Erreur lors de la demande de permission.';

  @override
  String get errorReceivingBarcodeData => 'Erreur lors de la réception des données du code-barres.';

  @override
  String get failedToSetUpBarcodeListener => 'Échec de la configuration de l\'écouteur de code-barres.';

  @override
  String get couldNotToggleFlash => 'Impossible d\'activer/désactiver le flash.';

  @override
  String get couldNotSwitchCamera => 'Impossible de changer de caméra.';

  @override
  String cameraStartError(String error) {
    return 'Échec du démarrage de la caméra. Erreur : $error';
  }

  @override
  String get cameraGenericError => 'Une erreur inattendue s\'est produite lors du démarrage de la caméra.';

  @override
  String get cameraPermissionDeniedInSettings => 'Autorisation de la caméra refusée. Veuillez accorder la permission dans les paramètres.';

  @override
  String get cameraPermissionDeniedOrRevoked => 'L\'autorisation de la caméra a été refusée ou révoquée.\nVeuillez accorder la permission dans les paramètres de l\'application.';

  @override
  String get cameraNotSupported => 'La caméra est indisponible ou non supportée sur cet appareil.';

  @override
  String get fileScreenTitle => 'Scanner à partir d\'un Fichier';

  @override
  String get pickImageButtonText => 'Choisir une Image & Scanner';

  @override
  String get fileScreenInstruction => 'Sélectionnez une image contenant un QR code dans votre galerie.';

  @override
  String get chooseImageMessage => 'Choisir une image...';

  @override
  String get processingMessage => 'Traitement...';

  @override
  String get scanningImageMessage => 'Scan de l\'image...';

  @override
  String get noCodeFoundMessage => 'Aucun code lisible trouvé dans le QR code.';

  @override
  String get noQrCodeFoundMessage => 'Aucun QR code trouvé dans l\'image sélectionnée.';

  @override
  String imageScanError(String error) {
    return 'Erreur lors du scan de l\'image : $error';
  }

  @override
  String get settingsScreenTitle => 'Paramètres';

  @override
  String get appearanceSectionTitle => 'Apparence';

  @override
  String get applicationSectionTitle => 'Application';

  @override
  String get lightThemeLabel => 'Clair';

  @override
  String get darkThemeLabel => 'Sombre';

  @override
  String get systemThemeLabel => 'Système';

  @override
  String get checkForUpdatesLabel => 'Vérifier les Mises à Jour';

  @override
  String get versionLoadingText => 'Chargement...';

  @override
  String get versionErrorText => 'Erreur de chargement de la version';

  @override
  String versionFormat(String version, String buildNumber) {
    return 'Version $version ($buildNumber)';
  }

  @override
  String get updateScreenTitle => 'Mise à Jour de l\'Application';

  @override
  String get checkingForUpdates => 'Vérification des mises à jour...';

  @override
  String get updateAvailable => 'Mise à Jour Disponible !';

  @override
  String currentVersionLabel(String version) {
    return 'Version actuelle : $version';
  }

  @override
  String newVersionLabel(String version) {
    return 'Nouvelle version : $version';
  }

  @override
  String latestVersionLabel(String version) {
    return '(Dernière version disponible : $version)';
  }

  @override
  String get downloadAndInstallButton => 'Télécharger & Installer';

  @override
  String downloadingUpdate(String version) {
    return 'Téléchargement de la mise à jour ($version)...';
  }

  @override
  String downloadProgress(String progress) {
    return '$progress%';
  }

  @override
  String get startingInstall => 'Début de l\'installation...';

  @override
  String get updateFailed => 'Échec de la Mise à Jour';

  @override
  String get retryCheckButton => 'Réessayer la Vérification';

  @override
  String get upToDate => 'Vous êtes à jour !';

  @override
  String get checkAgainButton => 'Vérifier à Nouveau';

  @override
  String get installDialogShown => 'Dialogue d\'installation affiché';

  @override
  String get noUpdateAvailable => 'Aucune nouvelle mise à jour disponible.';

  @override
  String get unexpectedErrorDuringCheck => 'Une erreur inattendue s\'est produite lors de la vérification.';

  @override
  String get updateInfoIncomplete => 'Les informations de mise à jour sont incomplètes.';

  @override
  String get downloadFailed => 'Échec du téléchargement. Vérifiez la connexion et les permissions.';

  @override
  String get installationFailed => 'Impossible de démarrer l\'installation. Vérifiez les permissions.';
}
