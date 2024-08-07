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


testWidgets("Checking correct answer count for individual topics from SharedPrefs", (tester) async {
  callsMadeUponLoadingHomeScreen();
     //topic provider initiailizer is set
       nock("https://dad-quiz-api.deno.dev").get("/topics")
      .reply(200, [{"id": 1, "name": "Topic 1", "question_path": ""}, 
                  {"id": 2, "name": "Topic 2", "question_path": ""}]);
      //topic fetched to update the current question state for generic practice - given topic 2 has fewer replies, this should be called
      nock("https://dad-quiz-api.deno.dev").get("/topics/2/questions")
      .reply(200, {
                    "id":1,
                    "question":"What is the outcome of 3 + 3?",
                    "options":["6"],
                    "answer_post_path":""
                  });


    SharedPreferences.setMockInitialValues({"flutter.stats":"[{\"total\":2,\"correct\":1,\"topicId\":1},{\"total\":4,\"correct\":0,\"topicId\":2}]"});
    final prefs = await SharedPreferences.getInstance(); 

    await tester.pumpWidget(ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)], 
        child: LarasQuizzApp()));

    await tester.pumpAndSettle();

    expect(find.text("Go to statistics"), findsOneWidget);
  

  await tester.tap(find.text("Go to statistics"));
  await tester.pumpAndSettle();
  expect(find.text("Topic 1 : \n1 correct, 2 in total"), findsOneWidget);    
  expect(find.text("Topic 2 : \n0 correct, 4 in total"), findsOneWidget);    
  
  });

}