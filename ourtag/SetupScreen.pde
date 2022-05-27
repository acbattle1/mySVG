class SetupScreen {
  Button serverButton, startButton;
  InputBox clientIPbox, playerNameBox;
  String serverIP;
  String playerName;
  
  SetupScreen() {
    serverButton = new Button(80, 60, 300, "Start Server");
    clientIPbox = new InputBox(80, 240, "or enter server IP");
    //clientIPbox.txt = "192.168.1.240";
    playerNameBox = new InputBox(80, 390, "Nickname");
    startButton = new Button(80, 600, 300, "Start Game");
    serverIP = "127.0.0.1";
    playerName = null;
  }
 
  void mouseClicked() {  
    if (serverButton.mouseClicked()) {
      if (net.startServer()) { 
        gameServer = new GameServer();
      }
    }
    
    if (startButton.mouseClicked()) {
      if (clientIPbox.txt.length() > 0) {
        serverIP = clientIPbox.txt;
      }      
      if (playerNameBox.txt.length() > 0) {
        playerName = playerNameBox.txt;
      }
      println(playerName);
      
      myPlayer = new Player();
      myPlayer.name = setupScreen.playerName;
      myPlayer.serverPlayer = (gameServer != null);
      println("creating a player with id " + myPlayer.id);
      myPlayer.lastUpdate = millis();
      if (!net.startClient(serverIP)) {
         println("Failed to start client with server " + serverIP ); 
      }
      
      net.putString(myPlayer.toString()); 
      println("sent my player update to server");
      
      settingUp = false; 
    }
    
    clientIPbox.getFocus(mouseX, mouseY);
    playerNameBox.getFocus(mouseX, mouseY);
  }
  
  void draw() {
    if (gameServer == null) {
      if (clientIPbox.txt.length() == 0)  {
        serverButton.draw();
      }
      clientIPbox.draw();      
    }
    playerNameBox.draw();
    if (gameServer != null || clientIPbox.txt.length() > 0){
      startButton.draw();
    }
  }
  
  void keyPressed() {
    clientIPbox.keyPressed();
    playerNameBox.keyPressed();
  }
}
