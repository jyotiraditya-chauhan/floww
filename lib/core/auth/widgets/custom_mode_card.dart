import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:floww/config/constants/app_spacing.dart';
import 'package:floww/config/constants/app_sizes.dart';

class CustomModeCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;
  final Color color;

  const CustomModeCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: color.withValues(alpha: 0.24), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                width: AppSizes.s24,
                height: AppSizes.s24,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 22 / 16,
                    letterSpacing: -0.18,
                    color: color,
                    fontFamily: 'plusJakartaSans',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'plusJakartaSans',
              fontWeight: FontWeight.w400,
              height: 20 / 14,
              letterSpacing: 0,
              color: Colors.white.withValues(alpha: 0.55),
            ),
          ),
        ],
      ),
    );
  }
}
