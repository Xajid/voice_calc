import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_grid.dart';
import '../../../core/enums/app_enums.dart';
import '../../voice/widgets/voice_button.dart';
import '../../theme/providers/theme_provider.dart';
import '../../theme/screens/theme_selector_screen.dart';

// Provider for calculator mode
final calculatorModeProvider = StateProvider<CalculatorMode>((ref) {
  return CalculatorMode.standard;
});

class CalculatorScreen extends ConsumerWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calculatorMode = ref.watch(calculatorModeProvider);
    final theme = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: theme.appBarBackground,
        title: Text(
          'Voice Calc',
          style: TextStyle(color: theme.appBarTextColor),
        ),
        iconTheme: IconThemeData(color: theme.appBarTextColor),
        actions: [
          // Mode toggle dropdown
          PopupMenuButton<CalculatorMode>(
            icon: Icon(
              calculatorMode == CalculatorMode.standard
                  ? Icons.calculate
                  : Icons.science,
            ),
            tooltip: 'Calculator Mode',
            onSelected: (mode) {
              ref.read(calculatorModeProvider.notifier).state = mode;
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: CalculatorMode.standard,
                child: Row(
                  children: [
                    const Icon(Icons.calculate),
                    const SizedBox(width: 12),
                    const Text('Standard'),
                    if (calculatorMode == CalculatorMode.standard)
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.check, size: 16),
                      ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: CalculatorMode.scientific,
                child: Row(
                  children: [
                    const Icon(Icons.science),
                    const SizedBox(width: 12),
                    const Text('Scientific'),
                    if (calculatorMode == CalculatorMode.scientific)
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.check, size: 16),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // Theme selector button
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThemeSelectorScreen(),
                ),
              );
            },
            tooltip: 'Choose Theme',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 10.0),
          child: Column(
            children: [
              // Calculator Display - fixed size
              const SizedBox(height: 150, child: CalculatorDisplay()),
              const SizedBox(height: 16),

              // Calculator Grid - takes remaining space
              Expanded(child: CalculatorGrid(mode: calculatorMode)),
            ],
          ),
        ),
      ),
      floatingActionButton: const VoiceButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
