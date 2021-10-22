import 'package:flutter/material.dart';
import 'dart:math';
import 'game_of_life.dart';

class Home extends StatefulWidget {
  static const routeName = '/Home';

  @override
  State<StatefulWidget> createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  GameOfLife world = new GameOfLife();
  var arr = new List.filled(100, "", growable: false);
  late int rows;
  late int total;
  var rng = new Random();
  late int numOfLiveCells;
  late int count;

  @override
  initState() {
    rows = sqrt(arr.length).toInt();
    total = arr.length;
    numOfLiveCells = rng.nextInt(total);
    for (var i = 0; i < numOfLiveCells; i++) {
      var rando = rng.nextInt(total);
      if (arr[rando] == "") {
        arr[rando] = "X";
      }
    }
    super.initState();
  }

  setValues() {
    setState(() {});
    world.setValues(arr);
  }

  reset() {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(Home.routeName);
  }

  @override
  Widget build(context) {
    Stream _bids = (() async* {
      await Future<void>.delayed(Duration(seconds: 1));
      setValues();
      await Future<void>.delayed(Duration(seconds: 1));
    })();

    return StreamBuilder(
        stream: _bids,
        builder: (context, snapshot) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text("Game of life"),
            ),
            body: new Container(
                child: GridView.count(
              crossAxisCount: rows,
              children: List.generate(total, (index) {
                return new GridTile(
                  child: InkWell(
                    onTap: () {
                      setValues();
                      arr[index] = "X";
                    },
                    onLongPress: () {
                      reset();
                    },
                    child: new Card(
                        color: Colors.blue.shade200,
                        child: Center(
                            child: Text(arr[index]))),
                  ),
                );
              }),
            )),
          );
        });
  }
}
