import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  Size get appSize => MediaQuery.sizeOf(this);
}
