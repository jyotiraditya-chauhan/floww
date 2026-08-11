import 'package:floww/config/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:floww/navigation/app_router.dart';
import 'package:floww/navigation/services/navigation_service.dart';
import 'package:floww/config/theme/app_theme_tokens.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    NavigationService.instance.pushReplacement(AppRouter.meetWaves);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundSurface,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
          child: Image.asset(
            'assets/icons/app_icon.png',
            width: 120,
            height: 120,
          ),
        ),
      ),
    );
  }
}
