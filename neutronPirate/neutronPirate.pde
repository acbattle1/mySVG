Pirate p;
float x;
float y;

void setup () {
  size ( 800, 800);
  
}

void draw () {
  background (180);
 circle(400, 400, 150);
 fill (#b062f0);
}

void keyPressed() {
    switch(key) {
  case 'a':
    p.moveLeft();
    break;
  case 's':
    p.moveDown();
    break;
  case 'w':
    p.moveUp();
    break;
  case 'd':
    p.moveRight();
    break;
  case '1':
    p.setSpeed(4);
    break;
  case '2':
    p.setSpeed(20);
    break;
  case '3':
    p.shield();
    break;
  case '4':
    p.unShield();
    break; 
  case '5':
    p.die();
    break;
    }
}  
