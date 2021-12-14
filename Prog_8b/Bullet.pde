class Bullet {
  float x;
  float y;
  int direction;
  Player p;

  Bullet (float x, float y, int direction) {
    this.x = x;
    this.y = y;
    this.direction = direction;
    this.p = new Player (x, y, 0);
  }
  void display () {
    fill (#fc2c03);
    ellipse (x, y, 10, 10);
    switch (direction) {
    case 0:
      y = y - 4;
      break;
    case 1:
      x = x +4;
      break;
    case 2:
      y = y + 4;
      break;
    case 3:
      x = x - 4;
      break;
    }
  }
}
