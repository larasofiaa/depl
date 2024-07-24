import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/objects/topic.dart';

class TopicApi {
  Future<List<Topic>> findAll() async {
    final response = await http.get(
      Uri.parse('https://dad-quiz-api.deno.dev/topics'),
    );

    List<dynamic> topicItems = jsonDecode(response.body);
    return List<Topic>.from(topicItems.map(
      (jsonData) => Topic.fromJson(jsonData),
    ));
  }


  Future<int> numberOfTopics() async {
    final response = await http.get(
      Uri.parse('https://dad-quiz-api.deno.dev/topics'),
    );

    List<dynamic> topicItems = jsonDecode(response.body);
    return List<Topic>.from(topicItems.map(
      (jsonData) => Topic.fromJson(jsonData),
    )).length;
  }


}
