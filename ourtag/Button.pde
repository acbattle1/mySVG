class Button {
  int x;
  int y;
  String txt;
  int width;
  
  Button(int x, int y, int width, String txt) {
    this.x = x;
    this.y = y;
    this.txt = txt;
    this.width = width;
  }
  
  void draw() {
    fill(80);
    stroke(255);
    strokeWeight(4);
    rect(x, y, width, width/4);
    fill(255);
    textSize(40);
    text(txt, x + 25, y + width/4 - 25);
  }
  
  boolean mouseClicked() {
    return (mouseX > x && mouseX < x + width && 
      mouseY > y && mouseY < y + width/4);
  }
  
}
