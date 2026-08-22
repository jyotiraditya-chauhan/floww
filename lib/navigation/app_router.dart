import 'package:floww/config/entities/user_model.dart';

class AppRouter {
  AppRouter._();

  static const String splash = '/splash';
  static const String meetWaves = '/meet_waves';
  static const String accountSetup = '/account_setup';
  static const String onboardingQuestion = '/onboardingQuestion';
  static const String connectWearables = '/connect_wearables';
  static const String home = '/home';

  static String routeAfterAuth(UserModel user) {
    if (user.onboardingCompleted) return home;
    if (user.answersSubmitted) return connectWearables;
    return onboardingQuestion;
  }
}
