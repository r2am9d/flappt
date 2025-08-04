import 'package:flappt/core/extensions/index.dart';
import 'package:flutter/material.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Forgot Password?',
          style: context.appTextTheme.bodySmall?.copyWith(
            color: context.appColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
