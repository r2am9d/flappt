import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ColorScheme get appColors => Theme.of(this).colorScheme;

  TextTheme get appTextTheme => Theme.of(this).textTheme;

  ThemeData get appTheme => Theme.of(this);
}
