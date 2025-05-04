// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'Yksinkertainen Skanneri';

  @override
  String get languageSectionTitle => 'Kieli';

  @override
  String get scannerTabLabel => 'Kamera';

  @override
  String get fileTabLabel => 'Tiedosto';

  @override
  String get settingsTabLabel => 'Asetukset';

  @override
  String get scannerTabTitle => 'Skannaa QR-koodi';

  @override
  String get scannerTabScanText => 'Kohdista QR-koodi kehykseen skannataksesi';

  @override
  String get cameraPermissionRequestText => 'Kameran käyttöoikeus vaaditaan QR-koodien skannaamiseen. Anna lupa.';

  @override
  String get cameraPermissionRestrictedText => 'Kameran käyttö on rajoitettu (esim. laitekäytännön tai vanhempien valvontojen vuoksi). Skannaus ei ole mahdollista.';

  @override
  String get cameraPermissionPermanentlyDeniedText => 'Kameran käyttöoikeus on pysyvästi evätty. Ota se käyttöön sovelluksen asetuksista skannataksesi QR-koodeja.';

  @override
  String get openSettingsText => 'Avaa Asetukset';

  @override
  String get grantPermissionText => 'Anna Lupa';

  @override
  String couldNotPerformActionText(String uri) {
    return 'Toiminnon suorittaminen epäonnistui kohteelle $uri';
  }

  @override
  String urlLaunchError(String error) {
    return 'Linkin avaaminen epäonnistui: $error';
  }

  @override
  String get scanResultTitle => 'Skannauksen Tulos';

  @override
  String get scanSuccessful => 'Skannaus Onnistui!';

  @override
  String get copyRawValue => 'Kopioi Raaka Arvo';

  @override
  String get rawValueCopied => 'Raaka arvo kopioitu!';

  @override
  String get linkFound => 'Linkki Löytyi!';

  @override
  String get openLink => 'Avaa Linkki';

  @override
  String get phoneNumberFound => 'Puhelinnumero Löytyi!';

  @override
  String get dialNumber => 'Soita Numeroon';

  @override
  String get emailAddressFound => 'Sähköpostiosoite Löytyi!';

  @override
  String get sendEmail => 'Lähetä Sähköposti';

  @override
  String get copyEmailAddress => 'Kopioi Sähköpostiosoite';

  @override
  String get emailAddressCopied => 'Sähköpostiosoite kopioitu!';

  @override
  String get smsDetailsFound => 'SMS-tiedot Löytyivät!';

  @override
  String get sendSms => 'Lähetä SMS';

  @override
  String get wifiNetworkFound => 'Wi-Fi-verkko Löytyi!';

  @override
  String get copyWifiInfo => 'Kopioi Wi-Fi-tiedot';

  @override
  String get wifiCredentialsCopied => 'Wi-Fi-kirjautumistiedot kopioitu leikepöydälle!';

  @override
  String get wifiManualNote => 'Huom: Liitä kopioitu tieto Wi-Fi-asetuksiin manuaalisesti.';

  @override
  String get contactInfoFound => 'Yhteystiedot Löytyivät!';

  @override
  String get exportVCard => 'Vie vCard (.vcf)';

  @override
  String get vCardSaved => 'vCard tallennettu onnistuneesti!';

  @override
  String get vCardExportCancelled => 'vCard-vienti peruutettu tai epäonnistui.';

  @override
  String vCardExportError(String error) {
    return 'Virhe vCard-viennissä: $error';
  }

  @override
  String get locationFound => 'Sijainti Löytyi!';

  @override
  String get openInMaps => 'Avaa Kartassa';

  @override
  String get calendarEventFound => 'Kalenteritapahtuma Löytyi!';

  @override
  String get textFound => 'Teksti Löytyi';

  @override
  String get isbnFound => 'ISBN Löytyi';

  @override
  String get productCodeFound => 'Tuotekoodi Löytyi';

  @override
  String get driverLicenseFound => 'Kuljettajan Lisenssi Löytyi';

  @override
  String get contactInfoLabel => 'Yhteystiedot (vCard):';

  @override
  String get saveContactDialogTitle => 'Tallenna Yhteystieto';

  @override
  String get noneLabel => '(ei mitään)';

  @override
  String get calendarEventLabel => 'Kalenteritapahtuma (iCal):';

  @override
  String get driverLicenseLabel => 'Kuljettajan Lisenssin Tiedot:';

  @override
  String get rawDataLabel => 'Raaka Data:';

  @override
  String get nameLabel => 'Nimi:';

  @override
  String get organizationLabel => 'Organisaatio:';

  @override
  String get titleLabel => 'Titteli:';

  @override
  String get phoneLabel => 'Puhelin:';

  @override
  String get emailLabel => 'Sähköposti:';

  @override
  String get addressLabel => 'Osoite:';

  @override
  String get websiteLabel => 'Verkkosivu:';

  @override
  String get noteLabel => 'Huomautus:';

  @override
  String get wifiNetworkLabel => 'Wi-Fi-verkko:';

  @override
  String get ssidLabel => 'SSID:';

  @override
  String get typeLabel => 'Tyyppi:';

  @override
  String get passwordLabel => 'Salasana:';

  @override
  String get noPasswordLabel => 'Ei saatavilla (ei salasanaa)';

  @override
  String get hiddenLabel => 'Piilotettu:';

  @override
  String get toLabel => 'Vastaanottaja:';

  @override
  String get subjectLabel => 'Aihe:';

  @override
  String get bodyLabel => 'Viesti:';

  @override
  String get latitudeLabel => 'Leveysaste:';

  @override
  String get longitudeLabel => 'Pituusaste:';

  @override
  String get altitudeLabel => 'Korkeus:';

  @override
  String get labelLabel => 'Nimike:';

  @override
  String get noVCardData => 'Ei vCard-tietoja vietäväksi.';

  @override
  String get hidePasswordTooltip => 'Piilota salasana';

  @override
  String get showPasswordTooltip => 'Näytä salasana';

  @override
  String get yesLabel => 'Kyllä';

  @override
  String get noLabel => 'Ei';

  @override
  String get errorRequestingPermission => 'Virhe lupaa pyydettäessä.';

  @override
  String get errorReceivingBarcodeData => 'Virhe viivakooditietojen vastaanotossa.';

  @override
  String get failedToSetUpBarcodeListener => 'Viivakoodin kuuntelijan asettaminen epäonnistui.';

  @override
  String get couldNotToggleFlash => 'Salakuvan vaihtaminen epäonnistui.';

  @override
  String get couldNotSwitchCamera => 'Kameran vaihtaminen epäonnistui.';

  @override
  String cameraStartError(String error) {
    return 'Kameran käynnistys epäonnistui. Virhe: $error';
  }

  @override
  String get cameraGenericError => 'Kameran käynnistyksessä tapahtui odottamaton virhe.';

  @override
  String get cameraPermissionDeniedInSettings => 'Kameran käyttöoikeus evätty. Anna lupa asetuksista.';

  @override
  String get cameraPermissionDeniedOrRevoked => 'Kameran käyttöoikeus evätty tai peruutettu.\nAnna lupa sovelluksen asetuksista.';

  @override
  String get cameraNotSupported => 'Kamera ei ole saatavilla tai sitä ei tueta tällä laitteella.';

  @override
  String get fileScreenTitle => 'Skannaa Tiedostosta';

  @override
  String get pickImageButtonText => 'Valitse Kuva ja Skannaa';

  @override
  String get fileScreenInstruction => 'Valitse kuvagalleriastasi kuva, joka sisältää QR-koodin.';

  @override
  String get chooseImageMessage => 'Valitse kuva...';

  @override
  String get processingMessage => 'Käsitellään...';

  @override
  String get scanningImageMessage => 'Skannataan kuvaa...';

  @override
  String get noCodeFoundMessage => 'Kuvasta ei löytynyt luettavaa koodia.';

  @override
  String get noQrCodeFoundMessage => 'Valitusta kuvasta ei löytynyt QR-koodia.';

  @override
  String imageScanError(String error) {
    return 'Virhe kuvan skannauksessa: $error';
  }

  @override
  String get settingsScreenTitle => 'Asetukset';

  @override
  String get appearanceSectionTitle => 'Ulkoasu';

  @override
  String get applicationSectionTitle => 'Sovellus';

  @override
  String get lightThemeLabel => 'Vaalea';

  @override
  String get darkThemeLabel => 'Tumma';

  @override
  String get systemThemeLabel => 'Järjestelmä';

  @override
  String get checkForUpdatesLabel => 'Tarkista Päivitykset';

  @override
  String get versionLoadingText => 'Ladataan...';

  @override
  String get versionErrorText => 'Virhe version latauksessa';

  @override
  String versionFormat(String version, String buildNumber) {
    return 'Versio $version ($buildNumber)';
  }

  @override
  String get updateScreenTitle => 'Sovelluksen Päivitys';

  @override
  String get checkingForUpdates => 'Tarkistetaan päivityksiä...';

  @override
  String get updateAvailable => 'Päivitys Saatavilla!';

  @override
  String currentVersionLabel(String version) {
    return 'Nykyinen versio: $version';
  }

  @override
  String newVersionLabel(String version) {
    return 'Uusi versio: $version';
  }

  @override
  String latestVersionLabel(String version) {
    return '(Viimeisin saatavilla: $version)';
  }

  @override
  String get downloadAndInstallButton => 'Lataa ja Asenna';

  @override
  String downloadingUpdate(String version) {
    return 'Ladataan päivitystä ($version)...';
  }

  @override
  String downloadProgress(String progress) {
    return '$progress%';
  }

  @override
  String get startingInstall => 'Aloitetaan asennus...';

  @override
  String get updateFailed => 'Päivitys Epäonnistui';

  @override
  String get retryCheckButton => 'Yritä Uudelleen';

  @override
  String get upToDate => 'Olet ajan tasalla!';

  @override
  String get checkAgainButton => 'Tarkista Uudelleen';

  @override
  String get installDialogShown => 'Asennusikkuna näytetty';

  @override
  String get noUpdateAvailable => 'Uusia päivityksiä ei saatavilla.';

  @override
  String get unexpectedErrorDuringCheck => 'Päivitysten tarkistuksessa tapahtui odottamaton virhe.';

  @override
  String get updateInfoIncomplete => 'Päivitystiedot ovat puutteelliset.';

  @override
  String get downloadFailed => 'Lataus epäonnistui. Tarkista yhteys ja käyttöoikeudet.';

  @override
  String get installationFailed => 'Asennuksen aloittaminen epäonnistui. Tarkista käyttöoikeudet.';
}
