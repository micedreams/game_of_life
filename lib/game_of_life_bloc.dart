import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_of_life/game_of_life_event.dart';
import 'package:game_of_life/game_of_life_functions.dart';
import 'package:game_of_life/game_of_life_state.dart';

class GameOfLifeBloc extends Bloc<GameOfLifeEvent, GameOfLifeState> {
  final rows = 10;
  final function = GameOfLifeFunctions();
  List<String> arr = List.filled(100, "", growable: false);

  GameOfLifeBloc()
      : super(GameOfLifeState(
          arr: List.filled(100, "", growable: false),
          rows: 10,
        )) {
    on<ResetEvent>((event, emit) {
      arr = function.onReset(arr);
      emit(GameOfLifeState(arr: arr, rows: rows));
    });
    on<NewStateEvent>((event, emit) {
      arr = function.setNewValues(arr, rows);
      emit(GameOfLifeState(arr: arr, rows: rows));
    });
    on<ClickEvent>((event, emit) {
      arr = function.onClick(event.index, arr);
      emit(GameOfLifeState(arr: arr, rows: rows));
    });
  }
}
