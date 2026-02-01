import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;

// Calculator State
class CalculatorState {
  final String expression;
  final String result;
  final bool hasError;
  final String errorMessage;

  CalculatorState({
    this.expression = '',
    this.result = '0',
    this.hasError = false,
    this.errorMessage = '',
  });

  CalculatorState copyWith({
    String? expression,
    String? result,
    bool? hasError,
    String? errorMessage,
  }) {
    return CalculatorState(
      expression: expression ?? this.expression,
      result: result ?? this.result,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// Calculator Notifier
class CalculatorNotifier extends StateNotifier<CalculatorState> {
  CalculatorNotifier() : super(CalculatorState());

  // Add input to expression
  void addInput(String input) {
    if (state.hasError) {
      clear();
    }

    final newExpression = state.expression + input;
    state = state.copyWith(expression: newExpression);

    // Try to calculate preview
    _calculatePreview();
  }

  // Delete last character
  void deleteLast() {
    if (state.expression.isEmpty) return;

    final newExpression = state.expression.substring(
      0,
      state.expression.length - 1,
    );
    state = state.copyWith(
      expression: newExpression,
      hasError: false,
      errorMessage: '',
    );

    if (newExpression.isEmpty) {
      state = state.copyWith(result: '0');
    } else {
      _calculatePreview();
    }
  }

  // Clear everything
  void clear() {
    state = CalculatorState();
  }

  // Clear just the current expression
  void clearEntry() {
    state = state.copyWith(expression: '', result: '0');
  }

  // Calculate result
  String calculate() {
    if (state.expression.isEmpty) {
      return state.result;
    }

    try {
      final result = _evaluateExpression(state.expression);
      state = state.copyWith(result: result, hasError: false, errorMessage: '');
      return result;
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: 'Error: ${e.toString()}',
        result: 'Error',
      );
      return 'Error';
    }
  }

  // Private method to calculate preview
  void _calculatePreview() {
    try {
      final result = _evaluateExpression(state.expression);
      state = state.copyWith(result: result, hasError: false);
    } catch (e) {
      // Don't show error for preview, just keep previous result
    }
  }

  // Evaluate mathematical expression
  String _evaluateExpression(String expr) {
    if (expr.isEmpty) return '0';

    // Replace visual operators with parseable ones
    String parseableExpr = expr
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('π', '${math.pi}')
        .replaceAll('e', '${math.e}');

    // Handle special functions
    parseableExpr = _handleSpecialFunctions(parseableExpr);

    try {
      Parser p = Parser();
      Expression exp = p.parse(parseableExpr);
      ContextModel cm = ContextModel();

      double result = exp.evaluate(EvaluationType.REAL, cm);

      // Check for infinity or NaN
      if (result.isInfinite) {
        throw Exception('Result is infinite');
      }
      if (result.isNaN) {
        throw Exception('Invalid calculation');
      }

      // Format result - remove unnecessary decimals
      if (result == result.toInt()) {
        return result.toInt().toString();
      } else {
        // Round to 10 decimal places to avoid floating point errors
        String formatted = result.toStringAsFixed(10);
        formatted = formatted.replaceAll(RegExp(r'0+$'), '');
        formatted = formatted.replaceAll(RegExp(r'\.$'), '');
        return formatted;
      }
    } catch (e) {
      throw Exception('Invalid expression');
    }
  }

  // Handle special functions like √, x², sin, cos, etc.
  String _handleSpecialFunctions(String expr) {
    // Handle square root: √9 → sqrt(9)
    expr = expr.replaceAllMapped(
      RegExp(r'√(\d+\.?\d*)'),
      (match) => 'sqrt(${match.group(1)})',
    );

    // Handle x²: 5² → pow(5,2)
    expr = expr.replaceAllMapped(
      RegExp(r'(\d+\.?\d*)²'),
      (match) => 'pow(${match.group(1)},2)',
    );

    return expr;
  }

  // Set expression directly (useful for voice input and history)
  void setExpression(String expr) {
    state = state.copyWith(expression: expr);
    _calculatePreview();
  }

  // Add operator (ensures no double operators)
  void addOperator(String operator) {
    if (state.expression.isEmpty && operator != '-') return;

    // If last character is an operator, replace it
    if (state.expression.isNotEmpty) {
      final lastChar = state.expression[state.expression.length - 1];
      if (['+', '-', '×', '÷', '*', '/'].contains(lastChar)) {
        deleteLast();
      }
    }

    addInput(operator);
  }
}

// Provider
final calculatorProvider =
    StateNotifierProvider<CalculatorNotifier, CalculatorState>((ref) {
      return CalculatorNotifier();
    });
