import 'package:floww/core/auth/views/splash_view.dart';
import 'package:floww/core/auth/views/welcome_to_flow_view.dart';
import 'package:flutter/material.dart';

import '../core/auth/views/meet_waves_view.dart';
import 'app_router.dart';

class AppRouterConfig {
  AppRouterConfig._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouter.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case AppRouter.meetWaves:
        return MaterialPageRoute(builder: (_) => const MeetWavesView());
      case AppRouter.welcomeToFlowView:
        return MaterialPageRoute(builder: (_) => WelcomeToFlowView());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("No View Found"))),
        );
    }
  }
}
