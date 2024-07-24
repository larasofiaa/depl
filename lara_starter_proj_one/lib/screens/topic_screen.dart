import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_1/screens/util/screen_wrapper.dart';
import 'package:flutter_application_1/widgets/question_list.dart';





class TopicScreen extends ConsumerWidget {
  final int topicId;
  const TopicScreen(this.topicId);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenWrapper(
      Center(
        child: Column(
          children: [QuestionList(topicId)]
      ),
     ), ElevatedButton(onPressed: ()=> context.go("/topics"), child: const Text("Topics")));
  }
} 

