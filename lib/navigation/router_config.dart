import 'package:floww/core/auth/views/splash_view.dart';
import 'package:floww/core/onboarding/views/connect_wearables_view.dart';
import 'package:floww/core/onboarding/views/onboarding_question_view.dart';
import 'package:flutter/material.dart';

import '../core/auth/views/auth_view.dart';
import '../core/auth/views/meet_waves_view.dart';
import 'app_router.dart';
import 'views/main_tab_view.dart';

class AppRouterConfig {
  AppRouterConfig._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouter.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case AppRouter.meetWaves:
        return MaterialPageRoute(builder: (_) => const MeetWavesView());
      case AppRouter.accountSetup:
        return MaterialPageRoute(builder: (_) => const AuthView());
      case AppRouter.onboardingQuestion:
        return MaterialPageRoute(builder: (_) => OnboardingQuestionView());
      case AppRouter.connectWearables:
        return MaterialPageRoute(builder: (_) => const ConnectWearablesView());
      case AppRouter.home:
        return MaterialPageRoute(builder: (_) => const MainTabView());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("No View Found"))),
        );
    }
  }
}
