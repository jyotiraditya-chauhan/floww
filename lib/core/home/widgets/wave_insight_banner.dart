import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:floww/config/constants/app_images.dart';
import 'package:floww/config/constants/app_sizes.dart';
import 'package:floww/config/constants/app_spacing.dart';
import 'package:floww/config/theme/app_theme_tokens.dart';
import 'package:floww/core/home/widgets/home_card.dart';

class WaveInsightBanner extends StatelessWidget {
  const WaveInsightBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return HomeCard(
      variant: HomeCardVariant.tinted,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: AppSizes.s28,
            width: AppSizes.s28,
            decoration: BoxDecoration(
              color: context.colors.primary,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(AppSpacing.xs),
            child: SvgPicture.asset(
              AppImages.waveIcon,
              colorFilter: ColorFilter.mode(
                context.colors.textPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.textSecondary,
                ),
                children: [
                  TextSpan(
                    text: 'Wave Insight: ',
                    style: TextStyle(
                      color: context.colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(text: message),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
