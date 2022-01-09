import 'package:flutter/material.dart';
import 'package:game_of_life/game_of_life_functions.dart';

class GameOfLife extends StatefulWidget {
  static const routeName = '/Home';

  @override
  State<StatefulWidget> createState() => new _GameOfLifeState();
}

class _GameOfLifeState extends State<GameOfLife> {
  GameOfLifeFunctions world = new GameOfLifeFunctions();
  var arr = new List.filled(100, "", growable: false);
  late Stream _bids;

  @override
  initState() {
    arr = world.randomLife();
    super.initState();
  }

  initial() async {
    _bids = (() async* {
      await Future<void>.delayed(Duration(seconds: 1));
      setState(() {
        arr = world.setValues(arr);
      });
      await Future<void>.delayed(Duration(seconds: 1));
    })();
  }

  @override
  Widget build(context) {
    initial();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Game of life"),
        ),
        body: StreamBuilder(
            stream: _bids,
            builder: (context, snapshot) {
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
