import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AppKey {
  factory AppKey() => _instance;

  AppKey._internal();

  static final AppKey _instance = AppKey._internal();

  static final GlobalKey<NavigatorState> routerKey = GlobalKey<NavigatorState>(
    debugLabel: 'routerKey',
  );

  static final GlobalKey<FormBuilderState> loginFormKey =
      GlobalKey<FormBuilderState>(debugLabel: 'loginFormKey');
}
