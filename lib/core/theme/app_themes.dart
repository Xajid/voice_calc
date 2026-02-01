import 'package:flutter/material.dart';
import '../../features/theme/models/calculator_theme.dart';

/// Collection of predefined calculator themes
class AppThemes {
  AppThemes._();

  /// Default theme (Purple/Blue gradient)
  static const CalculatorTheme defaultTheme = CalculatorTheme(
    id: 'default',
    name: 'Default',
    displayBackground: Color(0xFFF5F5F5),
    displayTextPrimary: Color(0xFF5E35B1),
    displayTextSecondary: Color(0xFF757575),
    displayErrorColor: Color(0xFFD32F2F),
    numberButtonColor: Color(0xFFEDE7F6),
    numberButtonTextColor: Color(0xFF311B92),
    operatorButtonColor: Color(0xFF5E35B1),
    operatorButtonTextColor: Color(0xFFFFFFFF),
    functionButtonColor: Color(0xFF7E57C2),
    functionButtonTextColor: Color(0xFFFFFFFF),
    clearButtonColor: Color(0xFFFF7043),
    clearButtonTextColor: Color(0xFFFFFFFF),
    equalsButtonColor: Color(0xFF66BB6A),
    equalsButtonTextColor: Color(0xFFFFFFFF),
    voiceButtonColor: Color(0xFF5E35B1),
    voiceButtonActiveColor: Color(0xFFFF6F00),
    voiceButtonIconColor: Color(0xFFFFFFFF),
    scaffoldBackground: Color(0xFFFAFAFA),
    appBarBackground: Color(0xFF5E35B1),
    appBarTextColor: Color(0xFFFFFFFF),
  );

  /// Light theme (Original light design with indigo and amber)
  static const CalculatorTheme lightTheme = CalculatorTheme(
    id: 'light',
    name: 'Light',
    displayBackground: Color(0xFFFFFFFF),
    displayTextPrimary: Color(0xFF6366F1),
    displayTextSecondary: Color(0xFF64748B),
    displayErrorColor: Color(0xFFEF4444),
    numberButtonColor: Color(0xFFF8FAFC),
    numberButtonTextColor: Color(0xFF1E293B),
    operatorButtonColor: Color(0xFF6366F1),
    operatorButtonTextColor: Color(0xFFFFFFFF),
    functionButtonColor: Color(0xFF818CF8),
    functionButtonTextColor: Color(0xFFFFFFFF),
    clearButtonColor: Color(0xFFF59E0B),
    clearButtonTextColor: Color(0xFFFFFFFF),
    equalsButtonColor: Color(0xFF6366F1),
    equalsButtonTextColor: Color(0xFFFFFFFF),
    voiceButtonColor: Color(0xFF6366F1),
    voiceButtonActiveColor: Color(0xFFF59E0B),
    voiceButtonIconColor: Color(0xFFFFFFFF),
    scaffoldBackground: Color(0xFFF8FAFC),
    appBarBackground: Color(0xFFFFFFFF),
    appBarTextColor: Color(0xFF1E293B),
  );

  /// Dark theme (Original dark design with lighter indigo and amber)
  static const CalculatorTheme darkTheme = CalculatorTheme(
    id: 'dark',
    name: 'Dark',
    displayBackground: Color(0xFF1E293B),
    displayTextPrimary: Color(0xFF818CF8),
    displayTextSecondary: Color(0xFF94A3B8),
    displayErrorColor: Color(0xFFEF4444),
    numberButtonColor: Color(0xFF334155),
    numberButtonTextColor: Color(0xFFF1F5F9),
    operatorButtonColor: Color(0xFF818CF8),
    operatorButtonTextColor: Color(0xFF0F172A),
    functionButtonColor: Color(0xFF6366F1),
    functionButtonTextColor: Color(0xFFF1F5F9),
    clearButtonColor: Color(0xFFFBBF24),
    clearButtonTextColor: Color(0xFF0F172A),
    equalsButtonColor: Color(0xFF818CF8),
    equalsButtonTextColor: Color(0xFF0F172A),
    voiceButtonColor: Color(0xFF818CF8),
    voiceButtonActiveColor: Color(0xFFFBBF24),
    voiceButtonIconColor: Color(0xFF0F172A),
    scaffoldBackground: Color(0xFF0F172A),
    appBarBackground: Color(0xFF1E293B),
    appBarTextColor: Color(0xFFF1F5F9),
  );

  /// Dark Ocean theme (Deep blues and teals)
  static const CalculatorTheme darkOcean = CalculatorTheme(
    id: 'dark_ocean',
    name: 'Dark Ocean',
    displayBackground: Color(0xFF1A2332),
    displayTextPrimary: Color(0xFF4DD0E1),
    displayTextSecondary: Color(0xFF78909C),
    displayErrorColor: Color(0xFFEF5350),
    numberButtonColor: Color(0xFF263238),
    numberButtonTextColor: Color(0xFF80CBC4),
    operatorButtonColor: Color(0xFF00695C),
    operatorButtonTextColor: Color(0xFFE0F2F1),
    functionButtonColor: Color(0xFF00796B),
    functionButtonTextColor: Color(0xFFE0F2F1),
    clearButtonColor: Color(0xFFD84315),
    clearButtonTextColor: Color(0xFFFFFFFF),
    equalsButtonColor: Color(0xFF0097A7),
    equalsButtonTextColor: Color(0xFFFFFFFF),
    voiceButtonColor: Color(0xFF00ACC1),
    voiceButtonActiveColor: Color(0xFFFF6F00),
    voiceButtonIconColor: Color(0xFFFFFFFF),
    scaffoldBackground: Color(0xFF0F1419),
    appBarBackground: Color(0xFF00695C),
    appBarTextColor: Color(0xFFE0F2F1),
  );

  /// Sunset theme (Warm oranges and pinks)
  static const CalculatorTheme sunset = CalculatorTheme(
    id: 'sunset',
    name: 'Sunset',
    displayBackground: Color(0xFFFFF3E0),
    displayTextPrimary: Color(0xFFE65100),
    displayTextSecondary: Color(0xFF8D6E63),
    displayErrorColor: Color(0xFFC62828),
    numberButtonColor: Color(0xFFFFE0B2),
    numberButtonTextColor: Color(0xFFBF360C),
    operatorButtonColor: Color(0xFFFF6F00),
    operatorButtonTextColor: Color(0xFFFFFFFF),
    functionButtonColor: Color(0xFFFF8A65),
    functionButtonTextColor: Color(0xFFFFFFFF),
    clearButtonColor: Color(0xFFE64A19),
    clearButtonTextColor: Color(0xFFFFFFFF),
    equalsButtonColor: Color(0xFFD84315),
    equalsButtonTextColor: Color(0xFFFFFFFF),
    voiceButtonColor: Color(0xFFFF6F00),
    voiceButtonActiveColor: Color(0xFFFF3D00),
    voiceButtonIconColor: Color(0xFFFFFFFF),
    scaffoldBackground: Color(0xFFFFF8E1),
    appBarBackground: Color(0xFFE65100),
    appBarTextColor: Color(0xFFFFFFFF),
  );

  /// Forest theme (Greens and earth tones)
  static const CalculatorTheme forest = CalculatorTheme(
    id: 'forest',
    name: 'Forest',
    displayBackground: Color(0xFFE8F5E9),
    displayTextPrimary: Color(0xFF2E7D32),
    displayTextSecondary: Color(0xFF616161),
    displayErrorColor: Color(0xFFC62828),
    numberButtonColor: Color(0xFFC8E6C9),
    numberButtonTextColor: Color(0xFF1B5E20),
    operatorButtonColor: Color(0xFF43A047),
    operatorButtonTextColor: Color(0xFFFFFFFF),
    functionButtonColor: Color(0xFF66BB6A),
    functionButtonTextColor: Color(0xFFFFFFFF),
    clearButtonColor: Color(0xFFEF6C00),
    clearButtonTextColor: Color(0xFFFFFFFF),
    equalsButtonColor: Color(0xFF388E3C),
    equalsButtonTextColor: Color(0xFFFFFFFF),
    voiceButtonColor: Color(0xFF43A047),
    voiceButtonActiveColor: Color(0xFFFF6F00),
    voiceButtonIconColor: Color(0xFFFFFFFF),
    scaffoldBackground: Color(0xFFF1F8E9),
    appBarBackground: Color(0xFF2E7D32),
    appBarTextColor: Color(0xFFFFFFFF),
  );

  /// Monochrome theme (Elegant blacks, whites, and grays)
  static const CalculatorTheme monochrome = CalculatorTheme(
    id: 'monochrome',
    name: 'Monochrome',
    displayBackground: Color(0xFFFFFFFF),
    displayTextPrimary: Color(0xFF212121),
    displayTextSecondary: Color(0xFF757575),
    displayErrorColor: Color(0xFF424242),
    numberButtonColor: Color(0xFFEEEEEE),
    numberButtonTextColor: Color(0xFF212121),
    operatorButtonColor: Color(0xFF616161),
    operatorButtonTextColor: Color(0xFFFFFFFF),
    functionButtonColor: Color(0xFF757575),
    functionButtonTextColor: Color(0xFFFFFFFF),
    clearButtonColor: Color(0xFF424242),
    clearButtonTextColor: Color(0xFFFFFFFF),
    equalsButtonColor: Color(0xFF212121),
    equalsButtonTextColor: Color(0xFFFFFFFF),
    voiceButtonColor: Color(0xFF424242),
    voiceButtonActiveColor: Color(0xFF212121),
    voiceButtonIconColor: Color(0xFFFFFFFF),
    scaffoldBackground: Color(0xFFFAFAFA),
    appBarBackground: Color(0xFF212121),
    appBarTextColor: Color(0xFFFFFFFF),
  );

  /// Cyberpunk theme (Neon colors on dark)
  static const CalculatorTheme cyberpunk = CalculatorTheme(
    id: 'cyberpunk',
    name: 'Cyberpunk',
    displayBackground: Color(0xFF0D1117),
    displayTextPrimary: Color(0xFF00FF9F),
    displayTextSecondary: Color(0xFF8B949E),
    displayErrorColor: Color(0xFFFF1744),
    numberButtonColor: Color(0xFF161B22),
    numberButtonTextColor: Color(0xFF00F5FF),
    operatorButtonColor: Color(0xFF7C3AED),
    operatorButtonTextColor: Color(0xFFFFFFFF),
    functionButtonColor: Color(0xFF9333EA),
    functionButtonTextColor: Color(0xFFE0E7FF),
    clearButtonColor: Color(0xFFD946EF),
    clearButtonTextColor: Color(0xFFFFFFFF),
    equalsButtonColor: Color(0xFF00FF9F),
    equalsButtonTextColor: Color(0xFF000000),
    voiceButtonColor: Color(0xFF00FF9F),
    voiceButtonActiveColor: Color(0xFFFF1744),
    voiceButtonIconColor: Color(0xFF000000),
    scaffoldBackground: Color(0xFF010409),
    appBarBackground: Color(0xFF161B22),
    appBarTextColor: Color(0xFF00FF9F),
  );

  /// List of all available themes
  static const List<CalculatorTheme> allThemes = [
    defaultTheme,
    lightTheme,
    darkTheme,
    darkOcean,
    sunset,
    forest,
    monochrome,
    cyberpunk,
  ];

  /// Get theme by ID
  static CalculatorTheme? getThemeById(String id) {
    try {
      return allThemes.firstWhere((theme) => theme.id == id);
    } catch (e) {
      return null;
    }
  }
}
