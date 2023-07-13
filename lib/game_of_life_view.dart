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
  @override
  Widget build(context) {
    final bloc = BlocProvider.of<GameOfLifeBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Game of life"),
        ),
        body: BlocBuilder<GameOfLifeBloc, GameOfLifeState>(
          builder: (context, state) {
            return FutureBuilder(future: (() async {
              await Future<void>.delayed(const Duration(seconds: 1));
              bloc.add(NewStateEvent());
              await Future<void>.delayed(const Duration(seconds: 1));
            })(), builder: (context, snapshot) {
              return GridView.count(
                crossAxisCount: 10,
                children: List.generate(100, (index) {
                  return InkWell(
                    onTap: () {
                      return bloc.add(ClickEvent(index));
                    },
                    onLongPress: () {
                      return bloc.add(ResetEvent());
                    },
                    child: Card(child: Center(child: Text(state.arr[index]))),
                  );
                }),
              );
            });
          },
        ));
  }
}
