import 'package:flutter/material.dart';

extension ScaffoldExtension on BuildContext {
  ScaffoldMessengerState get appScaffoldMsgr => ScaffoldMessenger.of(this);
}
