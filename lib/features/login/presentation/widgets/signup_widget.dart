import 'package:flappt/core/extensions/index.dart';
import 'package:flutter/material.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: context.appTextTheme.bodyMedium?.copyWith(
            color: context.appColors.onSurface.withValues(alpha: 0.7),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Sign Up',
            style: context.appTextTheme.bodyMedium?.copyWith(
              color: context.appColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
