import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_of_life/game_of_life_bloc.dart';
import 'package:game_of_life/game_of_life_event.dart';
import 'package:game_of_life/game_of_life_state.dart';

class GameOfLifeView extends StatefulWidget {
  const GameOfLifeView({super.key});

  @override
  State<StatefulWidget> createState() => _GameOfLifeViewState();
}

class _GameOfLifeViewState extends State<GameOfLifeView> {
  final row = 10;
  final total = 100;
  late GameOfLifeBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    bloc = BlocProvider.of<GameOfLifeBloc>(context);
  }

  @override
  Widget build(context) => Scaffold(
        body: BlocBuilder<GameOfLifeBloc, GameOfLifeState>(
          builder: (context, state) => FutureBuilder(
            future: setValues(bloc),
            builder: (context, snapshot) => GridView.count(
              crossAxisCount: row,
              children: List.generate(
                total,
                (index) => InkWell(
                  onTap: () => bloc.add(ClickEvent(index)),
                  onLongPress: () => bloc.add(ResetEvent()),
                  child: 'X' == state.arr[index]
                      ? const Card(
                          color: Color.fromARGB(255, 54, 81, 24),
                          elevation: 2.0,
                        )
                      : const Card(color: Color.fromARGB(255, 239, 194, 194)),
                ),
              ),
            ),
          ),
        ),
      );

  Future<void> setValues(GameOfLifeBloc bloc) async => Future.delayed(
        const Duration(seconds: 1),
        () => bloc.add(NewStateEvent()),
      );
}
