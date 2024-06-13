import 'package:flutter/material.dart';
import 'package:project_01/View/Screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project One',
      theme: ThemeData(
        textTheme: const TextTheme(
          // Text style for text fields' input.
          titleMedium: TextStyle(color: Colors.black, fontSize: 18),
        ),
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.white,
          background: Colors.white,
          // Defines colors like cursor color of the text fields.
          primary: Colors.black,
        ),
        // Decoration theme for the text fields.
        
      ),      home: const SplashScreen(),
    );
  }
}
