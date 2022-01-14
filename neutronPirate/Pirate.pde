class Pirate {
float x;
float y;
float speed;

Pirate (float x, float y) {
  this.x = x;
  this.y = y;
}

void display () {
circle(400, 400, 150);
fill (#b062f0);
}

void moveUp () {
  y-=4;
}

void moveDown () {
  y += 4;
}

void moveLeft () {
  x -= 4;
}

void moveRight () {
  x += 4;
}

void setSpeed (float speed) {
  
}

void shield () { //the pirate should look different when sheilded, should be red circle
  
}

void unShield () {
  
}
void die () { //the pirate should disappearwhen dead
  
}


}
