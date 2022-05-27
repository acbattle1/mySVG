 class InputBox {
   float x, y;
   String txt;
   String label;
   boolean hasFocus;
   
   InputBox(float x, float y, String label) {
     this.x = x;
     this.y = y;
     this.label = label;
     this.txt = "";
     this.hasFocus = false;
   }
   
   void getFocus(float x, float y) {
     if (x > this.x && x < this.x + 540 &&
         y > this.y && y < this.y + 140) {
         this.hasFocus = true;
     }
     else {
         this.hasFocus = false;
     }
   }
   
   void keyPressed() {
     if (hasFocus) {
       if (key == BACKSPACE) {
         if (txt.length() > 0) {
           txt = txt.substring(0, txt.length() - 1);
         }
       }
       else {
         if (key >= 46 && key <= 122) {
           txt = txt + key;
         }
       }
     }
   }
   
   void draw() {
      textSize(60);
      text(label, x+20, y-20);
      fill(80);
      rect(x, y, 540, 60, 12);
      fill(255);
      textSize(40);
      text(txt, x+20, y+40);     
   }
}
