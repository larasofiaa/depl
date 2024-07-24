import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_1/providers/stat_provider.dart';
import 'package:flutter_application_1/providers/generic_flag_provider.dart';
import 'package:flutter_application_1/providers/question_provider.dart';
import 'package:flutter_application_1/widgets/topics_list.dart';
import 'package:flutter_application_1/screens/util/screen_wrapper.dart';



class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //make sure the stats provider is inialized before it is used in updateToCurrentQuestion
    

 return FutureBuilder<int>(
      future: ref.watch(statsProvider.notifier).deduceTopicWithLeastPoints(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final topicId = snapshot.data;
          return ScreenWrapper(
           const  Center(
              child:  Column(
                children: [Text("Welcome to Lara's Quizz App. \n"
                "With this application you can practice your knowledge on the topics shown below. \n"
                "You can see your statistics if you click on the top right button and find out which topics you already know well.\n"
                "You can practice questions by topic (just click on the respective one) or you can practice the topic(s) you know the least well with the generic practice option. \n"), 
                TopicList()],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref.watch(genericFlagProvider.notifier).setToGeneric();
                ref.watch(questionProvider.notifier).updateToCurrentQuestion(topicId!);
                context.go("/topics/$topicId/questions");
              },
              child: const Text("Generic Practice"),
            ),
          );
        } else {
          return const CircularProgressIndicator(); // Loading indicator while waiting for the future
        }
      },
    );
 
  }
}