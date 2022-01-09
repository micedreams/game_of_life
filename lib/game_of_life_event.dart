abstract class GameOfLifeEvent {}

class ResetEvent extends GameOfLifeEvent {}

class NewStateEvent extends GameOfLifeEvent {}

class ClickEvent extends GameOfLifeEvent {
  final int index;
  ClickEvent(this.index);
}
