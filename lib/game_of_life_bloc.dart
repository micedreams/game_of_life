import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_of_life/game_of_life_event.dart';
import 'package:game_of_life/game_of_life_functions.dart';
import 'package:game_of_life/game_of_life_state.dart';

class GameOfLifeBloc extends Bloc<GameOfLifeEvent, GameOfLifeState> {
  final rows = 10;
  final function = GameOfLifeFunctions();
  List<bool> arr = List.filled(100, false, growable: false);

  GameOfLifeBloc() : super(GameOfLifeState()) {
    on<ResetEvent>((event, emit) {
      arr = function.onReset(arr, index: event.index);
      emit(GameOfLifeState(arr: arr, rows: rows));
    });
    on<SetEvent>((event, emit) {
      arr = function.onSet(arr, rows);
      emit(GameOfLifeState(arr: arr, rows: rows));
    });
    on<ClickEvent>((event, emit) {
      arr = function.onClick(arr, event.index);
      emit(GameOfLifeState(arr: arr, rows: rows));
    });
  }
}
