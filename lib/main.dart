import 'package:flutter/material.dart';

import 'game_of_life.dart';

void main() async {
  runApp(const GOL());
}

class GOL extends StatelessWidget {
  const GOL({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      title: "Game of life",
      debugShowCheckedModeBanner: false,
      home: const GameOfLife(),
    );
  }
}
