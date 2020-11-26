import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  static const routeName = '/Home';

  @override
  State<StatefulWidget> createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  int rows = 15;
  int total;
  var rng = new Random();
  var numOfLiveCells;
  var arr = new List(1000);
  int count;

  liveCells(value, i) {
    if (value >= 0 && value < total && arr[value] == "X") {
      if (value % rows == 0 && value == (i - (rows - 1)) ||
          value % rows == 0 && value == (i + (rows + 1)) ||
          value % rows == 0 && value == (i + 1) ||
          value % rows == (rows - 1) && value == (i - (rows + 1)) ||
          value % rows == (rows - 1) && value == (i + (rows - 1)) ||
          value % rows == (rows - 1) && value == (i - 1)) {
        count = 0;
      } else {
        count = 1;
      }
    } else {
      count = 0;
    }
    return count;
  }

  calculateLive(i) {
    int count = 0;
    count += liveCells(i + (1), i);
    count += liveCells(i + (rows + 1), i);
    count += liveCells(i + (rows - 1), i);
    count += liveCells(i + (rows), i);
    count += liveCells(i - (1), i);
    count += liveCells(i - (rows + 1), i);
    count += liveCells(i - (rows - 1), i);
    count += liveCells(i - (rows), i);
    return count;
  }

  setValues() {
    setState(() {});

    for (var i = 0; i < total; i++) {
      count = calculateLive(i);
      if (count == 3) {
        arr[i] = "X";
      }
      if (count < 2 || count > 3) {
        arr[i] = "";
      }
    }
  }

  @override
  initState() {
    total = rows * rows;
    numOfLiveCells = total / 4;
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

  @override
  Widget build(context) {
    //setValues();

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
                  },
                  onLongPress: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(Home.routeName);
                  },
                  child: Center(
                    child: Text(arr[index]),
                  ),
                ))),
          );
        }),
      )),
    );
  }
}
