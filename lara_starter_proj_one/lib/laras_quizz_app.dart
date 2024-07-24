import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/router.dart';

class LarasQuizzApp extends StatelessWidget {
  const LarasQuizzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
