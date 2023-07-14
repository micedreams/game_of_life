import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'game_of_life_bloc.dart';
import 'game_of_life_event.dart';
import 'game_of_life_state.dart';
import 'game_of_life_view.dart';

class GameOfLife extends StatefulWidget {
  const GameOfLife({super.key});

  @override
  State createState() => _GameOfLifeState();
}

class _GameOfLifeState extends State<GameOfLife> {
  @override
  Widget build(context) => BlocProvider<GameOfLifeBloc>(
        create: (context) => GameOfLifeBloc()..add(ResetEvent()),
        child: BlocBuilder<GameOfLifeBloc, GameOfLifeState>(
          builder: (context, state) {
            final bloc = BlocProvider.of<GameOfLifeBloc>(context);

            final arr = state.arr;
            final total = arr.length;
            final row = (total * 0.1).floor();

            return GameOfLifeView(
              set: Future.delayed(
                const Duration(seconds: 1),
                () => bloc.add(NewStateEvent()),
              ),
              row: row,
              total: total,
              onTap: (index) => arr.contains('X')
                  ? bloc.add(ClickEvent(index))
                  : bloc.add(ResetEvent()),
              reset: (index) => () => bloc.add(ResetEvent()),
              condition: (int index) => 'X' == arr[index],
            );
          },
        ),
      );
}

