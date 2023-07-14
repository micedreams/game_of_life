import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_of_life/game_of_life_bloc.dart';
import 'package:game_of_life/game_of_life_event.dart';
import 'package:game_of_life/game_of_life.dart';

void main() async {
  runApp(const GOL());
}

class GOL extends StatelessWidget {
  const GOL({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Game of life",
      debugShowCheckedModeBanner: false,
      home: BlocProvider<GameOfLifeBloc>(
        create: (context) => GameOfLifeBloc()..add(ResetEvent()),
        child: const GameOfLife(),
      ),
    );
  }
}
