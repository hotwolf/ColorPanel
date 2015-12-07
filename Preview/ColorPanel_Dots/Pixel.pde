class Pixel {
   // Colors
   color  pixelColor;
   //position
   int    column;
   int    row;
  
  // Constructor
  Pixel(int column, int row, color pixelColor) {
   // Colors
   this.pixelColor = pixelColor;
   // Position
   this.column = column;
   this.row    = row;
  }
  
  // Draw routine
  void draw() {
  noStroke();
    fill(pixelColor);  
    //rect((column*pixelSize), (row*pixelSize), pixelSize, pixelSize);
    ellipse((column*pixelSize)+(pixelSize/2), (row*pixelSize)+(pixelSize/2), (pixelSize*2), (pixelSize*2)); 
  }

  // Getters/setters
  void setColor(color pixelColor) {
    this.pixelColor = pixelColor;
  }

  color getColor() {
    return pixelColor;
  }  
}
