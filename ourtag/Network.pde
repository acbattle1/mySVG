class Network {
  Server theServer;
  Client theClient;
  PApplet ap;
  
  Network(PApplet ap) {
    this.ap = ap;
    this.theServer = null;
    this.theClient = null;
  }
  
  boolean startServer() {
    theServer = new Server(ap, 5204);
    if (theServer == null) {
      println("could not start a server");
      return false;
    }
    
    return true;
  }
  
  String getNext() {
    Client c;      
    
    if (theServer == null)
      return null;
      
    c = theServer.available();
    if (c == null)
      return null;
      
    return c.readStringUntil(0);
  }
  
  void broadcast(String s) {
    if (theServer == null) {
      println("Can not broadcast, no server");
      return;
    }
  
    theServer.write(s);
    theServer.write(0);    
  } //<>//
  
  boolean startClient(String serverIp) {
    theClient = new Client(ap, serverIp, 5204); 
    if (theClient == null) {
      println("Could not start client, not connected to server");
      return false;
    }
    
    return true;
  }
  
  void putString(String s) {
    if (theClient == null) {
      println("No client");
      return;
    }
    
    theClient.write(s);
    theClient.write(0);
  }
  
  String getString() {
    if (theClient == null) {
      println("no client");
      return null;
    }
    
    return theClient.readStringUntil(0);
  }
}
