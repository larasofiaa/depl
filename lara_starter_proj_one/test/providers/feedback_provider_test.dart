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

testWidgets("Check Generic Practice", (tester) async {
  callsMadeUponLoadingHomeScreen();
     //topic provider initiailizer is set
       nock("https://dad-quiz-api.deno.dev").get("/topics")
      .reply(200, [{"id": 1, "name": "Topic 1", "question_path": ""}, 
                  {"id": 2, "name": "Topic 2", "question_path": ""}]);
      //topic fetched to update the current question state for generic practice
      nock("https://dad-quiz-api.deno.dev").get("/topics/2/questions")
      .reply(200, {
                    "id":1,
                    "question":"Question from topic 2?",
                    "options":["A"],
                    "answer_post_path":""
                  });


    SharedPreferences.setMockInitialValues({"flutter.stats":"[{\"total\":2,\"correct\":1,\"topicId\":1},{\"total\":4,\"correct\":0,\"topicId\":2}]"});
    final prefs = await SharedPreferences.getInstance(); 

    await tester.pumpWidget(ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)], 
        child: LarasQuizzApp()));

    await tester.pumpAndSettle();

  expect(find.text("Generic Practice"), findsOneWidget);
  

  await tester.tap(find.text("Generic Practice"));
  await tester.pumpAndSettle();

  expect(find.text("Question from topic 2?"), findsOneWidget);    
  expect(find.text("A"), findsOneWidget);    
  });

}