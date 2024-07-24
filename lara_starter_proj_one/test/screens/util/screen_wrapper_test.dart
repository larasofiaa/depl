import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_1/screens/util/screen_wrapper.dart';
main(){

testWidgets("Find the Texts expected in the ScreenWrapper with the 'onlyMainWidget' constructor", (tester) async {

  await tester.pumpWidget(const MaterialApp(home: ProviderScope(child: ScreenWrapper.onlyMainWidget(Text("Test")))));

  expect(find.text("Lara's Quizz App"), findsOneWidget);
  expect(find.text("Go to statistics"), findsOneWidget);
});

testWidgets("Find the Texts expected in the ScreenWrapper with the constructor that takes an optional widget", (tester) async {

  await tester.pumpWidget(const MaterialApp(home: ProviderScope(child: ScreenWrapper(Text("Test"), Text("Additional Text")))));

  expect(find.text("Lara's Quizz App"), findsOneWidget);
  expect(find.text("Additional Text"), findsOneWidget);
});

}