// Required objects
PixelArray      pixelArray;
ColorRandomizer randomizer;

// Pixel transition
int   column;
int   row;
color oldColor;
color newColor;
int   transitionCount;

// Constants
final int columns         = 15;
final int rows            = 15;
final int pixelSize       = 20;
final int transitionSpeed = 20;
final int brightness      = 95;
final int saturation      = 25;
final int alpha           = 50;

// Settings
//void settings() {
//  // Prepare screen
//  //size(sWidth, sHeight);
//  size((columns*pixelSize), (rows*pixelSize), P2D);
//}

// Setup
void setup() {
  // Prepare screen
  //size(sWidth, sHeight);
  size(300, 300);
  // Instantiate objects
  randomSeed(0);
  randomizer  = new ColorRandomizer();
  pixelArray  = new PixelArray();
  // Pixel transition
  transitionCount = -1;
  // Initialize pixel array
  for (int column = 0; column < columns; column++) {
  for (int row    = 0; row    < rows;    row++) {
    //pixelArray.setColor(column, row, randomizer.getColor());
    colorMode(HSB, 100);
    //pixelArray.setColor(column, row, color(0, saturation, brightness));
    pixelArray.setColor(column, row, color(0, 0, 90, 0));
  }
  }  
}

// draw
void draw() {
  // Pixel transition
  if (transitionCount < 0) {
   transitionCount = transitionSpeed;
   column   = int(random(columns));
   row      = int(random(rows));
   oldColor = pixelArray.getColor(column, row);
   // Random colors
   //newColor = randomizer.getColor();
   // Indremented hue
   colorMode(HSB, 100);
   newColor = color(hue(oldColor)+random(5, 15), saturation, brightness, alpha);
   
  } else {
   pixelArray.setColor(column, row, lerpColor(newColor, oldColor, (transitionCount / transitionSpeed)));
  }
  transitionCount--;  
    
  // Draw
 
  pixelArray.draw();
}
class ColorRandomizer {
   // Color constraints
   final int brightness = 95;
   final int saturation = 25;
   final int alpha      = 50;

   // Constructor
  ColorRandomizer() {
  }
 
   // Make up a color
   color getColor () {
     colorMode(HSB, 100);
     return color(random(100), saturation, brightness, alpha);
     //return color((randomGaussian()*50), saturation, brightness);
   }
 } 
 
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

  

