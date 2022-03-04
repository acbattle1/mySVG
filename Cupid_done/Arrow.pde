

class Arrow {
  int x;
  int y;
  boolean shot;
  boolean isvisible;


  Arrow (int x, int y) {
    this. x = x;
    this.y = y;
    this.shot=false;
    this.isvisible= true;
  }

  void display() {
    if (isvisible) {
      rect(x, y, 100, 40);
    }
    if (shot) {
      x += 4;
    }
  }
 
  void shoot() {
    shot = true;
  }
}
