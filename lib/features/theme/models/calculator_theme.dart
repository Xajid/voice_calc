import 'package:flutter/material.dart';

/// Model class representing a calculator theme
class CalculatorTheme {
  final String id;
  final String name;
  final Color displayBackground;
  final Color displayTextPrimary;
  final Color displayTextSecondary;
  final Color displayErrorColor;

  final Color numberButtonColor;
  final Color numberButtonTextColor;

  final Color operatorButtonColor;
  final Color operatorButtonTextColor;

  final Color functionButtonColor;
  final Color functionButtonTextColor;

  final Color clearButtonColor;
  final Color clearButtonTextColor;

  final Color equalsButtonColor;
  final Color equalsButtonTextColor;

  final Color voiceButtonColor;
  final Color voiceButtonActiveColor;
  final Color voiceButtonIconColor;

  final Color scaffoldBackground;
  final Color appBarBackground;
  final Color appBarTextColor;

  final double buttonShadowBlur;
  final double displayShadowBlur;

  const CalculatorTheme({
    required this.id,
    required this.name,
    required this.displayBackground,
    required this.displayTextPrimary,
    required this.displayTextSecondary,
    required this.displayErrorColor,
    required this.numberButtonColor,
    required this.numberButtonTextColor,
    required this.operatorButtonColor,
    required this.operatorButtonTextColor,
    required this.functionButtonColor,
    required this.functionButtonTextColor,
    required this.clearButtonColor,
    required this.clearButtonTextColor,
    required this.equalsButtonColor,
    required this.equalsButtonTextColor,
    required this.voiceButtonColor,
    required this.voiceButtonActiveColor,
    required this.voiceButtonIconColor,
    required this.scaffoldBackground,
    required this.appBarBackground,
    required this.appBarTextColor,
    this.buttonShadowBlur = 8.0,
    this.displayShadowBlur = 6.0,
  });
}
