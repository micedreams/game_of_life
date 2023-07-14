import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_of_life/game_of_life_event.dart';
import 'package:game_of_life/game_of_life_functions.dart';
import 'package:game_of_life/game_of_life_state.dart';

class GameOfLifeBloc extends Bloc<GameOfLifeEvent, GameOfLifeState> {
  GameOfLifeFunctions function = GameOfLifeFunctions();
  var arr = List.filled(100, "", growable: false);
  final rows = 10;
  GameOfLifeBloc()
      : super(GameOfLifeState(
            arr: List.filled(100, "", growable: false), rows: 10)) {
    on<ResetEvent>((event, emit) {
      var dispose = function.onReset();
      arr = dispose;
      emit(GameOfLifeState(arr: arr, rows: rows));
    });
    on<NewStateEvent>((event, emit) {
      var newState = function.setNewValues(arr);
      arr = newState;
      emit(GameOfLifeState(arr: arr, rows: rows));
    });
    on<ClickEvent>((event, emit) {
      arr = function.onClick(event.index);
      emit(GameOfLifeState(arr: arr, rows: rows));
    });
  }
}
