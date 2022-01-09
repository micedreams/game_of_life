import 'package:flutter/material.dart';
import 'game_of_life.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Game of life",
      home: GameOfLife(),
    );
  }
}
