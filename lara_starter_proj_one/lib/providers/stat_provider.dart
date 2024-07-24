import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_1/objects/topic.dart';
import 'package:flutter_application_1/objects/stats.dart';
import 'package:flutter_application_1/services/topic_api.dart';



class StatsNotifier extends StateNotifier<List<Stats>> {
  final SharedPreferences prefs;
  final topicApi = TopicApi();
  StatsNotifier(this.prefs) : super([]);


//change this to fetch all topics and to create one stats for each topic....and then have the list...
  _initialize()async {
    if (!prefs.containsKey("stats")) {
      List<Topic> topics = await topicApi.findAll(); 
      state = List<Stats>.from(topics.map((topic) => Stats(total: 0,correct: 0, topicId: topic.id))); 
      return;
    }
  String? statsJsonString = prefs.getString("stats");
  if (statsJsonString != null) {
   List<dynamic> statsJson = json.decode(statsJsonString);
    state = List<Stats>.from(statsJson.map((jsonData) => Stats.fromJson(jsonData)));
  }
}
  incrementFailureCount(int topicId) {
    List<Stats> newListCount=List<Stats>.from(state);
    Stats objectToUpdate = newListCount.firstWhere((stats) => stats.topicId==topicId);
     objectToUpdate.total+=1; 
     final statsOld = newListCount; 
  prefs.setString("stats", json.encode(statsOld));
  }

  incrementSuccessCount(int topicId) {
   List<Stats> newListCount=List<Stats>.from(state);
   Stats objectToUpdate = newListCount.firstWhere((stats) => stats.topicId==topicId);
     objectToUpdate.total+=1; 
     objectToUpdate.correct = objectToUpdate.correct+1; 
     final statsOld = newListCount; 
  prefs.setString("stats", json.encode(statsOld));
  }

 Future<int> deduceTopicWithLeastPoints()async {
 
  List<Stats> listForSorting=List<Stats>.from(state);
   final topics = await topicApi.findAll();
   if(listForSorting.isEmpty){
    return topics.elementAtOrNull(0)!.id;
   }else{
 listForSorting.sort((a,b)=> a.correct.compareTo(b.correct));
  return listForSorting.elementAt(0).topicId;
   }
}
 }

final statsProvider = StateNotifierProvider<StatsNotifier, List<Stats>>((ref) {
  final sn = StatsNotifier(ref.watch(sharedPreferencesProvider));
  sn._initialize();
  return sn;
});

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());