import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/providers/stat_provider.dart';
import 'package:flutter_application_1/providers/topic_provider.dart';

class StatsList extends ConsumerWidget {
  const StatsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = ref.watch(topicProvider);
    final stats = ref.watch(statsProvider);
    stats.sort((a,b)=>b.correct.compareTo(a.correct)); 
    int totalAnswered = stats.fold(0, (previousValue, element) => previousValue + element.total);
    int totalCorrect = stats.fold(0, (previousValue, element) => previousValue + element.correct);
    //now we want to get the topic name...hence, we should get the topic list

 var items = List<Widget>.from(stats.map(
      (statsElement) => ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ Text("${topics.firstWhere((topic) =>topic.id ==statsElement.topicId).name} : \n" 
        "${statsElement.correct} correct, ${statsElement.total} in total",  style: TextStyle(fontSize: 16),),]),
      ),
    ));
    Widget total = Text("You have answered ${totalCorrect} questions correctly and ${totalAnswered} questions in total.\n",   style: TextStyle(fontSize: 16),);
   items.insert(0, total); 
    return Expanded(child: ListView(children: items));
    }
   
  }

