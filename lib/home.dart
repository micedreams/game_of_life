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
  var arr = new List(100);
  int rows;
  int total;
  var rng = new Random();
  int numOfLiveCells;
  int count;

  @override
  initState() {
    rows = sqrt(arr.length).toInt();
    total = arr.length;
    numOfLiveCells = rng.nextInt(total);
    for (var i = 0; i < total; i++) {
      arr[i] = "";
    }
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

  @override
  Widget build(context) {
    Stream<GameOfLife> _bids = (() async* {
      await Future<void>.delayed(Duration(seconds: 1));
      setValues();
      await Future<void>.delayed(Duration(seconds: 1));
    })();

    return StreamBuilder<GameOfLife>(
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
                child: new Card(
                  color: Colors.blue.shade200,
                  child: Center(
                    child: RaisedButton(
                      color: Colors.blue.shade200,
                      onPressed: () {
                        setValues();
                        arr[index] = "X";
                      },
                      onLongPress: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(Home.routeName);
                      },
                      child: Text(arr[index]),
                    )
                  )
                ),
              );
            }),
          )),
        );
      });
  }
}
