import 'package:flutter/material.dart';
import 'package:floww/config/constants/app_sizes.dart';
import 'package:floww/config/constants/app_spacing.dart';
import 'package:floww/config/theme/app_theme_tokens.dart';
import 'package:floww/config/widgets/buttons/custom_buttons/custom_button.dart';

class HomeCardEmptyState extends StatelessWidget {
  const HomeCardEmptyState({
    super.key,
    required this.icon,
    required this.message,
    required this.buttonText,
    this.buttonIcon,
    this.filled = false,
    this.onPressed,
  });

  final IconData icon;
  final String message;
  final String buttonText;
  final IconData? buttonIcon;
  final bool filled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: context.colors.textMuted, size: AppSizes.s40),
        SizedBox(height: AppSpacing.lg),
        Text(
          message,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
        SizedBox(height: AppSpacing.xl),
        CustomButton(
          text: buttonText,
          icon: buttonIcon,
          backgroundColor: filled ? context.colors.textPrimary : null,
          foregroundColor: filled ? context.colors.backgroundPrimary : null,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
