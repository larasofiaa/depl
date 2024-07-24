import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_1/objects/topic.dart';
import 'package:flutter_application_1/services/topic_api.dart';

class TopicNotifier extends StateNotifier<List<Topic>> {
  final topicApi = TopicApi();
  TopicNotifier() : super([]);

  _initialize() async {
    state = await topicApi.findAll();
  }
}

final topicProvider = StateNotifierProvider<TopicNotifier, List<Topic>>((ref) {
  final tn = TopicNotifier();
  tn._initialize();
  return tn;
});

