import 'dart:math';

class GameOfLifeFunctions {
  List<bool> onSet(List<bool> arr, int rows) {
    int total = arr.length;

    for (var i = 0; i < total; i++) {
      final count = _calculateLive(i, arr, rows);
      if (count == 3) {
        arr[i] = true;
      }
      if (count < 2 || count > 3) {
        arr[i] = false;
      }
    }

    return arr;
  }

  List<bool> onClick(List<bool> arr, int index) {
    arr[index] = true;

    return arr;
  }

  List<bool> onReset(List<bool> arr, {int? index}) {
    _addLife(arr);

    if (null != index && !arr[index]) {
      arr[index] = true;
    }

    return arr;
  }

  int _liveCells(int value, int i, List<bool> arr, int rows) {
    int total = arr.length;

    late final int count;

    if (value >= 0 && value < total && arr[value]) {
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

  int _calculateLive(int i, List<bool> arr, int rows) {
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

  List<bool> _addLife(List<bool> arr) {
    final rng = Random();
    final total = arr.length;
    final numOfLiveCells = rng.nextInt(total);

    for (var i = 0; i < numOfLiveCells; i++) {
      final rando = rng.nextInt(total);

      if (!arr[rando]) {
        arr[rando] = true;
      }
    }

    return arr;
  }
}
