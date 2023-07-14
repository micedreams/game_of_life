import 'dart:math';

class GameOfLifeFunctions {
  List<String> randomLife(List<String> arr) {
    final rng = Random();
    final total = arr.length;
    final numOfLiveCells = rng.nextInt(total);

    for (var i = 0; i < numOfLiveCells; i++) {
      final rando = rng.nextInt(total);
      
      if (arr[rando] == "") {
        arr[rando] = "X";
      }
    }

    return arr;
  }

  List<String> setNewValues(List<String> arr, int rows) {
    int total = arr.length;

    for (var i = 0; i < total; i++) {
      final count = _calculateLive(i, arr, rows);
      if (count == 3) {
        arr[i] = "X";
      }
      if (count < 2 || count > 3) {
        arr[i] = "";
      }
    }

    return arr;
  }

  List<String> onClick(int index, List<String> arr) {
    arr[index] = "X";

    return arr;
  }

  List<String> onReset(List<String> arr) => randomLife(arr);

  int _liveCells(int value, int i, List arr, int rows) {
    int total = arr.length;

    late final int count;

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

  int _calculateLive(int i, List arr, int rows) {
    int count = 0;

    count += _liveCells(i + (1), i, arr, rows);
    count += _liveCells(i + (rows + 1), i, arr, rows);
    count += _liveCells(i + (rows - 1), i, arr, rows);
    count += _liveCells(i + (rows), i, arr, rows);
    count += _liveCells(i - (1), i, arr, rows);
    count += _liveCells(i - (rows + 1), i, arr, rows);
    count += _liveCells(i - (rows - 1), i, arr, rows);
    count += _liveCells(i - (rows), i, arr, rows);

    return count;
  }
}
