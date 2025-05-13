import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/l10n/app_localizations.dart';

import '../providers/providers.dart';
import 'update_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _log = Logger('SettingsScreen');
  String _appVersion = '';
  final String _updateHeroTag = 'update-hero-tag';
  bool _isVersionLoaded = false;

  @override
  void initState() {
    super.initState();
    _log.fine("initState called");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isVersionLoaded) {
      _getAppVersion();
      _isVersionLoaded = true;
    }
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

  String _getLanguageName(Locale locale, AppLocalizations l10n) {
    switch (locale.languageCode) {
      case 'ar':
        return 'العربية';
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'fi':
        return 'Suomi';
      case 'fr':
        return 'Français';
      case 'hi':
        return 'हिन्दी';
      case 'id':
        return 'Bahasa Indonesia';
      case 'ja':
        return '日本語';
      case 'pt':
        return 'Português';
      case 'ru':
        return 'Русский';
      case 'zh':
        return '简体中文';
      default:
        return locale.languageCode.toUpperCase();
    }
  }

  void _showLanguageSelectionSheet(BuildContext context, Locale currentLocale, AppLocalizations l10n, WidgetRef ref) {
    final supportedLocales = AppLocalizations.supportedLocales;
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return Consumer(
          builder: (context, sheetRef, child) {
            final currentLocaleInSheet = sheetRef.watch(localeProvider);

            void handleLocaleSelection(Locale? newLocale) {
              if (newLocale != null && newLocale != currentLocaleInSheet) {
                _log.info("Language selected in sheet: ${newLocale.languageCode}");
                ref.read(localeProvider.notifier).setLocale(newLocale);
                Navigator.pop(bottomSheetContext);
              }
            }

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        l10n.languageSectionTitle,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Divider(height: 1),
                    const SizedBox(height: 12),

                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Material(
                          color: Colors.transparent,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: supportedLocales.map((locale) {
                              final languageName = _getLanguageName(locale, l10n);
                              final bool isSelected = locale == currentLocaleInSheet;

                              return ListTile(
                                title: Text(languageName),
                                leading: Radio<Locale>(
                                  value: locale,
                                  groupValue: currentLocaleInSheet,
                                  onChanged: handleLocaleSelection,
                                  activeColor: theme.colorScheme.primary,
                                  visualDensity: VisualDensity.compact,
                                ),
                                selected: isSelected,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                                visualDensity: VisualDensity.compact,
                                onTap: () => handleLocaleSelection(locale),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _log.finer("Building SettingsScreen widget");
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final currentMode = ref.watch(themeProvider);
    final currentLocale = ref.watch(localeProvider);

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
                    child: Text(l10n.languageSectionTitle, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    child: ListTile(
                      leading: Icon(Icons.language_outlined, color: theme.colorScheme.secondary),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(l10n.languageSectionTitle)
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          _getLanguageName(currentLocale, l10n),
                          style: TextStyle(color: theme.textTheme.bodySmall?.color?.withAlpha(200)),
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_drop_down),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                      onTap: () {
                        _log.info("Language setting tapped - showing selection sheet");
                        _showLanguageSelectionSheet(context, currentLocale, l10n, ref);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: theme.dividerColor, width: 0.5)
                      ),
                      horizontalTitleGap: 8.0,
                      tileColor: theme.colorScheme.surfaceContainerHighest.withAlpha(64),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(indent: 16, endIndent: 16, height: 24),

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
                _appVersion.isEmpty ? l10n.versionLoadingText : _appVersion,
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