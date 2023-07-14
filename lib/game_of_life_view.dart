import 'package:flutter/material.dart';

class GameOfLifeView extends StatelessWidget {
  const GameOfLifeView({
    super.key,
    required this.row,
    required this.total,
    required this.condition,
    required this.set,
    required this.onTap,
    required this.reset,
  });

  final int row;
  final int total;
  final bool Function(int index) condition;
  final Future<void> set;
  final void Function(int index) onTap;
  final void Function(int index) reset;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: set,
      builder: (context, snapshot) => Scaffold(
        body: GridView.count(
          crossAxisCount: row,
          children: List.generate(
            total,
            (index) {
              return InkWell(
                onTap: () => onTap(index),
                onLongPress: () => reset(index),
                child: Card(
                  color: condition(index)
                      ? const Color.fromARGB(255, 54, 81, 24)
                      : const Color.fromARGB(255, 239, 194, 194),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
