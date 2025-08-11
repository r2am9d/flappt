import 'package:flutter/material.dart';

extension FocusExtension on BuildContext {
  FocusScopeNode get appFocusScope => FocusScope.of(this);

  FocusManager get appFocusManager => FocusManager.instance;
}
