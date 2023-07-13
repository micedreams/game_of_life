import 'dart:math';

class GameOfLifeFunctions {
  var arr = List.filled(100, "", growable: false);
  int rows = 10;
  int total = 100;
  var rng = Random();
  late int numOfLiveCells = rng.nextInt(total);
  late int count;

  randomLife() {
    for (var i = 0; i < numOfLiveCells; i++) {
      var rando = rng.nextInt(total);
      if (arr[rando] == "") {
        arr[rando] = "X";
      }
    }
    return arr;
  }

  setNewValues(arr) {
    int total = arr.length;
    for (var i = 0; i < total; i++) {
      count = _calculateLive(i, arr);
      if (count == 3) {
        arr[i] = "X";
      }
      if (count < 2 || count > 3) {
        arr[i] = "";
      }
    }
    return arr;
  }

  onClick(index) {
    arr[index] = "X";
    return arr;
  }

  onReset() {
    arr = List.filled(100, "", growable: false);
    arr = randomLife();
    return arr;
  }

  _liveCells(value, i, arr) {
    int rows = sqrt(arr.length).toInt();
    int total = arr.length;
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

  _calculateLive(i, arr) {
    int rows = sqrt(arr.length).toInt();
    num? count = 0;
    count += _liveCells(i + (1), i, arr);
    count += _liveCells(i + (rows + 1), i, arr);
    count += _liveCells(i + (rows - 1), i, arr);
    count += _liveCells(i + (rows), i, arr);
    count += _liveCells(i - (1), i, arr);
    count += _liveCells(i - (rows + 1), i, arr);
    count += _liveCells(i - (rows - 1), i, arr);
    count += _liveCells(i - (rows), i, arr);
    return count;
  }
}
