import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:simple_scanner/l10n/app_localizations.dart';

import '../components/update_service.dart';

enum UpdateStatus { idle, checking, available, downloading, preparingInstall, error, installed }

class UpdateScreen extends StatefulWidget {
  final String heroTag;

  const UpdateScreen({super.key, required this.heroTag});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _log = Logger('UpdateScreen');
  UpdateStatus _status = UpdateStatus.idle;
  String _currentVersion = '';
  String _latestVersion = '';
  String? _updateUrl;
  String? _assetName;
  String _errorMessage = '';
  double _downloadProgress = 0.0;
  bool _isInitialUpdateChecked = false;

  @override
  void initState() {
    super.initState();
    _log.fine("initState called");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialUpdateChecked) {
      _performUpdateCheck();
      _isInitialUpdateChecked = true;
    }
  }

  Future<void> _performUpdateCheck() async {
    _log.info("Performing update check...");
    final l10n = AppLocalizations.of(context);

    setState(() {
      _status = UpdateStatus.checking;
      _errorMessage = '';
    });

    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if (!mounted) return;
      setState(() => _currentVersion = packageInfo.version);

      final UpdateInfo updateInfo = await UpdateService.checkForUpdate();
      if (!mounted) return;

      if (updateInfo.isUpdateAvailable) {
        setState(() {
          _status = UpdateStatus.available;
          _latestVersion = updateInfo.latestVersion ?? 'N/A';
          _updateUrl = updateInfo.updateUrl;
          _assetName = updateInfo.assetName;
        });
      } else {
        setState(() {
          _status = UpdateStatus.idle;
          _errorMessage = updateInfo.errorMessage ?? l10n.noUpdateAvailable;
          _latestVersion = updateInfo.latestVersion ?? _currentVersion;
        });
      }
    } catch (e, stackTrace) {
      _log.severe("Unhandled error during update check", e, stackTrace);
      if (mounted) {
        setState(() {
          _status = UpdateStatus.error;
          _errorMessage = l10n.unexpectedErrorDuringCheck;
        });
      }
    }
  }

  Future<void> _startDownloadAndInstall() async {
    final l10n = AppLocalizations.of(context);

    if (_updateUrl == null || _assetName == null) {
      _log.severe("Download requested but URL or filename is missing.");
      setState(() {
        _status = UpdateStatus.error;
        _errorMessage = l10n.updateInfoIncomplete;
      });
      return;
    }

    _log.info("Starting download & install process...");
    setState(() {
      _status = UpdateStatus.downloading;
      _downloadProgress = -1.0;
      _errorMessage = '';
    });

    final String? downloadedPath = await UpdateService.downloadUpdate(
      _updateUrl!,
      _assetName!,
      _updateDownloadProgress,
    );

    if (!mounted) return;

    if (downloadedPath != null) {
      _log.info("Download complete. Preparing for installation...");
      setState(() {
        _status = UpdateStatus.preparingInstall;
      });
      await Future.delayed(const Duration(milliseconds: 200));

      if (!mounted) return;

      _log.info("Initiating installation...");
      final bool installInitiated = await UpdateService.installUpdate(downloadedPath);
      if (!mounted) return;

      if (installInitiated) {
        _log.info("Install prompt likely shown. Waiting for user/OS action.");
        setState(() {
          _status = UpdateStatus.installed;
        });
      } else {
        _log.warning("Failed to initiate installation prompt.");
        setState(() {
          _status = UpdateStatus.error;
          _errorMessage = l10n.installationFailed;
        });
      }
    } else {
      setState(() {
        _status = UpdateStatus.error;
        _errorMessage = l10n.downloadFailed;
      });
    }
  }

  void _updateDownloadProgress(double progress) {
    if (mounted) {
      final clampedProgress = progress.clamp(0.0, 1.0);
      setState(() {
        _downloadProgress = clampedProgress;
      });
    }
  }

  Widget _buildContent() {
    final l10n = AppLocalizations.of(context);
    final statusTextStyle = Theme.of(context).textTheme.titleMedium;

    switch (_status) {
      case UpdateStatus.checking:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(l10n.checkingForUpdates, style: statusTextStyle),
          ],
        );

      case UpdateStatus.available:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.system_update_alt, size: 60, color: Colors.green),
            const SizedBox(height: 16),
            Text(l10n.updateAvailable, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(l10n.currentVersionLabel(_currentVersion)),
            Text(l10n.newVersionLabel(_latestVersion)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.download_for_offline_outlined),
              label: Text(l10n.downloadAndInstallButton),
              onPressed: _startDownloadAndInstall,
            ),
          ],
        );

      case UpdateStatus.downloading:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(l10n.downloadingUpdate(_latestVersion), style: statusTextStyle),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LinearProgressIndicator(
                value: _downloadProgress < 0 ? null : _downloadProgress,
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 8),
            if (_downloadProgress >= 0)
              Text(l10n.downloadProgress((_downloadProgress * 100).toStringAsFixed(0))),
          ],
        );

      case UpdateStatus.preparingInstall:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(l10n.startingInstall, style: statusTextStyle),
            SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LinearProgressIndicator(
                value: null,
                minHeight: 8,
              ),
            ),
          ],
        );

      case UpdateStatus.error:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(l10n.updateFailed, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(_errorMessage, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ),
            const SizedBox(height: 24),
            TextButton.icon(
              icon: const Icon(Icons.refresh),
              label: Text(l10n.retryCheckButton),
              onPressed: _performUpdateCheck,
            ),
          ],
        );

      case UpdateStatus.idle:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, size: 60, color: Colors.blue),
            const SizedBox(height: 16),
            Text(l10n.upToDate, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(l10n.currentVersionLabel(_currentVersion)),
            if (_latestVersion != _currentVersion && _latestVersion.isNotEmpty)
              Text(l10n.latestVersionLabel(_latestVersion)),
            const SizedBox(height: 8),
            if(_errorMessage.isNotEmpty && !_errorMessage.contains(l10n.noUpdateAvailable))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(_errorMessage, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              ),
            const SizedBox(height: 24),
            TextButton.icon(
              icon: const Icon(Icons.refresh),
              label: Text(l10n.checkAgainButton),
              onPressed: _performUpdateCheck,
            ),
          ],
        );

      case UpdateStatus.installed:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 60, color: Colors.green),
            SizedBox(height: 16),
            Text(l10n.installDialogShown, style: statusTextStyle),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    _log.finer("Building UpdateScreen widget with status: $_status");
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.updateScreenTitle),
      ),
      body: Hero(
        tag: widget.heroTag,
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildContent(),
              ),
             ),
          ),
        ),
      ),
    );
  }
}