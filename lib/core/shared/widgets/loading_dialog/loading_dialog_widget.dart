import 'package:flutter/material.dart';

class LoadingDialog {
  factory LoadingDialog() => _instance;

  LoadingDialog._internal();

  static bool _isShown = false;
  static BuildContext? _dialogContext;
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
        return PopScope(
          canPop: false,
          child: Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    ).then((_) {
      _isShown = false;
      _dialogContext = null;
    });
  }

  static void hide() {
    if (!_isShown) return;
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!).pop();
      _isShown = false;
      _dialogContext = null;
    }
  }
}
