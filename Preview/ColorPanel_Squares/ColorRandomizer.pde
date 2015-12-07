class ColorRandomizer {
   // Color constraints
   final int brightness = 95;
   final int saturation = 25;

   // Constructor
  ColorRandomizer() {
  }
 
   // Make up a color
   color getColor () {
     colorMode(HSB, 100);
     return color(random(100), saturation, brightness);
     //return color((randomGaussian()*50), saturation, brightness);
   }
 } 
 
