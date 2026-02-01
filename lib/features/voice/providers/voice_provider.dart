import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/speech_service.dart';
import '../services/tts_service.dart';

// Voice State
class VoiceState {
  final bool isListening;
  final bool hasPermission;
  final bool isAvailable;
  final String currentTranscript;
  final bool ttsEnabled;
  final double ttsRate;
  final double ttsPitch;
  final String ttsLanguage;

  VoiceState({
    this.isListening = false,
    this.hasPermission = false,
    this.isAvailable = false,
    this.currentTranscript = '',
    this.ttsEnabled = true,
    this.ttsRate = 0.5,
    this.ttsPitch = 1.0,
    this.ttsLanguage = 'en-US',
  });

  VoiceState copyWith({
    bool? isListening,
    bool? hasPermission,
    bool? isAvailable,
    String? currentTranscript,
    bool? ttsEnabled,
    double? ttsRate,
    double? ttsPitch,
    String? ttsLanguage,
  }) {
    return VoiceState(
      isListening: isListening ?? this.isListening,
      hasPermission: hasPermission ?? this.hasPermission,
      isAvailable: isAvailable ?? this.isAvailable,
      currentTranscript: currentTranscript ?? this.currentTranscript,
      ttsEnabled: ttsEnabled ?? this.ttsEnabled,
      ttsRate: ttsRate ?? this.ttsRate,
      ttsPitch: ttsPitch ?? this.ttsPitch,
      ttsLanguage: ttsLanguage ?? this.ttsLanguage,
    );
  }
}

// Voice Notifier
class VoiceNotifier extends StateNotifier<VoiceState> {
  final SpeechService _speechService;
  final TtsService _ttsService;

  VoiceNotifier(this._speechService, this._ttsService) : super(VoiceState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    await _ttsService.initialize();
    final hasPermission = await _speechService.checkPermission();
    final isAvailable = await _speechService.initialize();

    state = state.copyWith(
      hasPermission: hasPermission,
      isAvailable: isAvailable,
    );
  }

  // Request permission
  Future<bool> requestPermission() async {
    print('[VoiceProvider] Requesting permission...');
    final granted = await _speechService.requestPermission();
    print('[VoiceProvider] Permission granted: $granted');
    state = state.copyWith(hasPermission: granted);

    if (granted) {
      print('[VoiceProvider] Initializing speech service...');
      final isAvailable = await _speechService.initialize();
      print('[VoiceProvider] Speech service available: $isAvailable');
      state = state.copyWith(isAvailable: isAvailable);
    }

    print(
      '[VoiceProvider] Final state - hasPermission: ${state.hasPermission}, isAvailable: ${state.isAvailable}',
    );
    return granted;
  }

  // Check current permission status (useful when app resumes)
  Future<void> checkPermissionStatus() async {
    print('[VoiceProvider] Checking permission status...');
    final hasPermission = await _speechService.checkPermission();
    print('[VoiceProvider] Current permission status: $hasPermission');
    state = state.copyWith(hasPermission: hasPermission);

    if (hasPermission && !state.isAvailable) {
      print('[VoiceProvider] Re-initializing speech service...');
      final isAvailable = await _speechService.initialize();
      print('[VoiceProvider] Speech service available: $isAvailable');
      state = state.copyWith(isAvailable: isAvailable);
    }
  }

  // Start listening
  Future<void> startListening(Function(String) onResult) async {
    if (!state.hasPermission) {
      final granted = await requestPermission();
      if (!granted) return;
    }

    if (!state.isAvailable) return;

    state = state.copyWith(isListening: true, currentTranscript: '');

    await _speechService.startListening(
      onResult: (result) {
        state = state.copyWith(currentTranscript: result, isListening: false);
        onResult(result);
      },
      onComplete: () {
        state = state.copyWith(isListening: false);
      },
    );
  }

  // Stop listening
  Future<void> stopListening() async {
    await _speechService.stopListening();
    state = state.copyWith(isListening: false);
  }

  // Cancel listening
  Future<void> cancelListening() async {
    await _speechService.cancelListening();
    state = state.copyWith(isListening: false, currentTranscript: '');
  }

  // Speak result
  Future<void> speakResult(String expression, String result) async {
    if (state.ttsEnabled) {
      await _ttsService.speakResult(expression, result);
    }
  }

  // Speak text
  Future<void> speak(String text) async {
    if (state.ttsEnabled) {
      await _ttsService.speak(text);
    }
  }

  // Toggle TTS
  void toggleTts() {
    state = state.copyWith(ttsEnabled: !state.ttsEnabled);
  }

  // Update TTS settings
  void updateTtsSettings({double? rate, double? pitch, String? language}) {
    if (rate != null) {
      _ttsService.setSpeechRate(rate);
      state = state.copyWith(ttsRate: rate);
    }
    if (pitch != null) {
      _ttsService.setPitch(pitch);
      state = state.copyWith(ttsPitch: pitch);
    }
    if (language != null) {
      _ttsService.setLanguage(language);
      state = state.copyWith(ttsLanguage: language);
    }
  }

  @override
  void dispose() {
    _speechService.dispose();
    _ttsService.dispose();
    super.dispose();
  }
}

// Providers
final speechServiceProvider = Provider<SpeechService>((ref) => SpeechService());
final ttsServiceProvider = Provider<TtsService>((ref) => TtsService());

final voiceProvider = StateNotifierProvider<VoiceNotifier, VoiceState>((ref) {
  final speechService = ref.watch(speechServiceProvider);
  final ttsService = ref.watch(ttsServiceProvider);
  return VoiceNotifier(speechService, ttsService);
});
