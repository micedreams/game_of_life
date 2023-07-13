import 'package:flutter/material.dart';
import 'package:game_of_life/game_of_life_functions.dart';

class GameOfLife extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GameOfLifeState();
}

class _GameOfLifeState extends State<GameOfLife> {
  GameOfLifeFunctions world = GameOfLifeFunctions();
  var arr = List.filled(100, "", growable: false);

  @override
  initState() {
    arr = world.randomLife();
    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Game of life"),
        ),
        body: FutureBuilder(future: (() async {
          await Future<void>.delayed(const Duration(seconds: 1));
          setState(() {
            arr = world.setNewValues(arr);
          });
          await Future<void>.delayed(const Duration(seconds: 1));
        })(), builder: (context, snapshot) {
          return GridView.count(
            crossAxisCount: 10,
            children: List.generate(100, (index) {
              return InkWell(
                onTap: () => setState(() {
                  arr = world.onClick(index);
                }),
                onLongPress: () => setState(() {
                  arr = world.onReset();
                }),
                child: Card(child: Center(child: Text(arr[index]))),
              );
            }),
          );
        }));
  }
}
