import 'dart:convert';
import 'package:nock/nock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:flutter_application_1/providers/stat_provider.dart';
import 'package:flutter_application_1/laras_quizz_app.dart';

void main() {

  setUpAll(() {
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });


  callsMadeUponLoadingHomeScreen(){
    //call made upon initialization of the statsProvider
        nock("https://dad-quiz-api.deno.dev").get("/topics")
      .reply(200, [{"id": 1, "name": "Topic 1", "question_path": ""}, 
                   {"id": 2, "name": "Topic 2", "question_path": ""}]);
      //call made to deduce topic with least points
       nock("https://dad-quiz-api.deno.dev").get("/topics")
      .reply(200, [{"id": 1, "name": "Topic 1", "question_path": ""},
                  {"id": 2, "name": "Topic 2", "question_path": ""}]); 
  }


 

  testWidgets("When selecting a correct or wrong answer leads to corresponding feedback", (tester) async {
  callsMadeUponLoadingHomeScreen();
  final data = {"answer": "6"}; 
  final jsonData = jsonEncode(data); 
     //topic provider initiailizer is set
       nock("https://dad-quiz-api.deno.dev").get("/topics")
      .reply(200, [{"id": 1, "name": "Topic 1", "question_path": ""}, 
                  {"id": 2, "name": "Topic 2", "question_path": ""}]);
      //topic fetched to update the current question state for generic practice
      nock("https://dad-quiz-api.deno.dev").get("/topics/1/questions")
      .reply(200, {
                    "id":1,
                    "question":"What is the outcome of 3 + 3?",
                    "options":["6"],
                    "answer_post_path":""
                  });
     //make the post request with the reply             
    nock("https://dad-quiz-api.deno.dev")
  .post('/topics/1/questions/1/answers',jsonData)
  .reply(200,{"correct": true});
  //update the question once more 
    nock("https://dad-quiz-api.deno.dev").get("/topics/1/questions")
      .reply(200, {
                    "id":6,
                    "question":"Another question?",
                    "options":["some"],
                    "answer_post_path":""
                  });

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance(); 

    await tester.pumpWidget(ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)], 
        child: LarasQuizzApp()));

    await tester.pumpAndSettle();

    expect(find.text("Topic 1"), findsOneWidget);

    await tester.tap(find.text('Topic 1'));
    await tester.pumpAndSettle();

    expect(find.text('What is the outcome of 3 + 3?'), findsOneWidget);
    expect(find.text("6"), findsOneWidget);
  
    await tester.tap(find.text('6'));
  
    await tester.pumpAndSettle();
   
     expect(find.text("Your answer was correct.\n"), findsOneWidget);
  });


}