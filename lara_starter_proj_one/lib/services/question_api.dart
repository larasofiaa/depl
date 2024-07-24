import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_application_1/objects/questions.dart';
import 'package:flutter_application_1/objects/response.dart';

class QuestionApi {
 
  Future<Question> findDefault() async {
    final response = await http.get(
      Uri.parse('https://dad-quiz-api.deno.dev/topics/1/questions'),
    );

  dynamic questionItem = jsonDecode(response.body);
    return Question.fromJson(questionItem);
  }

  Future<Question> findQuestion(int topicId) async {
    final response = await http.get(
      Uri.parse('https://dad-quiz-api.deno.dev/topics/$topicId/questions'),
    );

  dynamic questionItem = jsonDecode(response.body);
    return Question.fromJson(questionItem);
  }

   Future<Response> postAnswer(int topicId, int questionId, String answer) async {
    final data = {"answer": answer}; 
    final response = await http.post(
      Uri.parse('https://dad-quiz-api.deno.dev/topics/$topicId/questions/$questionId/answers'),
      body: jsonEncode(data), 
    );
   dynamic responseItem = jsonDecode(response.body);
   return Response.fromJson(responseItem);
  }

}
