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
