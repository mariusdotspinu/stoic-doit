import 'dart:math';

class AnimationUtils {
  static final List<String> REWARD_STRING = [
    "Awesome!",
    "Keep it up",
    "Let's gooo",
    "Yeah, why not",
    "All right",
    "On a streak...",
    "This was easy"
  ];
  static String fetchRandomRewardString() {
    return REWARD_STRING[Random().nextInt(REWARD_STRING.length)];
  }
}