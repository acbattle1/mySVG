class Enemy {
  float x, y;
  float xVelo;
  float yVelo;

  Enemy (float x, float y ) {
    this.x = x;
    this.y = y;
    this.xVelo = 7;
    this.yVelo = random(-7, 7);
  }

  void display () {
    fill (#6a659e);
    noStroke();
    ellipse (x, y, 100, 100);
    x = x + xVelo;
    y = y - yVelo;

    if (y < 0 ) {
      y = 600;
    }
    if (x > 800) {
      x = 0;
    }
    if ( y > 600) {
      y = 0;
    }
  }
}
