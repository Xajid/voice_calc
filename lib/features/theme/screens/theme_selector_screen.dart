import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_themes.dart';
import '../models/calculator_theme.dart';
import '../providers/theme_provider.dart';

class ThemeSelectorScreen extends ConsumerWidget {
  const ThemeSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: currentTheme.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          'Choose Theme',
          style: TextStyle(color: currentTheme.appBarTextColor),
        ),
        backgroundColor: currentTheme.appBarBackground,
        iconTheme: IconThemeData(color: currentTheme.appBarTextColor),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: AppThemes.allThemes.length,
            itemBuilder: (context, index) {
              final theme = AppThemes.allThemes[index];
              final isSelected = theme.id == currentTheme.id;

              return _ThemeCard(
                theme: theme,
                isSelected: isSelected,
                onTap: () {
                  ref.read(themeProvider.notifier).setTheme(theme);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ThemeCard extends StatelessWidget {
  final CalculatorTheme theme;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeCard({
    required this.theme,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: theme.displayBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? theme.operatorButtonColor : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: isSelected ? 12 : 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Theme name header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.appBarBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      theme.name,
                      style: TextStyle(
                        color: theme.appBarTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: theme.appBarTextColor,
                      size: 20,
                    ),
                ],
              ),
            ),

            // Sample buttons preview
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Number and operator buttons row
                    Row(
                      children: [
                        Expanded(
                          child: _PreviewButton(
                            label: '7',
                            color: theme.numberButtonColor,
                            textColor: theme.numberButtonTextColor,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: _PreviewButton(
                            label: '+',
                            color: theme.operatorButtonColor,
                            textColor: theme.operatorButtonTextColor,
                          ),
                        ),
                      ],
                    ),
                    // Function and clear buttons row
                    Row(
                      children: [
                        Expanded(
                          child: _PreviewButton(
                            label: 'sin',
                            color: theme.functionButtonColor,
                            textColor: theme.functionButtonTextColor,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: _PreviewButton(
                            label: 'C',
                            color: theme.clearButtonColor,
                            textColor: theme.clearButtonTextColor,
                          ),
                        ),
                      ],
                    ),
                    // Equals button
                    _PreviewButton(
                      label: '=',
                      color: theme.equalsButtonColor,
                      textColor: theme.equalsButtonTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final double fontSize;

  const _PreviewButton({
    required this.label,
    required this.color,
    required this.textColor,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
