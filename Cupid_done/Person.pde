class Person {
  int x;
  int y;
  boolean inlove;
  PImage person;
  PImage personInLove;

  Person (int x, int y) {
    this. x = x;
    this.y = y;
    this.inlove=false;
    person = loadImage("person.png");
    personInLove = loadImage("personInLove.png");
  }
  void hit(float x, float y) {
    if (dist(x, y, this.x, this.y)<40) {
      inlove=true;
    }
  }






  void draw() {
    imageMode(CENTER);
    if (inlove) {
      image(personInLove, x, y, 50, 150);
    } else {
      image(person, x, y, 50, 150);
    }
  }
}
