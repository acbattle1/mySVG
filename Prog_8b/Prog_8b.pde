Bullet b;
Player p;



void setup() {
  size(800, 600);
  p = new Player(width/2, height/2, 0);
}

void draw() {
  background(90);
  if (b != null) { 
    b.display();
  }
  p.display();
}

void keyPressed() {
  if (key == 'a') {
    p.rotateLeft();
  }
  if (key == 'd') {
    p.rotateRight();
  }
  
  if (key == '1') {
    b = new Bullet(p.x, p.y, p.direction); 
  }
}
