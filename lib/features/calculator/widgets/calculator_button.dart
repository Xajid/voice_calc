import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/providers/theme_provider.dart';

enum ButtonType { number, operator, function, equals, clear }

class CalculatorButton extends ConsumerStatefulWidget {
  final String label;
  final VoidCallback onTap;
  final ButtonType type;
  final bool isWide;
  final bool compact;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.onTap,
    this.type = ButtonType.number,
    this.isWide = false,
    this.compact = false,
  });

  @override
  ConsumerState<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends ConsumerState<CalculatorButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getButtonColor() {
    final theme = ref.watch(themeProvider);
    switch (widget.type) {
      case ButtonType.number:
        return theme.numberButtonColor;
      case ButtonType.operator:
        return theme.operatorButtonColor;
      case ButtonType.function:
        return theme.functionButtonColor;
      case ButtonType.equals:
        return theme.equalsButtonColor;
      case ButtonType.clear:
        return theme.clearButtonColor;
    }
  }

  Color _getTextColor() {
    final theme = ref.watch(themeProvider);
    switch (widget.type) {
      case ButtonType.number:
        return theme.numberButtonTextColor;
      case ButtonType.operator:
        return theme.operatorButtonTextColor;
      case ButtonType.function:
        return theme.functionButtonTextColor;
      case ButtonType.equals:
        return theme.equalsButtonTextColor;
      case ButtonType.clear:
        return theme.clearButtonTextColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonHeight = widget.compact ? 48.0 : 70.0;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Material(
        color: _getButtonColor(),
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.2),
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            _controller.forward().then((_) => _controller.reverse());
            widget.onTap();
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: buttonHeight,
            width: widget.isWide ? double.infinity : buttonHeight,
            alignment: Alignment.center,
            child: Text(
              widget.label,
              style: TextStyle(
                color: _getTextColor(),
                fontWeight: FontWeight.w600,
                fontSize: widget.compact
                    ? (widget.type == ButtonType.function ? 16 : 20)
                    : (widget.type == ButtonType.function ? 18 : 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
