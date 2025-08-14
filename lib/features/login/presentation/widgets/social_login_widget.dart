import 'package:flappt/core/extensions/index.dart';
import 'package:flutter/material.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _SocialButton(
          icon: Icons.g_mobiledata,
          label: 'Google',
          onPressed: () {},
        ),
        _SocialButton(
          icon: Icons.apple,
          label: 'Apple',
          onPressed: () {},
        ),
        _SocialButton(
          icon: Icons.facebook,
          label: 'Facebook',
          onPressed: () {},
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(
          color: context.appColors.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: context.appColors.primary,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: context.appTextTheme.labelSmall?.copyWith(
              color: context.appColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
