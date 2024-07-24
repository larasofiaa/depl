import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_1/objects/questions.dart';
import 'package:flutter_application_1/services/question_api.dart';

class QuestionNotifier extends StateNotifier<Question> {
  final questionApi = QuestionApi();
  QuestionNotifier() : super(Question.empty());

  _initialize() async {
    state = Question.empty(); 
  }

  updateToCurrentQuestion(int topicId) async{
    state = await questionApi.findQuestion(topicId);
  }

  removeAnswerFromOptions(String option) async{
    var question = Question.empty(); 
    question= state; 
    question.options.removeWhere((item) => item==option);
    state=question;  
  }

}

final questionProvider = StateNotifierProvider<QuestionNotifier, Question>((ref) {
  final tn = QuestionNotifier();
  tn._initialize();
  return tn;
});