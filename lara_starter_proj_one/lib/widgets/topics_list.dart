import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/feedback_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_application_1/providers/topic_provider.dart';
import 'package:flutter_application_1/providers/generic_flag_provider.dart';
import 'package:flutter_application_1/providers/question_provider.dart';

class TopicList extends ConsumerWidget {
  const TopicList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = ref.watch(topicProvider);
    if(topics.isEmpty){
      return const Center(child: Text("No topics available")); 
    }else{
 final items = List<Widget>.from(topics.map(
      (topic) => ListTile(
        title: Column(children: [ ElevatedButton(onPressed:() {
            ref.watch(questionProvider.notifier).updateToCurrentQuestion(topic.id);
            ref.watch(feedbackProvider.notifier).resetToEmpty();
            ref.watch(genericFlagProvider.notifier).resetToGeneral(); ;
       return context.go("/topics/${topic.id}/questions"); } , child: Text(topic.name)),]),
      ),
    ));
    return Expanded(child: ListView(children: items));
    }
   
  }
}