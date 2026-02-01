import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_themes.dart';
import '../models/calculator_theme.dart';

/// Key for storing theme preference
const String _themeKey = 'selected_theme_id';

/// Provider for theme notifier
final themeProvider = StateNotifierProvider<ThemeNotifier, CalculatorTheme>((
  ref,
) {
  return ThemeNotifier();
});

/// Theme state notifier with persistence
class ThemeNotifier extends StateNotifier<CalculatorTheme> {
  ThemeNotifier() : super(AppThemes.defaultTheme) {
    _loadTheme();
  }

  /// Load saved theme from SharedPreferences
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeId = prefs.getString(_themeKey);

      if (themeId != null) {
        final theme = AppThemes.getThemeById(themeId);
        if (theme != null) {
          state = theme;
        }
      }
    } catch (e) {
      // If loading fails, keep default theme
      print('Error loading theme: $e');
    }
  }

  /// Set a new theme and persist it
  Future<void> setTheme(CalculatorTheme theme) async {
    state = theme;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, theme.id);
    } catch (e) {
      print('Error saving theme: $e');
    }
  }

  /// Reset to default theme
  Future<void> resetTheme() async {
    await setTheme(AppThemes.defaultTheme);
  }
}
