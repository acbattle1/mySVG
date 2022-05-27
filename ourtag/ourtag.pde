import processing.net.*;
Network net;
GameServer gameServer;
Player myPlayer;
Players players;
boolean settingUp;
SetupScreen setupScreen;
long gameTimeDiff;
String lastTag;
boolean gameOver;

void setup() {
  size(800, 800);
  gameServer = null;
  players = new Players();
  settingUp = true;
  setupScreen = new SetupScreen();
  net = new Network(this);
  frameRate(60);
  lastTag = "";
  gameOver = false;
}

void draw() {
  background(80);
  textSize(20);
  text(lastTag, 20, height - 10);
  if (settingUp) {
    setupScreen.draw();
    return;
  }
  
  if (gameServer != null) {
    gameServer.update();
  }
  
  players.pullUpdates();
  players.draw();
  if (gameOver) {
    textSize(80);
    text("Game Over", 60, 200);
    textSize(20);
    text("Click to restart", 60, 400);
    return;
  }
  
  players.tagThem(myPlayer);
}

void mouseClicked() {
  if (gameOver) {
    gameOver = false;
    settingUp = true;
  }
  
  if (settingUp) {
    setupScreen.mouseClicked();
  }
}

void sendTag(Player tagged, Player tagger) {
  net.putString("TAG " + tagged.id + " " + tagger.id + " ");
}

void keyPressed() {
  if (settingUp) {
    setupScreen.keyPressed();
    return;
  }
  
  if (myPlayer != null) {
    myPlayer.keyPressed();
  }
}
