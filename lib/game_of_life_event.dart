abstract class GameOfLifeEvent {}

class ResetEvent extends GameOfLifeEvent {
  final int? index;
  ResetEvent({this.index});
}

class SetEvent extends GameOfLifeEvent {}

class ClickEvent extends GameOfLifeEvent {
  final int index;
  ClickEvent(this.index);
}
