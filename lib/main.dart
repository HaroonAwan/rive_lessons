import 'package:flutter/material.dart';
import 'package:rive_lessons/src/rive_input_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rive Lessons',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RiveInputPage(),
    );
  }
}
