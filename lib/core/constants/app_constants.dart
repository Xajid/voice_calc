import 'dart:math' as math;

class AppConstants {
  // Private constructor
  AppConstants._();

  // App Info
  static const String appName = 'Voice Calculator';
  static const String appVersion = '1.0.0';

  // Mathematical Constants
  static const double pi = math.pi;
  static const double e = math.e;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Voice Command Mappings (Speech to Math)
  static const Map<String, String> voiceToOperator = {
    'plus': '+',
    'add': '+',
    'minus': '-',
    'subtract': '-',
    'times': '×',
    'multiply': '×',
    'into': '×',
    'multiplied by': '×',
    'divided by': '÷',
    'divide': '÷',
    'by': '÷',
    'equals': '=',
    'equal': '=',
    'percent': '%',
    'percentage': '%',
    'squared': '²',
    'square': '²',
    'square root': '√',
    'root': '√',
    'square root of': '√',
    'root of': '√',
    'sine': 'sin',
    'cosine': 'cos',
    'tangent': 'tan',
    'log': 'log',
    'logarithm': 'log',
    'natural log': 'ln',
    'natural logarithm': 'ln',
    'pi': 'π',
    'euler': 'e',
  };

  // Number word to digit mapping
  static const Map<String, String> voiceToNumber = {
    'zero': '0',
    'one': '1',
    'two': '2',
    'three': '3',
    'four': '4',
    'five': '5',
    'six': '6',
    'seven': '7',
    'eight': '8',
    'nine': '9',
    'ten': '10',
    'point': '.',
    'decimal': '.',
  };

  // Error Messages
  static const String errorDivisionByZero = 'Cannot divide by zero';
  static const String errorInvalidExpression = 'Invalid expression';
  static const String errorMicrophonePermission =
      'Microphone permission denied';
  static const String errorSpeechNotAvailable =
      'Speech recognition not available';
  static const String errorVoiceNotUnderstood =
      'Could not understand voice input';
  static const String errorCalculation = 'Error in calculation';

  // Calculator Settings
  static const int maxHistoryItems = 100;
  static const int maxExpressionLength = 50;

  // Voice Settings Defaults
  static const double defaultTtsRate = 0.5;
  static const double defaultTtsPitch = 1.0;
  static const String defaultTtsLanguage = 'en-US';

  // Storage Keys
  static const String keyThemeMode = 'theme_mode';
  static const String keyCalculatorMode = 'calculator_mode';
  static const String keyHapticFeedback = 'haptic_feedback';
  static const String keyTtsEnabled = 'tts_enabled';
  static const String keyTtsRate = 'tts_rate';
  static const String keyTtsPitch = 'tts_pitch';
  static const String keyTtsLanguage = 'tts_language';
}
