import 'package:flappt/core/extensions/index.dart';
import 'package:flutter/material.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: context.appColors.outline.withValues(alpha: 0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: context.appTextTheme.bodySmall?.copyWith(
              color: context.appColors.onSurface.withValues(
                alpha: 0.6,
              ),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: context.appColors.outline.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
