import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:floww/config/constants/app_sizes.dart';
import 'package:floww/config/constants/app_spacing.dart';
import 'package:floww/config/theme/app_theme_tokens.dart';
import 'package:floww/config/utils/backgrounds/app_background.dart';
import 'package:floww/config/widgets/buttons/custom_buttons/custom_button.dart';
import 'package:floww/config/widgets/headers/custom_header.dart';
import 'package:floww/navigation/services/navigation_service.dart';

import '../providers/onboarding_provider.dart';
import '../widgets/onboarding_question_renderer.dart';

class OnboardingQuestionView extends StatefulWidget {
  const OnboardingQuestionView({super.key});

  @override
  State<OnboardingQuestionView> createState() => _OnboardingQuestionViewState();
}

class _OnboardingQuestionViewState extends State<OnboardingQuestionView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We provide the OnboardingProvider here, though it could also be provided higher up in the app routing.
    return ChangeNotifierProvider(
      create: (_) => OnboardingProvider(),
      child: Scaffold(
        body: Consumer<OnboardingProvider>(
          builder: (context, provider, child) {
            final bottomReserve =
                AppSizes.s56 +
                AppSpacing.xl +
                MediaQuery.paddingOf(context).bottom;
            return Stack(
              children: [
                const Positioned.fill(
                  child: AppBackground(child: SizedBox.shrink()),
                ),
                SafeArea(
                  bottom: false,
                  left: false,
                  right: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                    child: Column(
                      children: [
                        CustomHeader(
                          title: provider.currentPhase.title,
                          onBackPressed: () {
                            if (provider.currentPhaseIndex == 0 &&
                                provider.currentQuestionIndex == 0) {
                              NavigationService.instance.pop();
                            } else {
                              provider.previousQuestion(_pageController);
                            }
                          },
                        ),
                        SizedBox(height: AppSpacing.xl),
                        LinearProgressIndicator(
                          value: provider.globalProgress,
                          color: context.colors.primary,
                          backgroundColor: context.colors.backgroundSurface,
                          borderRadius: BorderRadius.circular(AppRadius.full),
                        ),
                        SizedBox(height: AppSpacing.xl5),

                        // The main scrolling view
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            physics:
                                const NeverScrollableScrollPhysics(), // Only move via buttons
                            // We flatten all active phases into a single continuous list of questions for the PageView
                            itemCount: provider.activePhases.fold<int>(
                              0,
                              (sum, phase) => sum + phase.questions.length,
                            ),
                            itemBuilder: (context, index) {
                              // Find which phase and question this global index corresponds to
                              int accumulated = 0;
                              for (var phase in provider.activePhases) {
                                if (index <
                                    accumulated + phase.questions.length) {
                                  final question =
                                      phase.questions[index - accumulated];
                                  return OnboardingQuestionRenderer(
                                    question: question,
                                  );
                                }
                                accumulated += phase.questions.length;
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),

                        SizedBox(height: bottomReserve),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            context.colors.backgroundPrimary,
                            context.colors.backgroundPrimary.withValues(
                              alpha: 0,
                            ),
                          ],
                          stops: const [0.0, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Bottom Navigation
                        CustomButton(
                          text: "Continue",
                          // Disable button if answer is missing
                          onPressed: provider.canContinue
                              ? () => provider.nextQuestion(_pageController)
                              : null,
                        ),
                        SizedBox(
                          height:
                              MediaQuery.paddingOf(context).bottom +
                              AppSpacing.xl,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
