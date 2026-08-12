import 'package:floww/config/constants/app_images.dart';
import 'package:floww/config/constants/app_spacing.dart';
import 'package:floww/config/constants/app_sizes.dart';
import 'package:floww/config/theme/app_theme_tokens.dart';
import 'package:floww/config/utils/backgrounds/app_background.dart';
import 'package:floww/config/widgets/buttons/custom_buttons/custom_button.dart';
import 'package:floww/config/widgets/headers/custom_header.dart';
import 'package:floww/core/auth/widgets/custom_mode_card.dart';
import 'package:floww/navigation/app_router.dart';
import 'package:floww/navigation/services/navigation_service.dart';
import 'package:flutter/material.dart';

class WelcomeToFlowView extends StatefulWidget {
  const WelcomeToFlowView({super.key});

  @override
  State<WelcomeToFlowView> createState() => _WelcomeToFlowViewState();
}

class _WelcomeToFlowViewState extends State<WelcomeToFlowView> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: AppBackground(
        safeAreaTop: true,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                    child: Column(
                      children: [
                        CustomHeader(
                          title: "Welcome to Floww",
                          onBackPressed: () {
                            NavigationService.instance.pop();
                          },
                        ),
                        SizedBox(height: height * 0.06),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Three Modes. \nOne System.",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'PlusJakartaSans',
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        SizedBox(height: AppSpacing.xl),
                        Text(
                          "WAVE adapts your workouts and nutrition\n every day based on how you feel.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF919191),

                            fontWeight: FontWeight.w500,
                            fontFamily: 'HankenGrotesk',
                          ),
                        ),
                        SizedBox(height: AppSizes.s28),
                        Column(
                          children: [
                            CustomModeCard(
                              iconPath: AppImages.welcome1,
                              title: 'FLOW',
                              description:
                                  "Peak performance. You're recovered, energized, and ready to push hard.",
                              color: AppColorTokens.flow.primary,
                            ),
                            const SizedBox(height: 16),
                            CustomModeCard(
                              iconPath: AppImages.welcome2,
                              title: 'STEADY',
                              description:
                                  'Consistent progress. Moderate intensity, building the habit long-term.',
                              color: const Color(0xFFFF9F43),
                            ),
                            const SizedBox(height: 16),
                            CustomModeCard(
                              iconPath: AppImages.welcome3,
                              title: 'RESTORE',
                              description:
                                  'Recovery day. Light movement, mobility, and letting your body rebuild.',
                              color: const Color(0xFF18D8F0),
                            ),
                          ],
                        ),
                        Spacer(),
                        CustomButton(
                          text: "Let's personalize",
                          onPressed: () {
                            NavigationService.instance.push(
                              AppRouter.onboardingQuestion,
                            );
                          },
                        ),
                        SizedBox(height: MediaQuery.paddingOf(context).bottom),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
