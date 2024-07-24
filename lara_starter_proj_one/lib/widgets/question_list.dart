import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_application_1/providers/feedback_provider.dart';
import 'package:flutter_application_1/services/question_api.dart';
import 'package:flutter_application_1/providers/question_provider.dart';
import 'package:flutter_application_1/providers/stat_provider.dart';
import 'package:flutter_application_1/providers/generic_flag_provider.dart';

class QuestionList extends ConsumerWidget {
  final int topicId; 

  QuestionList(this.topicId); 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    return Consumer(builder: (context, ref, child) {
      final question = ref.watch(questionProvider);
   
    //check whether answer is empty or
   if(ref.watch(feedbackProvider) !="Your answer was correct.\n"){

        final questionWidget = Center(child: 
        Column(children: 
        [Text(ref.watch(feedbackProvider)), Text(question.question)])); 
        final items = List<Widget>.from(question.options.map(
          (option) => ListTile(
            title: Column(
              children: [Center (child: ElevatedButton(
                  onPressed: ()async{
                  await checkAnswer(topicId, question.id, option, ref); 
                  context.go("/topics/$topicId/questions");
                  },
                  child: Text(option),
                ),)
              ],
            ),
          ),
        ));
        items.insert(0,questionWidget); 
        if(question.imageUrl!= null){
          items.insert(1, Center(child: Image(
          image: NetworkImage(question.imageUrl!),
        )));
        }
        return Expanded(child: ListView(children: items));
    }else{
      return Center(child: Column(children: [Text(ref.read(feedbackProvider)), 
      ElevatedButton(onPressed: ()async{
            ref.watch(feedbackProvider.notifier).resetToEmpty();

          if(ref.watch(genericFlagProvider)){
            final nextGenericQuestion = await ref.watch(statsProvider.notifier).deduceTopicWithLeastPoints(); 
            //Here we need to make sure that the nextGenericQuestion is not a future provider anymore...
           ref.watch(questionProvider.notifier).updateToCurrentQuestion(nextGenericQuestion); 
            context.go("/topics/$nextGenericQuestion/questions"); 
            }else{
              ref.watch(questionProvider.notifier).updateToCurrentQuestion(topicId); 
              context.go("/topics/$topicId/questions");
            }
            },

      child: ref.watch(genericFlagProvider) ? Text("Fetch another question for generic practice.") :  Text("Fetch another question from this topic.") 
      )
      ]));
     
    }
      }
    );
  }
}
 
 
Future<void> checkAnswer( int topicId, int questionId, String option, WidgetRef ref) async{
   final  questionApi = QuestionApi(); 
   final response = await questionApi.postAnswer(topicId, questionId, option); 
  
 if(response.correct){
   ref.watch(feedbackProvider.notifier).updateToCorrect();
   ref.watch(statsProvider.notifier).incrementSuccessCount(topicId);
   ref.watch(questionProvider.notifier).updateToCurrentQuestion(topicId); 
 }else{
    ref.watch(feedbackProvider.notifier).updateToWrong();
    ref.watch(questionProvider.notifier).removeAnswerFromOptions(option);
    ref.watch(statsProvider.notifier).incrementFailureCount(topicId);
 }
 }

