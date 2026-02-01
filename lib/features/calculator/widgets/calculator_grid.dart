import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/calculator_provider.dart';
import 'calculator_button.dart';
import '../../../core/enums/app_enums.dart';

class CalculatorGrid extends ConsumerWidget {
  final CalculatorMode mode;

  const CalculatorGrid({super.key, this.mode = CalculatorMode.standard});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(calculatorProvider.notifier);

    if (mode == CalculatorMode.scientific) {
      return _buildScientificGrid(notifier);
    }
    return _buildStandardGrid(notifier);
  }

  Widget _buildStandardGrid(CalculatorNotifier notifier) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRow([
          _buildButton('C', () => notifier.clear(), ButtonType.clear),
          _buildButton('DEL', () => notifier.deleteLast(), ButtonType.clear),
          _buildButton('%', () => notifier.addInput('%'), ButtonType.operator),
          _buildButton(
            '÷',
            () => notifier.addOperator('÷'),
            ButtonType.operator,
          ),
        ]),
        const SizedBox(height: 8),
        _buildRow([
          _buildButton('7', () => notifier.addInput('7')),
          _buildButton('8', () => notifier.addInput('8')),
          _buildButton('9', () => notifier.addInput('9')),
          _buildButton(
            '×',
            () => notifier.addOperator('×'),
            ButtonType.operator,
          ),
        ]),
        const SizedBox(height: 8),
        _buildRow([
          _buildButton('4', () => notifier.addInput('4')),
          _buildButton('5', () => notifier.addInput('5')),
          _buildButton('6', () => notifier.addInput('6')),
          _buildButton(
            '-',
            () => notifier.addOperator('-'),
            ButtonType.operator,
          ),
        ]),
        const SizedBox(height: 8),
        _buildRow([
          _buildButton('1', () => notifier.addInput('1')),
          _buildButton('2', () => notifier.addInput('2')),
          _buildButton('3', () => notifier.addInput('3')),
          _buildButton(
            '+',
            () => notifier.addOperator('+'),
            ButtonType.operator,
          ),
        ]),
        const SizedBox(height: 8),
        // Bottom row
        Row(
          children: [
            Expanded(
              child: CalculatorButton(
                label: '.',
                onTap: () => notifier.addInput('.'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CalculatorButton(
                label: '0',
                onTap: () => notifier.addInput('0'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: CalculatorButton(
                label: '=',
                type: ButtonType.equals,
                onTap: () => notifier.calculate(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildScientificGrid(CalculatorNotifier notifier) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRow([
          _buildButton(
            'sin',
            () => notifier.addInput('sin('),
            ButtonType.function,
            true,
          ),
          _buildButton(
            'cos',
            () => notifier.addInput('cos('),
            ButtonType.function,
            true,
          ),
          _buildButton(
            'tan',
            () => notifier.addInput('tan('),
            ButtonType.function,
            true,
          ),
          _buildButton(
            'log',
            () => notifier.addInput('log('),
            ButtonType.function,
            true,
          ),
        ]),
        const SizedBox(height: 3),
        _buildRow([
          _buildButton(
            'ln',
            () => notifier.addInput('ln('),
            ButtonType.function,
            true,
          ),
          _buildButton(
            '√',
            () => notifier.addInput('√'),
            ButtonType.function,
            true,
          ),
          _buildButton(
            'x²',
            () => notifier.addInput('²'),
            ButtonType.function,
            true,
          ),
          _buildButton(
            'π',
            () => notifier.addInput('π'),
            ButtonType.function,
            true,
          ),
        ]),
        const SizedBox(height: 3),
        _buildRow([
          _buildButton(
            '(',
            () => notifier.addInput('('),
            ButtonType.number,
            true,
          ),
          _buildButton(
            ')',
            () => notifier.addInput(')'),
            ButtonType.number,
            true,
          ),
          _buildButton(
            'e',
            () => notifier.addInput('e'),
            ButtonType.function,
            true,
          ),
          _buildButton(
            'DEL',
            () => notifier.deleteLast(),
            ButtonType.clear,
            true,
          ),
        ]),
        const SizedBox(height: 3),
        _buildRow([
          _buildButton('7', () => notifier.addInput('7')),
          _buildButton('8', () => notifier.addInput('8')),
          _buildButton('9', () => notifier.addInput('9')),
          _buildButton(
            '÷',
            () => notifier.addOperator('÷'),
            ButtonType.operator,
          ),
        ]),
        const SizedBox(height: 3),
        _buildRow([
          _buildButton('4', () => notifier.addInput('4')),
          _buildButton('5', () => notifier.addInput('5')),
          _buildButton('6', () => notifier.addInput('6')),
          _buildButton(
            '×',
            () => notifier.addOperator('×'),
            ButtonType.operator,
          ),
        ]),
        const SizedBox(height: 3),
        _buildRow([
          _buildButton('1', () => notifier.addInput('1')),
          _buildButton('2', () => notifier.addInput('2')),
          _buildButton('3', () => notifier.addInput('3')),
          _buildButton(
            '-',
            () => notifier.addOperator('-'),
            ButtonType.operator,
          ),
        ]),
        const SizedBox(height: 3),
        // Bottom row
        Row(
          children: [
            Expanded(
              child: CalculatorButton(
                label: 'C',
                type: ButtonType.clear,
                onTap: () => notifier.clear(),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CalculatorButton(
                label: '0',
                onTap: () => notifier.addInput('0'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CalculatorButton(
                label: '.',
                onTap: () => notifier.addInput('.'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CalculatorButton(
                label: '+',
                type: ButtonType.operator,
                onTap: () => notifier.addOperator('+'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        // Full width equals button
        // CalculatorButton(
        //   label: '=',
        //   type: ButtonType.equals,
        //   onTap: () => notifier.calculate(),
        // ),
      ],
    );
  }

  Widget _buildRow(List<Widget> buttons) {
    return Row(
      children:
          buttons
              .expand((button) => [button, const SizedBox(width: 8)])
              .toList()
            ..removeLast(),
    );
  }

  Widget _buildButton(
    String label,
    VoidCallback onTap, [
    ButtonType type = ButtonType.number,
    bool compact = false,
  ]) {
    return Expanded(
      child: CalculatorButton(
        label: label,
        type: type,
        onTap: onTap,
        compact: compact,
      ),
    );
  }
}
