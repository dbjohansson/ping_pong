part of ping_pong;

class Board {
  // squash court
  static const num START_X = 150;
  static const num START_Y = 150;
  static const num BALL_R = 8;
  static const num RACKET_W = 75;
  static const num RACKET_H = 10;

  Timer timer;

  CanvasElement canvas;
  CanvasRenderingContext2D context;

  num width;
  num height;

  num dx = 2;
  num dy = 4;

  Ball ball;
  Racket racket;

  Board(this.canvas) {
    context = canvas.getContext("2d");
    width = canvas.width;
    height = canvas.height;
  }

  void init() {
    ball = new Ball(this, START_X, START_Y, BALL_R);
    racket = new Racket(this, width/2, height-RACKET_H, RACKET_W, RACKET_H);
    // redraw every 12 ms
    timer = new Timer.periodic(const Duration(milliseconds: 12),
        (t) => redraw());
  }

  void clear() {
    context.clearRect(0, 0, width, height);
  }

  void redraw() {
    clear();
    ball.draw();
    //move the racket if the left or the right key is currently pressed
    if (racket.rightDown) { racket.x += 5;
    } else if (racket.leftDown) racket.x -= 5;
    racket.draw();
    if (ball.x + dx > width || ball.x + dx < 0) {
      dx = -dx;
    }
    if (ball.y + dy < 0) {
      dy = -dy;
    } else if (ball.y + dy > height) {
      if (ball.x > racket.x && ball.x < racket.x + racket.w) {
        dy = -dy;
      } else {
        //game over, so stop the animation
        timer.cancel();
      }
    }
    ball.x += dx;
    ball.y += dy;
  }

}
