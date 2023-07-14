import 'package:flutter/material.dart';

import 'game_of_life.dart';


void main() async {
  runApp(const GOL());
}

class GOL extends StatelessWidget {
  const GOL({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Game of life",
      debugShowCheckedModeBanner: false,
      home: GameOfLife(),
    );
  }
}
