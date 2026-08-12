import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:floww/config/theme/app_theme_tokens.dart';
import 'package:floww/config/constants/app_images.dart';
import 'package:floww/config/theme/app_typography.dart';
import '../providers/onboarding_provider.dart';

class HealthIntegrationWidget extends StatelessWidget {
  final String questionId;

  const HealthIntegrationWidget({super.key, required this.questionId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();
    final isConnected = provider.getAnswer(questionId) == true;
    final themeColors = context.colors;

    final borderColor = isConnected
        ? themeColors.primary
        : const Color(0xFF181818);
    const backgroundColor = Color(0xFF1F1F1F);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        // App Icon
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: themeColors.primary,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.asset(AppImages.appIcon, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 16),
        // Link Icon
        const Icon(Icons.link, color: Colors.white, size: 28),
        const SizedBox(height: 16),
        // Apple Health Card
        GestureDetector(
          onTap: () {
            provider.setAnswer(questionId, !isConnected);
          },
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Apple Health Icon Box
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppImages.appleHealthIcon,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Title
                Expanded(
                  child: Text(
                    'Apple Health',
                    style: AppTypography.bodyLargeMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                // Connect Button Pill
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isConnected
                        ? themeColors.primary.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: isConnected
                          ? themeColors.primary
                          : const Color(0xFF333333),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    isConnected ? 'Connected' : 'Connect',
                    style: TextStyle(
                      color: isConnected ? themeColors.primary : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'HankenGrotesk',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
