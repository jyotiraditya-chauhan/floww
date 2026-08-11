import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/theme/app_theme.dart';
import 'config/theme/theme_controller.dart';
import 'navigation/app_router.dart';
import 'navigation/services/navigation_service.dart';
import 'navigation/router_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final saved = AppThemeMode.values.firstWhere(
    (e) => e.name == (prefs.getString('app_theme_mode') ?? 'flow'),
    orElse: () => AppThemeMode.flow,
  );
  runApp(MainApp(initialMode: saved));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.initialMode});

  final AppThemeMode initialMode;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModeController(initialMode),
      child: Consumer<ThemeModeController>(
        builder: (context, controller, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.buildTheme(controller.mode),
          navigatorKey: NavigationService.navigatorKey,
          initialRoute: AppRouter.splash,
          onGenerateRoute: AppRouterConfig.generateRoute,
        ),
      ),
    );
  }
}
