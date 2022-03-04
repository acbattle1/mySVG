Arrow a;
Person people[];

void setup() {
  size(800, 800);
  a = new Arrow(100,200);
  people= new Person[4];
 people[0] = new Person(100, 450);
 people[1] = new Person(600, 600);
 people[2] = new Person(200, 500);
 people[3] = new Person(400, 700);
 
 
}
void draw() {
  background(80);
  a.display();
 
  for (Person p :people) {

    p.draw();
    p.hit(a.x,a.y);

  }

}



void keyPressed() {
  if (key == 'w') {
    a.y-=4;
  }
 
  if (key == 's') {
    a.y+=4;
  }
 
 if (key == '1') {
    a.shoot();
  }
 
}
