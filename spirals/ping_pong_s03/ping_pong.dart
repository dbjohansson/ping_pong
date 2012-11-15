import 'dart:html';
import 'dart:isolate';
import 'dart:math';

part 'board.dart';
part 'ball.dart';

void main() {
  //get a reference to the canvas
  CanvasElement canvas = document.query('#canvas');
  Board board = new Board(canvas);
  Ball ball = new Ball(board, 0, 0, 10);
  //move() called every 10ms.
  new Timer.repeating(10, (t) => ball.move());
}
