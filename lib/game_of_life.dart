import 'dart:math';

class GameOfLife {
  var arr;
  var rng = new Random();
  late int count;

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

  setValues(arr) {
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
  }
}