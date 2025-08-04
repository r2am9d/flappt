import 'package:flutter/material.dart';

class LoadingDialog {
  factory LoadingDialog() => _instance;

  LoadingDialog._internal();

  static bool _isShown = false;
  static late BuildContext _dialogContext;
  static final LoadingDialog _instance = LoadingDialog._internal();

  static bool get isShown => _isShown;

  static void show(BuildContext context) {
    if (_isShown) return;
    _isShown = true;
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (dialogContext) {
        _dialogContext = dialogContext;
        return const PopScope(
          canPop: false,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  static void hide() {
    if (!_isShown) return;
    _isShown = false;
    Navigator.of(_dialogContext).pop();
  }
}
