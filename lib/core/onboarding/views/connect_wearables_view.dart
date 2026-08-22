import 'package:flutter/material.dart';

import 'package:floww/config/constants/app_spacing.dart';
import 'package:floww/config/theme/app_theme_tokens.dart';
import 'package:floww/config/utils/backgrounds/app_background.dart';
import 'package:floww/config/widgets/buttons/custom_buttons/custom_button.dart';
import 'package:floww/config/widgets/headers/custom_header.dart';
import 'package:floww/navigation/app_router.dart';
import 'package:floww/navigation/services/navigation_service.dart';

import '../services/onboarding_service.dart';
import '../widgets/health_integration_widget.dart';

class ConnectWearablesView extends StatefulWidget {
  const ConnectWearablesView({super.key});

  @override
  State<ConnectWearablesView> createState() => _ConnectWearablesViewState();
}

class _ConnectWearablesViewState extends State<ConnectWearablesView> {
  final _onboardingService = OnboardingService();

  bool _isConnected = false;
  bool _isSubmitting = false;
  String? _errorMessage;

  Future<void> _handleContinue() async {
    setState(() {
      _errorMessage = null;
      _isSubmitting = true;
    });

    try {
      await _onboardingService.markWearablesStepDone(_isConnected);
      if (!mounted) return;
      NavigationService.instance.pushAndRemoveUntil(AppRouter.home);
    } on OnboardingException catch (e) {
      setState(() => _errorMessage = e.message);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Column(
              children: [
                const CustomHeader(title: "Connect Wearables"),
                SizedBox(height: AppSpacing.xl5),
                Text(
                  "Sync recovery & activity automatically",
                  textAlign: TextAlign.center,
                  style: context.textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: HealthIntegrationWidget(
                      isConnected: _isConnected,
                      onToggle: () =>
                          setState(() => _isConnected = !_isConnected),
                    ),
                  ),
                ),
                if (_errorMessage != null) ...[
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.destructive,
                    ),
                  ),
                  SizedBox(height: AppSpacing.lg),
                ],
                CustomButton(
                  text: "Continue",
                  isLoading: _isSubmitting,
                  onPressed: _handleContinue,
                ),
                SizedBox(
                  height: MediaQuery.paddingOf(context).bottom + AppSpacing.xl,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
