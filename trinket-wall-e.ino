
#include <Adafruit_NeoPixel.h>
#include <NewPing.h>
#include "RGBColor.h"
#include "RGBPixelEffect.h"

#define NEOPIN 0

#define TRIGGER_PIN  12  // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN     11  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 200 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.

#define PIXELS       16

Adafruit_NeoPixel pixels = Adafruit_NeoPixel(PIXELS, NEOPIN);
NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); // NewPing setup of pins and maximum distance.

uint8_t  mode   = 0, // Current animation effect
         offset = 0; // Position of spinny eyes
uint32_t color  = 0xff5000; // Start red
uint32_t prevTime;

void setup() {
 pixels.begin();
 pixels.setBrightness(50); // 1/3 brightness
 prevTime = millis();
}

void loop() {
  uint8_t  i;
  uint32_t t;

  switch(mode) {

   case 0: // Random sparks - just one LED on at a time!
    i = random(20);
    pixels.setPixelColor(i, color);
    pixels.show();
    delay(10);
    pixels.setPixelColor(i, 0);
    break;

   case 1: // Spinny wheels (8 LEDs on at a time)
    for(i=0; i<PIXELS; i++) {
      uint32_t c = 0;
      if(((offset + i) & 7) < 4) c = color; // 4 pixels on...
      pixels.setPixelColor(   i, c); // First eye
      pixels.setPixelColor(PIXELS - i, c); // Second eye (flipped)
    }
    pixels.show();
    offset++;
    delay(90);
    break;
  }

  t = millis();
  if((t - prevTime) > 8000) {      // Every 8 seconds...
    mode++;                        // Next mode
    if(mode > 1) {                 // End of modes?
      mode = 1;                    // Start modes over
      color >>= 0  ;                 // Next color R->G->B
      if(!color) color = 0x00ff96; // Reset to red
    }
    for(i=0; i<PIXELS; i++) pixels.setPixelColor(i, 0);
    prevTime = t;
  }
}
