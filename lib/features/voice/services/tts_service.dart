import 'package:flutter_tts/flutter_tts.dart';
import '../../../core/constants/app_constants.dart';

class TtsService {
  final FlutterTts _tts = FlutterTts();
  bool _isInitialized = false;

  // Initialize TTS
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await _tts.setLanguage(AppConstants.defaultTtsLanguage);
      await _tts.setSpeechRate(AppConstants.defaultTtsRate);
      await _tts.setPitch(AppConstants.defaultTtsPitch);
      await _tts.setVolume(1.0);
      _isInitialized = true;
    } catch (e) {
      print('Failed to initialize TTS: $e');
    }
  }

  // Speak text
  Future<void> speak(String text) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      await _tts.speak(text);
    } catch (e) {
      print('TTS speak error: $e');
    }
  }

  // Stop speaking
  Future<void> stop() async {
    await _tts.stop();
  }

  // Pause speaking
  Future<void> pause() async {
    await _tts.pause();
  }

  // Set speech rate (0.0 to 1.0)
  Future<void> setSpeechRate(double rate) async {
    await _tts.setSpeechRate(rate);
  }

  // Set pitch (0.5 to 2.0)
  Future<void> setPitch(double pitch) async {
    await _tts.setPitch(pitch);
  }

  // Set language
  Future<void> setLanguage(String language) async {
    await _tts.setLanguage(language);
  }

  // Get available languages
  Future<List<dynamic>> getLanguages() async {
    try {
      return await _tts.getLanguages;
    } catch (e) {
      print('Error getting languages: $e');
      return [];
    }
  }

  // Speak calculation result
  Future<void> speakResult(String expression, String result) async {
    final text = '$expression equals $result';
    await speak(text);
  }

  // Speak error
  Future<void> speakError(String error) async {
    await speak(error);
  }

  // Check if TTS is speaking
  Future<bool> isSpeaking() async {
    // Note: flutter_tts doesn't have a direct isSpeaking method
    // We can implement this with completion handlers if needed
    return false;
  }

  // Dispose
  void dispose() {
    _tts.stop();
  }
}
