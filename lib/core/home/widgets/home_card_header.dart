import 'package:flutter/material.dart';
import 'package:floww/config/constants/app_sizes.dart';
import 'package:floww/config/constants/app_spacing.dart';
import 'package:floww/config/theme/app_theme_tokens.dart';

class HomeCardHeader extends StatelessWidget {
  const HomeCardHeader({
    super.key,
    required this.title,
    this.trailingText,
    this.showChevron = false,
    this.onTap,
  });

  final String title;
  final String? trailingText;
  final bool showChevron;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Text(title, style: context.textTheme.titleLarge),
          if (trailingText != null) ...[
            SizedBox(width: AppSpacing.sm),
            Text(
              trailingText!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ],
          if (showChevron) ...[
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: context.colors.textSecondary,
              size: AppSizes.s20,
            ),
          ],
        ],
      ),
    );
  }
}
