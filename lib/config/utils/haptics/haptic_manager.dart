import 'package:haptic_feedback/haptic_feedback.dart';

class HapticManager {
  HapticManager._();

  static bool? _canVibrate;

  static Future<bool> canVibrate() async {
    return _canVibrate ??= await Haptics.canVibrate();
  }

  static Future<void> success() => _vibrate(HapticsType.success);

  static Future<void> warning() => _vibrate(HapticsType.warning);

  static Future<void> error() => _vibrate(HapticsType.error);

  static Future<void> light() => _vibrate(HapticsType.light);

  static Future<void> medium() => _vibrate(HapticsType.medium);

  static Future<void> heavy() => _vibrate(HapticsType.heavy);

  static Future<void> rigid() => _vibrate(HapticsType.rigid);

  static Future<void> soft() => _vibrate(HapticsType.soft);

  static Future<void> selection() => _vibrate(HapticsType.selection);

  static Future<void> _vibrate(HapticsType type) async {
    if (!await canVibrate()) return;
    await Haptics.vibrate(type);
  }
}
