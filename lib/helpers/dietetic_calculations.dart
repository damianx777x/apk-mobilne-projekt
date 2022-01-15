import 'package:kcall_app/pages/account_settings.dart';

class DietCalculations {
  static int calculateDailyKcallBalance(Sex sex, WeightTarget weightTarget,
      ActivityLevel activityLevel, int age, double weight, int height) {
    double activityLevelModifier;
    switch (activityLevel) {
      case ActivityLevel.veryLow:
        activityLevelModifier = 1;
        break;
      case ActivityLevel.low:
        activityLevelModifier = 1.2;
        break;
      case ActivityLevel.medium:
        activityLevelModifier = 1.4;
        break;
      case ActivityLevel.high:
        activityLevelModifier = 1.7;
        break;
      case ActivityLevel.veryHigh:
        activityLevelModifier = 2;
        break;
    }
    int weightTargetModifier;
    switch (weightTarget) {
      case WeightTarget.lose:
        weightTargetModifier = -500;
        break;
      case WeightTarget.keep:
        weightTargetModifier = 0;
        break;
      case WeightTarget.gain:
        weightTargetModifier = 500;
        break;
    }

    if (sex == Sex.male) {
      return ((66.5 + 17.7 * weight + 5 * height - 6.8 * age) *
                  activityLevelModifier +
              weightTargetModifier)
          .floor();
    } else {
      return ((665 + 9.6 * weight + 1.85 * -4.7 * age) * activityLevelModifier +
              weightTargetModifier)
          .floor();
    }
  }
}
