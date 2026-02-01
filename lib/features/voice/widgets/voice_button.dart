import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/voice_provider.dart';
import '../../calculator/providers/calculator_provider.dart';
import '../../theme/providers/theme_provider.dart';

class VoiceButton extends ConsumerStatefulWidget {
  const VoiceButton({super.key});

  @override
  ConsumerState<VoiceButton> createState() => _VoiceButtonState();
}

class _VoiceButtonState extends ConsumerState<VoiceButton>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pulseController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Re-check permissions when app resumes
    if (state == AppLifecycleState.resumed) {
      ref.read(voiceProvider.notifier).checkPermissionStatus();
    }
  }

  void _handleVoiceInput() async {
    print('[VoiceButton] Handle voice input tapped');
    final voiceNotifier = ref.read(voiceProvider.notifier);
    var voiceState = ref.read(voiceProvider);
    final calculatorNotifier = ref.read(calculatorProvider.notifier);

    print(
      '[VoiceButton] Initial state - hasPermission: ${voiceState.hasPermission}, isAvailable: ${voiceState.isAvailable}, isListening: ${voiceState.isListening}',
    );

    if (voiceState.isListening) {
      print('[VoiceButton] Already listening, stopping...');
      await voiceNotifier.stopListening();
      return;
    }

    // Check and request permission if needed
    if (!voiceState.hasPermission) {
      print('[VoiceButton] No permission, requesting...');
      final granted = await voiceNotifier.requestPermission();
      print('[VoiceButton] Permission request result: $granted');
      if (!granted) {
        print('[VoiceButton] Permission denied, showing dialog');
        _showPermissionDialog();
        return;
      }

      // Re-read state after permission was granted
      print('[VoiceButton] Re-reading state after permission grant...');
      voiceState = ref.read(voiceProvider);
      print(
        '[VoiceButton] Updated state - hasPermission: ${voiceState.hasPermission}, isAvailable: ${voiceState.isAvailable}',
      );
    }

    // Check if speech recognition is available
    if (!voiceState.isAvailable) {
      print('[VoiceButton] Speech recognition not available!');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Speech recognition is not available on this device'),
          ),
        );
      }
      return;
    }

    // Start listening
    print('[VoiceButton] Starting to listen...');
    voiceNotifier.startListening((parsedExpression) {
      print('[VoiceButton] Got parsed expression: $parsedExpression');
      if (parsedExpression.isNotEmpty) {
        calculatorNotifier.setExpression(parsedExpression);
        final result = calculatorNotifier.calculate();
        voiceNotifier.speakResult(parsedExpression, result);
      }
    });
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Microphone Permission Required'),
        content: const Text(
          'Please grant microphone permission in your device settings to use voice input.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final voiceState = ref.watch(voiceProvider);
    final theme = ref.watch(themeProvider);

    return AnimatedBuilder(
      animation: voiceState.isListening
          ? _pulseAnimation
          : const AlwaysStoppedAnimation(1.0),
      builder: (context, child) {
        return Transform.scale(
          scale: voiceState.isListening ? _pulseAnimation.value : 1.0,
          child: FloatingActionButton(
            onPressed: _handleVoiceInput,
            backgroundColor: voiceState.isListening
                ? theme.voiceButtonActiveColor
                : theme.voiceButtonColor,
            child: Icon(
              voiceState.isListening ? Icons.mic : Icons.mic_none,
              size: 24,
              color: theme.voiceButtonIconColor,
            ),
          ),
        );
      },
    );
  }
}
