//LED code for Nagaliers. Changes your lighting based on your activity level logged by Fitbit. 
/*************************************************************************************/

#include "FastSPI_LED2.h"
#define NUM_LEDS 60

struct CRGB leds[NUM_LEDS];
int colorval = 0; // Variable to hold the changing "mood light" strip color.
int steps=0;

void setup() {
  LEDS.setBrightness(250);
  LEDS.addLeds<WS2811, 5>(leds, NUM_LEDS);
    Serial.begin(9600);
}


void loop() {
  //get the step count
     if  (Serial.available() > 0) {
      steps = Serial.read();
     }
    //light up the strip!
    if(steps==255) rainbow(colorval % 384); //if you've met your step goal
    else if(steps==0) angryFlash(); // if you're behind schedule
    else  RGBcolorFill(steps); // if you're making progress
    colorval++; // increment the color for the reward rainbow when you've met step goals.
}
 
 
//Fill the strip with 1/3 of a rainbow, starting from color c
void rainbow(uint32_t c) {
  uint16_t i;
    for (i=0; i < NUM_LEDS; i++) {
      leds[i] = RGBWheel(((i * 128 / NUM_LEDS) + c) % 384); // 128 = 384/3 = 1/3 of the rainbow.
    }
    LEDS.show();
}

// Fill the strip with a single color.
void RGBcolorFill(uint32_t c) {
  int i;
  c = map(c, 0, 255, 0, 300);
  for (i=0; i < NUM_LEDS; i++) {
      leds[i] = RGBWheel(c); // set all active pixels on
  }
  LEDS.show();
 }

// Flash red.
void angryFlash() {
  int i;
  //Turn strip red.
  for (i=0; i < NUM_LEDS; i++) {
      leds[i] = CRGB(0, 255, 0); // set all active pixels red
  }
  LEDS.show();
  delay(100);    
  //Turn strip off.
  for (int i=0; i < NUM_LEDS; i++) {
  memset(leds, 0,  NUM_LEDS * sizeof(struct CRGB));
  }
  LEDS.show();
  delay(100);
 }

/* RGB Color Wheel Helper function */
//Input a value 0 to 384 to get a color value.
CRGB RGBWheel(uint16_t WheelPos) {
  byte r, g, b;
  switch(WheelPos / 128)
  {
    case 0:
      r = 127 - WheelPos % 128; // red down
      g = WheelPos % 128;       // green up
      b = 0;                    // blue off
      break;
    case 1:
      g = 127 - WheelPos % 128; // green down
      b = WheelPos % 128;       // blue up
      r = 0;                    // red off
      break;
    case 2:
      b = 127 - WheelPos % 128; // blue down
      r = WheelPos % 128;       // red up
      g = 0;                    // green off
      break;
  }
  return(CRGB(b, r, g));    //colors are in a stupid order.
}


