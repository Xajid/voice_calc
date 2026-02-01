import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/calculator_provider.dart';
import '../../theme/providers/theme_provider.dart';

class CalculatorDisplay extends ConsumerWidget {
  const CalculatorDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calculatorState = ref.watch(calculatorProvider);
    final theme = ref.watch(themeProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.displayBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: theme.displayShadowBlur,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Expression
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              calculatorState.expression.isEmpty
                  ? '0'
                  : calculatorState.expression,
              key: ValueKey(calculatorState.expression),
              style: TextStyle(
                color: calculatorState.hasError
                    ? theme.displayErrorColor
                    : theme.displayTextSecondary,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),

          // Result/Preview
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              calculatorState.hasError
                  ? calculatorState.errorMessage
                  : calculatorState.result,
              key: ValueKey(calculatorState.result),
              style: TextStyle(
                color: calculatorState.hasError
                    ? theme.displayErrorColor
                    : theme.displayTextPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
