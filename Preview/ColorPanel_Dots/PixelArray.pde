class PixelArray {
  // Pixels
  Pixel[][] pixelArray;
  
    // Constructor
  PixelArray() {
    // Pixel array
    pixelArray = new Pixel[columns][rows];
    for (int column = 0; column < columns; column++) {
    for (int row    = 0; row    < rows;    row++) {
      colorMode(RGB,100);
      pixelArray[column][row] = new Pixel(column, row, color(brightness));
    }
    }
  }

  // Draw routine
  void draw() {
    // Pixel array
    for (int column = 0; column < columns; column++) {
    for (int row    = 0; row    < rows;    row++) {
      pixelArray[column][row].draw();
    }
    }
  }
  
    // Getters/setters
  void setColor(int column, int row, color pixelColor) {
      pixelArray[column][row].setColor(pixelColor);
  }

  color getColor(int column, int row) {
    return pixelArray[column][row].getColor();
  }  
}

  
