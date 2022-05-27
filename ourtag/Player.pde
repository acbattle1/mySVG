int moveDelay = 100; //<>//
class Player {
  PImage b;
  long id;
  int pColor;
  String name;
  float xPos;
  float yPos;
  float direction;
  float speed;
  int tags;
  boolean tagged;
  int lastUpdate;
  boolean serverPlayer;
  long timeDiff;
  long moveOn;

  Player() {
    b = loadImage("kid.png");
    id = millis();
    pColor = int(random(#000000, #ffffff));
    name = "Kevin";
    xPos = random(200, 600);
    yPos = random(200, 600);
    direction = random(0, PI);
    speed = 2;
    tags = 0;
    tagged = false;
    lastUpdate = millis();
    serverPlayer = false;
    moveOn = 0;
    timeDiff = 0;
  }

  Player(String s) {
    b = loadImage("kid.png");
    if (s == null) {
      println("error creating player, null string");
      return;
    }
    JSONObject pjson = new JSONObject();
    pjson = parseJSONObject(s);
    id = pjson.getLong("id");
    this.update(pjson);
  }

  String toString() {
    JSONObject pjson = new JSONObject();
    pjson.setLong("id", id);
    pjson.setInt("pColor", pColor);
    pjson.setString("name", name);
    pjson.setFloat("xPos", xPos);
    pjson.setFloat("yPos", yPos);
    pjson.setFloat("direction", direction);
    pjson.setFloat("speed", speed);
    pjson.setInt("tags", tags);
    pjson.setBoolean("tagged", tagged);
    pjson.setInt("lastUpdate", lastUpdate);
    pjson.setBoolean("serverPlayer", serverPlayer);
    pjson.setLong("moveOn", moveOn);
    pjson.setLong("timeDiff", timeDiff);
    return pjson.toString();
  }

  void update(String s) {
    JSONObject pjson = parseJSONObject(s);
    update(pjson);
  }

  void update(JSONObject pjson) { //<>//
    long newId = pjson.getLong("id");
    if (id != newId) //wrong player, don't update
      return;

    pColor = pjson.getInt("pColor");
    name = pjson.getString("name");
    xPos = pjson.getFloat("xPos");
    yPos = pjson.getFloat("yPos");
    direction = pjson.getFloat("direction");
    speed = pjson.getFloat("speed");
    tags = pjson.getInt("tags");
    tagged = pjson.getBoolean("tagged");
    lastUpdate = millis();
    serverPlayer = pjson.getBoolean("serverPlayer");
    moveOn = pjson.getLong("moveOn");
    long td = pjson.getLong("timeDiff");
    if (td > 0) {
      timeDiff = td;
    }
  }

  void drawAndMove() {
    push();
    translate(xPos, yPos);
    rectMode(CENTER);
    fill(pColor);
    rotate(direction);
    rect(0, 0, 60, 10);
    textSize(20);
    text(name, -40, 20);
    fill(#ff0000);
    rect(30, 0, 10, 10);
    image(b, 10, 10, 100, 150);
    pop();

    if (lastUpdate == 0) {
      lastUpdate = millis();
    }

    if (moveOn > millis() + gameTimeDiff) {
      lastUpdate = millis();
      return;
    }

    xPos += cos(direction) * speed * (millis() - lastUpdate) / 20;
    yPos += sin(direction) * speed * (millis() - lastUpdate) / 20;
    lastUpdate = millis();
    if (xPos > 800)
      xPos = 0;
    if (xPos < 0)
      xPos = 800;
    if (yPos > 800)
      yPos = 0;
    if (yPos < 0)
      yPos = 800;
  }

  void keyPressed() {
    if (tagged == true)
      return;

    if (key == 'a') {
      direction -= PI/16;
      if (direction < 0)
        direction += 2 *PI;
    }
    if (key == 'd') {
      direction += PI/16;
      if (direction > 2 * PI)
        direction -= 2 * PI;
    }
    if (key == 'w') {
      speed++;
      if (speed > 5)
        speed = 5;
    }
    if (key == 's') {
      speed--;
      if (speed < -2)
        speed = -2;
    }

    lastUpdate = millis();
    moveOn = gameTimeDiff + millis() + moveDelay;
    sendUpdate();
  }

  void sendUpdate() {
    net.putString(toString());
  }

  boolean checkTag(Player you) {
    if (you.tagged) { //already dead, can't tag again.
      return false;
    }

    if (this.id == you.id) { //you can't tag yourself
      return false;
    }

    //Require hard hit on side
    if (abs(this.direction - you.direction) < PI/4 || abs(this.direction - (you.direction + PI) % (2 * PI)) < PI/4) {
      return false;
    }

    return intersect(new PVector(this.xPos + cos(this.direction) * 25,
      this.yPos + sin(this.direction) * 25),
      new PVector(this.xPos + cos(this.direction) * 45,
      this.yPos + sin(this.direction) * 45),
      new PVector(you.xPos - cos(you.direction) * 30,
      you.yPos - sin(you.direction) * 30),
      new PVector(you.xPos + cos(you.direction) * 30,
      you.yPos + sin(you.direction) * 30));
  }
}



boolean intersect(PVector p1, PVector q1, PVector p2, PVector q2)
{
  int o1 = orientation(p1, q1, p2);
  int o2 = orientation(p1, q1, q2);
  int o3 = orientation(p2, q2, p1);
  int o4 = orientation(p2, q2, q1);
  return (o1 != o2 && o3 != o4);
}

int orientation(PVector p, PVector q, PVector r)
{
  float val = (q.y - p.y) * (r.x - q.x) -
    (q.x - p.x) * (r.y - q.y);
  if (val == 0.0) {
    return 0; // colinear
  }

  return (val > 0) ? 1 : 2; // clock or counterclock wise
}
