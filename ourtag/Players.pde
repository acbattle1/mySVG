class Players {
  Player pArray[];
  int pCnt = 0;
  int maxPlayers = 20;
  
  Players() {
    pArray = new Player[maxPlayers];
  }
  
  Player updatePlayer(String s) {
    if (s == null) {
      println("Can not update player, null string");
      return null;
    }
    Player temp = new Player(s);
    boolean newPlayer = true;
    if (temp.name == null) {
      println("problem with name");
      println(s);
      return null;
    }
    
    for (Player p : pArray) {
      if (p != null) {
        if (p.id == temp.id) {
          p.update(s);
          return p;
        }
      }
    }
    
    if (pCnt == maxPlayers)
      return null;
      
    if (newPlayer) {     
      Player aPlayer = new Player(s);
      pArray[pCnt] = aPlayer;
      pCnt++;
      println("Added new player " + aPlayer.name);
      if (gameServer != null) {
        gameServer.setPlayerDiff(aPlayer);
      }
      //send update to server for the new player
      myPlayer.sendUpdate();
      return aPlayer;
    }
    
    return null;
  } //<>//
  
  Player getByID(long id) {
    for (Player p : pArray) {
      if (p != null) {
        if (p.id == id) {
          return p;
        }
      }
    }
    return null;
  }
  
  void draw() {
    int i = 0; 
    for (Player p : pArray) {
      if (p != null) {
        if (!p.tagged) {
          textSize(20);
          text((p.serverPlayer ? "(SP) " : "") + p.name + ": " + p.tags + " tags", 5, 20 + i * 20);
          i++;
          stroke(0);
          strokeWeight(1);
          p.drawAndMove();
        }
      }
    }    
  }
  
  void tagThem(Player me) {
    for (Player p : pArray) {
      if (p != null) {
        if (me.checkTag(p)) {
          p.tagged = true;
          me.tags++;
          sendTag(p, me);
        }
      }
    }
  } 
  
  void gotTagged(int tagged, int tagger) {
    String taggerName, taggedName;
    taggerName = "";
    taggedName = "";
    for (Player p : pArray) {
      if (p != null) {
        if (p.id == tagged) {
          p.tagged = true;
          taggedName = p.name;
        }
        if (p.id == tagger) {
          taggerName = p.name;
        }
      }
    }
    lastTag = taggedName + " was tagged by " + taggerName;
  }
  
  void pullUpdates() {
    String s;
    
    //First see if I'm in the list for the first time
    if (myPlayer != null) {
      Player p = getByID(myPlayer.id);
      if (p != null) {
        if (myPlayer != p) {
          myPlayer = p;
          gameTimeDiff = myPlayer.timeDiff;
        }
      }
    }
    
    //Now update all my players from network
    while ((s = net.getString()) != null) {
      if (s.length() > 3) {
        if (s.substring(0,3).equals("TAG")) {
          println("got " + s);
          String[] parts = split(s, ' ');
          int tagged = int(parts[1]);
          int tagger = int(parts[2]);
          gotTagged(tagged, tagger);
          
          if (myPlayer.id == tagged) {
             gameOver = true;
          }
        }
        else {
          updatePlayer(s);
        }
      }
    }
  }
}
