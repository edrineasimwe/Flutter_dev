import 'package:flutter/material.dart';
import 'package:myproject/myHomePage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ToDo_List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(), // Replace MaterialApp with MyHomePage
    );
  }
}
