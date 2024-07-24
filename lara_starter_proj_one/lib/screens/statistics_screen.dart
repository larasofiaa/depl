import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_1/widgets/stats_list.dart';
import 'package:flutter_application_1/screens/util/screen_wrapper.dart';




class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});
  @override
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return   ScreenWrapper(
      const Center(
        child: Column(
          children: [StatsList() ],
      )),  ElevatedButton(onPressed: ()=> context.go("/topics"), child: Text("Topics"))); 
  }
} 