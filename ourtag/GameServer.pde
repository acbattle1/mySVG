class GameServer {
  
  GameServer() {

  }
  
  void update() {  
    String nextUpdate;
    
    while ((nextUpdate = net.getNext()) != null) {
      if (nextUpdate.substring(0,3).equals("TAG")) {
        println(nextUpdate); 
        net.broadcast(nextUpdate);
      }
      else {
        Player p = players.updatePlayer(nextUpdate);  
        net.broadcast(p.toString());  
        println("broadcast update from " + p.name + " at " + millis());
      }
    }
  } 
  
  void setPlayerDiff(Player newPlayer) {
    if (newPlayer.timeDiff != 0 || newPlayer.serverPlayer)
      return;

    newPlayer.timeDiff = millis() - newPlayer.id -  100; 
    println("set timeDiff " + newPlayer.timeDiff + " for " + newPlayer.name); 
  }
}
