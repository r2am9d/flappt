import 'package:flutter/material.dart';

extension FocusExtension on BuildContext {
  FocusScopeNode get focusScope => FocusScope.of(this);
}
