
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/topic_screen.dart';
import 'package:flutter_application_1/screens/statistics_screen.dart';
 
  final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) {
      return const HomeScreen();
    }),
    GoRoute(
        path: '/topics',
        builder: (context, state) 
           {
      return const HomeScreen();
    }),
    GoRoute(path: '/stats', 
          builder: (context, state) {
      return const StatisticsScreen();
    } ),
    GoRoute(
     path: '/topics/:topicId/questions',
        builder: (context, state) =>
            TopicScreen(int.parse(state.pathParameters['topicId']!))),
  ],
);