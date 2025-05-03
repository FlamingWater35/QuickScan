import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

const String _themePrefsKey = 'app_theme_mode';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier(SharedPreferences.getInstance());
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final _log = Logger('ThemeNotifier');

  final Future<SharedPreferences> _prefsFuture;
  SharedPreferences? _prefs;

  ThemeNotifier(this._prefsFuture) : super(ThemeMode.system) {
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    _prefs = await _prefsFuture;
    try {
      final String? savedThemeName = _prefs?.getString(_themePrefsKey);
      ThemeMode loadedMode = ThemeMode.system;

      if (savedThemeName != null) {
        loadedMode = ThemeMode.values.firstWhere(
          (e) => e.name == savedThemeName,
          orElse: () => ThemeMode.system,
        );
        _log.info("Loaded theme preference: $loadedMode");
      } else {
        _log.info("No saved theme preference found, using system default.");
      }

      if (state != loadedMode) {
        state = loadedMode;
      }
    } catch (e, stackTrace) {
      _log.severe("Error loading theme preference", e, stackTrace);
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (state != mode) {
      state = mode;
      _log.info("Setting theme mode to: $mode");
      try {
        _prefs ??= await _prefsFuture;
        await _prefs?.setString(_themePrefsKey, mode.name);
        _log.info("Saved theme preference: $mode");
      } catch (e, stackTrace) {
        _log.severe("Error saving theme preference", e, stackTrace);
      }
    }
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  final _log = Logger('LocaleNotifier');
  static const String _localeKey = 'selected_locale';
  
  LocaleNotifier() : super(const Locale('en')) {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_localeKey);
      
      if (languageCode != null && languageCode.isNotEmpty) {
        state = Locale(languageCode);
      }
    } catch (e) {
      state = const Locale('en');
      _log.severe("Fallback to default locale");
    }
  }

  Future<void> setLocale(Locale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode);
      state = locale;
    } catch (e) {
      _log.severe('Error saving locale: $e');
    }
  }
}