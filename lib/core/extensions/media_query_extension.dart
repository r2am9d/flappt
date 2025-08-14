import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  Size get appSize => MediaQuery.sizeOf(this);

  MediaQueryData get appMediaQuery => MediaQuery.of(this);
}
