import 'dart:math';

class AnimationUtils {
  static final List<String> REWARD_STRING = [
    "Awesome!",
    "Keep it up",
    "Let's gooo",
    "Yeah, why not",
    "Alright",
    "On a streak.."
  ];
  static String fetchRandomRewardString() {
    return REWARD_STRING[Random().nextInt(REWARD_STRING.length)];
  }
}