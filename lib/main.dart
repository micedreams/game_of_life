import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_of_life/game_of_life_bloc.dart';
import 'package:game_of_life/game_of_life_event.dart';
import 'package:game_of_life/game_of_life_view.dart';
import 'game_of_life.dart';

void main() async {
  runApp(BLoCPatternFlutter());
}

class BLoCPatternFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Game of life",
      debugShowCheckedModeBanner: false,
      home: BlocProvider<GameOfLifeBloc>(
        create: (context) => GameOfLifeBloc()..add(ResetEvent()),
        child: GameOfLifeView(),
      ),
    );
  }
}

class Vanilla extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Game of life",
      debugShowCheckedModeBanner: false,
      home: GameOfLife(),
    );
  }
}
