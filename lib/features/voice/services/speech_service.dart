import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../core/constants/app_constants.dart';

class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isInitialized = false;

  // Check if speech recognition is available
  Future<bool> initialize() async {
    if (_isInitialized) return true;

    try {
      _isInitialized = await _speech.initialize(
        onStatus: (status) => print('Speech status: $status'),
        onError: (error) => print('Speech error: $error'),
      );
      print('Speech initialized: $_isInitialized');
      return _isInitialized;
    } catch (e) {
      print('Failed to initialize speech: $e');
      return false;
    }
  }

  // Request microphone permission (uses speech_to_text's built-in permission)
  Future<bool> requestPermission() async {
    print('[SpeechService] Requesting permission via speech_to_text...');
    // Initialize will automatically request permissions
    final hasPermission = await initialize();
    print('[SpeechService] Initialize result (has permission): $hasPermission');
    return hasPermission;
  }

  // Check permission status
  Future<bool> checkPermission() async {
    print('[SpeechService] Checking permission...');
    // On iOS/Android, hasPermission checks if we have microphone access
    final hasPermission = await _speech.hasPermission;
    print('[SpeechService] Has permission: $hasPermission');
    return hasPermission;
  }

  // Start listening
  Future<void> startListening({
    required Function(String) onResult,
    required Function() onComplete,
    String locale = 'en_US',
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (!_isInitialized) {
      throw Exception(AppConstants.errorSpeechNotAvailable);
    }

    await _speech.listen(
      onResult: (result) {
        if (result.finalResult) {
          final recognizedWords = result.recognizedWords.toLowerCase();
          final parsedExpression = parseVoiceToMath(recognizedWords);
          onResult(parsedExpression);
        }
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
      partialResults: false,
      localeId: locale,
      cancelOnError: true,
      listenMode: stt.ListenMode.confirmation,
    );
  }

  // Stop listening
  Future<void> stopListening() async {
    if (_speech.isListening) {
      await _speech.stop();
    }
  }

  // Cancel listening
  Future<void> cancelListening() async {
    if (_speech.isListening) {
      await _speech.cancel();
    }
  }

  // Check if currently listening
  bool get isListening => _speech.isListening;

  // Check if available
  bool get isAvailable => _isInitialized;

  // Parse voice input to mathematical expression
  String parseVoiceToMath(String voiceInput) {
    String result = voiceInput.toLowerCase().trim();

    // Remove common filler words before processing
    final fillerWords = [
      'and',
      'the',
      'a',
      'an',
      'is',
      'are',
      'was',
      'were',
      'be',
      'been',
      'being',
      'have',
      'has',
      'had',
      'do',
      'does',
      'did',
      'will',
      'would',
      'should',
      'could',
      'may',
      'might',
      'must',
      'can',
      'of',
      'to',
      'from',
      'at',
      'in',
      'on',
      'for',
      'with',
      'as',
      'by',
      'it',
      'that',
      'this',
      'these',
      'those',
      'what',
      'which',
      'who',
      'when',
      'where',
      'why',
      'how',
    ];

    for (var word in fillerWords) {
      result = result.replaceAll(RegExp('\\b$word\\b'), ' ');
    }

    // Replace operators with their symbols
    AppConstants.voiceToOperator.forEach((word, symbol) {
      result = result.replaceAll(word, ' $symbol ');
    });

    // Replace number words with digits
    AppConstants.voiceToNumber.forEach((word, digit) {
      result = result.replaceAll(word, digit);
    });

    // Clean up extra spaces
    result = result.replaceAll(RegExp(r'\s+'), '');

    // Remove "=" at the end if present
    if (result.endsWith('=')) {
      result = result.substring(0, result.length - 1);
    }

    return result;
  }

  // Get available locales
  Future<List<stt.LocaleName>> getLocales() async {
    if (!_isInitialized) {
      await initialize();
    }
    return _speech.locales();
  }

  // Dispose
  void dispose() {
    _speech.stop();
  }
}
