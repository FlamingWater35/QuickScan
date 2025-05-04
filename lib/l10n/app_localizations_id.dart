// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Pemindai Sederhana';

  @override
  String get languageSectionTitle => 'Bahasa';

  @override
  String get scannerTabLabel => 'Kamera';

  @override
  String get fileTabLabel => 'Berkas';

  @override
  String get settingsTabLabel => 'Pengaturan';

  @override
  String get scannerTabTitle => 'Pindai QR Code';

  @override
  String get scannerTabScanText => 'Sejajarkan QR code dalam bingkai untuk memindai';

  @override
  String get cameraPermissionRequestText => 'Izin kamera diperlukan untuk memindai QR code. Harap berikan izin.';

  @override
  String get cameraPermissionRestrictedText => 'Akses kamera dibatasi (misalnya, oleh kebijakan perangkat atau kontrol orang tua). Pemindaian tidak tersedia.';

  @override
  String get cameraPermissionPermanentlyDeniedText => 'Izin kamera ditolak secara permanen. Harap aktifkan di pengaturan aplikasi untuk memindai QR code.';

  @override
  String get openSettingsText => 'Buka Pengaturan';

  @override
  String get grantPermissionText => 'Berikan Izin';

  @override
  String couldNotPerformActionText(String uri) {
    return 'Tidak dapat melakukan tindakan untuk $uri';
  }

  @override
  String urlLaunchError(String error) {
    return 'Gagal membuka tautan: $error';
  }

  @override
  String get scanResultTitle => 'Hasil Pindaian';

  @override
  String get scanSuccessful => 'Pindaian Berhasil!';

  @override
  String get copyRawValue => 'Salin Nilai Mentah';

  @override
  String get rawValueCopied => 'Nilai mentah disalin!';

  @override
  String get linkFound => 'Tautan Ditemukan!';

  @override
  String get openLink => 'Buka Tautan';

  @override
  String get phoneNumberFound => 'Nomor Telepon Ditemukan!';

  @override
  String get dialNumber => 'Hubungi Nomor';

  @override
  String get emailAddressFound => 'Alamat Email Ditemukan!';

  @override
  String get sendEmail => 'Kirim Email';

  @override
  String get copyEmailAddress => 'Salin Alamat Email';

  @override
  String get emailAddressCopied => 'Alamat email disalin!';

  @override
  String get smsDetailsFound => 'Detail SMS Ditemukan!';

  @override
  String get sendSms => 'Kirim SMS';

  @override
  String get wifiNetworkFound => 'Jaringan Wi-Fi Ditemukan!';

  @override
  String get copyWifiInfo => 'Salin Info Wi-Fi';

  @override
  String get wifiCredentialsCopied => 'Kredensial Wi-Fi disalin!';

  @override
  String get wifiManualNote => 'Catatan: Tempel info yang disalin ke pengaturan Wi-Fi secara manual.';

  @override
  String get contactInfoFound => 'Info Kontak Ditemukan!';

  @override
  String get exportVCard => 'Ekspor vCard (.vcf)';

  @override
  String get vCardSaved => 'vCard berhasil disimpan!';

  @override
  String get vCardExportCancelled => 'Ekspor vCard dibatalkan atau gagal.';

  @override
  String vCardExportError(String error) {
    return 'Gagal mengekspor vCard: $error';
  }

  @override
  String get locationFound => 'Lokasi Ditemukan!';

  @override
  String get openInMaps => 'Buka di Peta';

  @override
  String get calendarEventFound => 'Acara Kalender Ditemukan!';

  @override
  String get textFound => 'Teks Ditemukan';

  @override
  String get isbnFound => 'ISBN Ditemukan';

  @override
  String get productCodeFound => 'Kode Produk Ditemukan';

  @override
  String get driverLicenseFound => 'SIM Ditemukan';

  @override
  String get contactInfoLabel => 'Info Kontak (vCard):';

  @override
  String get saveContactDialogTitle => 'Simpan Kontak';

  @override
  String get noneLabel => '(tidak ada)';

  @override
  String get calendarEventLabel => 'Acara Kalender (iCal):';

  @override
  String get driverLicenseLabel => 'Data SIM:';

  @override
  String get rawDataLabel => 'Data Mentah:';

  @override
  String get nameLabel => 'Nama:';

  @override
  String get organizationLabel => 'Organisasi:';

  @override
  String get titleLabel => 'Judul:';

  @override
  String get phoneLabel => 'Telepon:';

  @override
  String get emailLabel => 'Email:';

  @override
  String get addressLabel => 'Alamat:';

  @override
  String get websiteLabel => 'Situs Web:';

  @override
  String get noteLabel => 'Catatan:';

  @override
  String get wifiNetworkLabel => 'Jaringan Wi-Fi:';

  @override
  String get ssidLabel => 'SSID:';

  @override
  String get typeLabel => 'Tipe:';

  @override
  String get passwordLabel => 'Kata Sandi:';

  @override
  String get noPasswordLabel => 'N/A (mungkin tidak ada kata sandi)';

  @override
  String get hiddenLabel => 'Tersembunyi:';

  @override
  String get toLabel => 'Kepada:';

  @override
  String get subjectLabel => 'Subjek:';

  @override
  String get bodyLabel => 'Isi:';

  @override
  String get latitudeLabel => 'Lintang:';

  @override
  String get longitudeLabel => 'Bujur:';

  @override
  String get altitudeLabel => 'Ketinggian:';

  @override
  String get labelLabel => 'Label:';

  @override
  String get noVCardData => 'Tidak ada data vCard untuk diekspor.';

  @override
  String get hidePasswordTooltip => 'Sembunyikan kata sandi';

  @override
  String get showPasswordTooltip => 'Tampilkan kata sandi';

  @override
  String get yesLabel => 'Ya';

  @override
  String get noLabel => 'Tidak';

  @override
  String get errorRequestingPermission => 'Gagal meminta izin.';

  @override
  String get errorReceivingBarcodeData => 'Gagal menerima data barcode.';

  @override
  String get failedToSetUpBarcodeListener => 'Gagal menyiapkan pendengar barcode.';

  @override
  String get couldNotToggleFlash => 'Gagal mengaktifkan/menonaktifkan flash.';

  @override
  String get couldNotSwitchCamera => 'Gagal mengganti kamera.';

  @override
  String cameraStartError(String error) {
    return 'Gagal memulai kamera. Error: $error';
  }

  @override
  String get cameraGenericError => 'Terjadi kesalahan tak terduga saat memulai kamera.';

  @override
  String get cameraPermissionDeniedInSettings => 'Izin kamera ditolak. Harap berikan izin di pengaturan.';

  @override
  String get cameraPermissionDeniedOrRevoked => 'Izin kamera ditolak atau dicabut.\nHarap berikan izin di pengaturan aplikasi.';

  @override
  String get cameraNotSupported => 'Kamera tidak tersedia atau tidak didukung di perangkat ini.';

  @override
  String get fileScreenTitle => 'Pindai dari Berkas';

  @override
  String get pickImageButtonText => 'Pilih Gambar & Pindai';

  @override
  String get fileScreenInstruction => 'Pilih gambar yang berisi QR code dari galeri Anda.';

  @override
  String get chooseImageMessage => 'Memilih gambar...';

  @override
  String get processingMessage => 'Memproses...';

  @override
  String get scanningImageMessage => 'Memindai gambar...';

  @override
  String get noCodeFoundMessage => 'Tidak ada kode yang dapat dibaca ditemukan dalam QR code.';

  @override
  String get noQrCodeFoundMessage => 'Tidak ada QR code ditemukan dalam gambar yang dipilih.';

  @override
  String imageScanError(String error) {
    return 'Gagal memindai gambar: $error';
  }

  @override
  String get settingsScreenTitle => 'Pengaturan';

  @override
  String get appearanceSectionTitle => 'Tampilan';

  @override
  String get applicationSectionTitle => 'Aplikasi';

  @override
  String get lightThemeLabel => 'Terang';

  @override
  String get darkThemeLabel => 'Gelap';

  @override
  String get systemThemeLabel => 'Sistem';

  @override
  String get checkForUpdatesLabel => 'Periksa Pembaruan';

  @override
  String get versionLoadingText => 'Memuat...';

  @override
  String get versionErrorText => 'Gagal memuat versi';

  @override
  String versionFormat(String version, String buildNumber) {
    return 'Versi $version ($buildNumber)';
  }

  @override
  String get updateScreenTitle => 'Pembaruan Aplikasi';

  @override
  String get checkingForUpdates => 'Memeriksa pembaruan...';

  @override
  String get updateAvailable => 'Pembaruan Tersedia!';

  @override
  String currentVersionLabel(String version) {
    return 'Versi saat ini: $version';
  }

  @override
  String newVersionLabel(String version) {
    return 'Versi baru: $version';
  }

  @override
  String latestVersionLabel(String version) {
    return '(Versi terbaru yang tersedia: $version)';
  }

  @override
  String get downloadAndInstallButton => 'Unduh & Pasang';

  @override
  String downloadingUpdate(String version) {
    return 'Mengunduh pembaruan ($version)...';
  }

  @override
  String downloadProgress(String progress) {
    return '$progress%';
  }

  @override
  String get startingInstall => 'Memulai pemasangan...';

  @override
  String get updateFailed => 'Pembaruan Gagal';

  @override
  String get retryCheckButton => 'Coba Lagi';

  @override
  String get upToDate => 'Anda sudah menggunakan versi terbaru!';

  @override
  String get checkAgainButton => 'Periksa Lagi';

  @override
  String get installDialogShown => 'Dialog pemasangan ditampilkan';

  @override
  String get noUpdateAvailable => 'Tidak ada pembaruan baru yang tersedia.';

  @override
  String get unexpectedErrorDuringCheck => 'Terjadi kesalahan tak terduga saat memeriksa.';

  @override
  String get updateInfoIncomplete => 'Informasi pembaruan tidak lengkap.';

  @override
  String get downloadFailed => 'Pengunduhan gagal. Periksa koneksi dan izin.';

  @override
  String get installationFailed => 'Tidak dapat memulai pemasangan. Periksa izin.';
}
