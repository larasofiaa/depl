import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedbackNotifier extends StateNotifier<String> {
 
  FeedbackNotifier() : super("");

  _initialize()  {
    state = "";
  }

  updateToCorrect() {
    state = "Your answer was correct.\n";
  }

  updateToWrong() {
    state = "Unfortunately, your answer was wrong. Try again.\n";
  }

   resetToEmpty() {
    state = "";
  }

}

final feedbackProvider = StateNotifierProvider<FeedbackNotifier, String>((ref) {
  final fn = FeedbackNotifier();
  fn._initialize();
  return fn;
});