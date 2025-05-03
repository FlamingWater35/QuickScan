import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_scanner/l10n/app_localizations.dart';

import '../providers/providers.dart';
import 'update_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _log = Logger('SettingsScreen');
  String _appVersion = 'version_placeholder';
  static const _versionPlaceholder = 'version_placeholder';
  final String _updateHeroTag = 'update-hero-tag';

  @override
  void initState() {
    super.initState();
    _log.fine("initState called");
    _getAppVersion();
  }

  Future<void> _getAppVersion() async {
    final l10n = AppLocalizations.of(context);
    
    try {
      final PackageInfo info = await PackageInfo.fromPlatform();
      if (mounted) {
        setState(() {
          _appVersion = l10n.versionFormat(
            info.version,
            info.buildNumber,
          );
        });
        _log.info("App version loaded: $_appVersion");
      }
    } catch (e, stackTrace) {
      _log.severe("Error getting package info", e, stackTrace);
      if (mounted) {
        setState(() {
          _appVersion = l10n.versionErrorText;
        });
      }
    }
  }

  void _handleCheckForUpdates() {
    _log.info("Check for Updates button tapped - Navigating");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateScreen(heroTag: _updateHeroTag),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _log.finer("Building SettingsScreen widget");
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final currentMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
          child: Text(
            l10n.settingsScreenTitle,
            style: theme.textTheme.headlineMedium,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(l10n.appearanceSectionTitle, style: theme.textTheme.titleSmall),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: SegmentedButton<ThemeMode>(
                      selected: {currentMode},
                      segments: <ButtonSegment<ThemeMode>>[
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.light,
                          label: Text(l10n.lightThemeLabel),
                          icon: Icon(Icons.light_mode_outlined),
                        ),
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.dark,
                          label: Text(l10n.darkThemeLabel),
                          icon: Icon(Icons.dark_mode_outlined),
                        ),
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.system,
                          label: Text(l10n.systemThemeLabel),
                          icon: Icon(Icons.settings_suggest_outlined),
                        ),
                      ],

                      onSelectionChanged: (Set<ThemeMode> newSelection) {
                        if (newSelection.isNotEmpty) {
                          _log.info("Theme mode changed to: ${newSelection.first}");
                          ref.read(themeProvider.notifier).setThemeMode(newSelection.first);
                        }
                      },
                      showSelectedIcon: false,
                      style: SegmentedButton.styleFrom(),
                    ),
                  ),
                  const Divider(indent: 16, endIndent: 16, height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(l10n.applicationSectionTitle, style: theme.textTheme.titleSmall),
                  ),
                  Hero(
                    tag: _updateHeroTag,
                    child: Material(
                      type: MaterialType.transparency,
                      child: ListTile(
                        leading: const Icon(Icons.system_update_alt_outlined),
                        title: Text(l10n.checkForUpdatesLabel),
                        onTap: _handleCheckForUpdates,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _appVersion == _versionPlaceholder ? l10n.versionLoadingText : _appVersion,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}