import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_application_1/providers/feedback_provider.dart';
import 'package:flutter_application_1/providers/generic_flag_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenWrapper extends ConsumerWidget {
  final Widget widget;
  final Widget optionalWidget;
  const ScreenWrapper(this.widget,this.optionalWidget,  {super.key});
  const ScreenWrapper.onlyMainWidget(this.widget, {super.key}): optionalWidget = const Text(" ") ;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lara's Quizz App"),
        actions:[optionalWidget, 
            ElevatedButton(onPressed: (){
             ref.watch(genericFlagProvider.notifier).resetToGeneral(); 
             ref.watch(feedbackProvider.notifier).resetToEmpty(); 
             context.go("/stats");}, 
             child: const Text("Go to statistics")),
             ]), 
             body:  widget,
    );
  }
}
