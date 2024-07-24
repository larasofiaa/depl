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

  testWidgets("No topics available'", (tester) async {
    callsMadeUponLoadingHomeScreen(); 
    //Call made for topic provider Initializer
       nock("https://dad-quiz-api.deno.dev").get("/topics")
      .reply(200, []);
      //call made to update the current question for generic practice
      nock("https://dad-quiz-api.deno.dev").get("/topics/*/questions")
      .reply(200, {});

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance(); 

    await tester.pumpWidget(ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)], 
        child: LarasQuizzApp()));

    await tester.pumpAndSettle();

    expect(find.text("No topics available"), findsOneWidget);
  });

   testWidgets("Showing topics from API'", (tester) async {
   callsMadeUponLoadingHomeScreen();
   //Call made for topic provider Initializer
       nock("https://dad-quiz-api.deno.dev").get("/topics")
      .reply(200, [{"id": 1, "name": "Topic 1", "question_path": ""}, 
                  {"id": 2, "name": "Topic 2", "question_path": ""}]);
   //call made to update the current question for generic practice
      nock("https://dad-quiz-api.deno.dev").get("/topics/*/questions")
      .reply(200, {});

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance(); 

    await tester.pumpWidget(ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)], 
        child: LarasQuizzApp()));

    await tester.pumpAndSettle();

    expect(find.text("Topic 1"), findsOneWidget);
    expect(find.text("Topic 2"), findsOneWidget);
  });

     testWidgets("When selecting a topic, the question and answer options are shown", (tester) async {
   callsMadeUponLoadingHomeScreen();
   //topic provider initiailizer is set
       nock("https://dad-quiz-api.deno.dev").get("/topics")
      .reply(200, [{"id": 1, "name": "Topic 1", "question_path": ""}, 
                  {"id": 2, "name": "Topic 2", "question_path": ""}]);
    //topic fetched to update the current question state for generic practice
      nock("https://dad-quiz-api.deno.dev").get("/topics/1/questions")
      .reply(200, {
                    "id":1,
                    "question":"What is the outcome of 3 + 3?",
                    "options":["100","49","200","95","6"],
                    "answer_post_path":"/topics/1/questions/4/answers"
                  });

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance(); 

    await tester.pumpWidget(ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)], 
        child: LarasQuizzApp()));

    await tester.pumpAndSettle();

    expect(find.text("Topic 1"), findsOneWidget);
    expect(find.text("Topic 2"), findsOneWidget);

    await tester.tap(find.text('Topic 1'));
    await tester.pumpAndSettle();

    expect(find.text('What is the outcome of 3 + 3?'), findsOneWidget);
    expect(find.text("100"), findsOneWidget);
    expect(find.text("49"), findsOneWidget);
    expect(find.text("200"), findsOneWidget);
    expect(find.text("95"), findsOneWidget);
    expect(find.text("6"), findsOneWidget);
  });

}