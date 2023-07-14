import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_of_life/game_of_life_bloc.dart';
import 'package:game_of_life/game_of_life_event.dart';
import 'package:game_of_life/game_of_life_state.dart';

class GameOfLife extends StatefulWidget {
  const GameOfLife({super.key});

  @override
  State<StatefulWidget> createState() => _GameOfLifeState();
}

class _GameOfLifeState extends State<GameOfLife> {
  late GameOfLifeBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    bloc = BlocProvider.of<GameOfLifeBloc>(context);
  }

  @override
  Widget build(context) => BlocBuilder<GameOfLifeBloc, GameOfLifeState>(
        builder: (context, state) {
          final arr = state.arr;
          final total = arr.length;
          final row = (total * 0.1).floor();

          return FutureBuilder(
            future: setValues(bloc),
            builder: (context, snapshot) => Scaffold(
              body: GridView.count(
                crossAxisCount: row,
                children: List.generate(
                  total,
                  (index) => InkWell(
                    onTap: () => bloc.add(ClickEvent(index)),
                    onLongPress: () => bloc.add(ResetEvent()),
                    child: 'X' == arr[index]
                        ? const Card(
                            color: Color.fromARGB(255, 54, 81, 24),
                            elevation: 2.0,
                          )
                        : const Card(color: Color.fromARGB(255, 239, 194, 194)),
                  ),
                ),
              ),
            ),
          );
        },
      );

  Future<void> setValues(GameOfLifeBloc bloc) async => Future.delayed(
        const Duration(seconds: 1),
        () => bloc.add(NewStateEvent()),
      );
}
