import 'package:flappt/core/extensions/index.dart';
import 'package:flappt/core/l10n/l10n.dart';
import 'package:flutter/material.dart';

class AppIconWidget extends StatelessWidget {
  const AppIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.appColors.primary,
                context.appColors.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: context.appColors.primary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, .01),
              ),
            ],
          ),
          child: Icon(
            Icons.flutter_dash,
            size: 60,
            color: context.appColors.onPrimary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          context.l10n.appName,
          style: context.appTextTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.appColors.primary,
          ),
        ),
      ],
    );
  }
}
