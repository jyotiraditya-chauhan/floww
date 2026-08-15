import 'package:flutter/material.dart';
import 'package:floww/config/theme/app_theme.dart';

class FlowScoreBoost {
  const FlowScoreBoost({
    required this.label,
    required this.points,
    required this.completed,
  });

  final String label;
  final int points;
  final bool completed;
}

class HabitItem {
  const HabitItem({
    required this.title,
    required this.valueLabel,
    required this.completed,
  });

  final String title;
  final String valueLabel;
  final bool completed;
}

class WorkoutRecommendation {
  const WorkoutRecommendation({
    required this.title,
    required this.durationLabel,
    required this.intensityLabel,
    required this.reasons,
  });

  final String title;
  final String durationLabel;
  final String intensityLabel;
  final List<String> reasons;
}

class NutritionSummary {
  const NutritionSummary({
    required this.totalCalories,
    required this.calorieGoal,
    required this.proteinG,
    required this.carbsG,
    required this.fatsG,
  });

  final int totalCalories;
  final int calorieGoal;
  final int proteinG;
  final int carbsG;
  final int fatsG;
}

class ProgressItem {
  const ProgressItem({
    required this.label,
    required this.fraction,
    required this.isComplete,
  });

  final String label;
  final String fraction;
  final bool isComplete;
}

class TodayProgress {
  const TodayProgress({
    required this.completedCount,
    required this.totalCount,
    required this.items,
  });

  final int completedCount;
  final int totalCount;
  final List<ProgressItem> items;

  int get percent =>
      totalCount == 0 ? 0 : ((completedCount / totalCount) * 100).round();
}

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    _greeting = _greetingForHour(DateTime.now().hour);
  }

  static String _greetingForHour(int hour) {
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  late final String _greeting;
  String get greeting => _greeting;

  final String userName = 'Sarah Mitchell';
  final int streakCount = 29;
  final String? avatarUrl = null;

  final int flowScorePercent = 74;
  final String? recoveryLevel = 'High';
  final AppThemeMode? todayMode = AppThemeMode.flow;

  final List<FlowScoreBoost> flowScoreBoosts = const [
    FlowScoreBoost(label: 'Workout', points: 8, completed: true),
    FlowScoreBoost(label: 'Protein Goal', points: 3, completed: false),
    FlowScoreBoost(label: 'Water Goal', points: 2, completed: false),
    FlowScoreBoost(label: 'Sleep Goal', points: 5, completed: false),
  ];

  final List<HabitItem> habits = const [
    HabitItem(
      title: 'Water Intake',
      valueLabel: '2.5L / 3L Target',
      completed: true,
    ),
    HabitItem(
      title: 'Sleep Quality',
      valueLabel: '8h 12m logged',
      completed: false,
    ),
    HabitItem(
      title: 'Daily Steps',
      valueLabel: '8,432 / 10,000',
      completed: false,
    ),
  ];

  final WorkoutRecommendation? workout = const WorkoutRecommendation(
    title: 'Push Day: Chest & Triceps',
    durationLabel: '60m',
    intensityLabel: 'High Intensity',
    reasons: ['Recovery is High', 'Last workout 48h ago', 'FLOW mode active'],
  );

  final NutritionSummary nutrition = const NutritionSummary(
    totalCalories: 1842,
    calorieGoal: 2450,
    proteinG: 115,
    carbsG: 155,
    fatsG: 70,
  );

  final bool healthSyncConnected = true;

  final TodayProgress todayProgress = const TodayProgress(
    completedCount: 2,
    totalCount: 6,
    items: [
      ProgressItem(label: 'Habits', fraction: '1/3', isComplete: false),
      ProgressItem(label: 'Workout', fraction: '0/1', isComplete: false),
      ProgressItem(label: 'Nutrition', fraction: '1/1', isComplete: true),
      ProgressItem(label: 'Sleep Goal', fraction: '0/1', isComplete: false),
    ],
  );

  final String? waveInsight =
      'Recovery is high. Neural fatigue minimal — prime window for a push session PB.';
}
