class Player {
  float x;
  float y;
  int direction;

  Player(float x, float y, int direction) {
    this.x = x;
    this.y = y;
    this.direction = direction;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    pushStyle();
    rectMode(CENTER);
    fill(#00ff00);
    noStroke();
    switch(direction) {
    case 0:
      rotate(0);
      break;
    case 1:
      rotate(PI/2);
      break;
    case 2:
      rotate(PI);
      break;
    case 3:
      rotate(PI*3/2);
      break;
    }

    rect(0, -20, 10, 40);
    rect(0, 0, 20, 10);
    popStyle();
    popMatrix();
  }

  void rotateLeft() {
    direction = direction - 1;
    if (direction < 0) {
      direction = 3;
    }
  }

  void rotateRight() {
    direction = direction + 1;
    if (direction > 3) {
      direction = 0;
    }
  }
}
