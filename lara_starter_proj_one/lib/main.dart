import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/laras_quizz_app.dart'; 
import 'package:flutter_application_1/providers/stat_provider.dart';



main() async{
  WidgetsFlutterBinding.ensureInitialized();

   final prefs = await SharedPreferences.getInstance();
   
   runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
    child: const LarasQuizzApp(),
    ));
}