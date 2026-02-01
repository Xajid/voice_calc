import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'features/calculator/screens/calculator_screen.dart';
import 'features/history/models/history_entry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(HistoryEntryAdapter());

  // Open boxes
  await Hive.openBox<HistoryEntry>('history');

  runApp(const ProviderScope(child: VoiceCalculatorApp()));
}

class VoiceCalculatorApp extends ConsumerWidget {
  const VoiceCalculatorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Voice Calculator',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const CalculatorScreen(),
    );
  }
}
