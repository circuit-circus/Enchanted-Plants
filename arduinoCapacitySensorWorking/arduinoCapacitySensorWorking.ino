/*********************************************************
  This is a library for the MPR121 12-channel Capacitive touch sensor

  Designed specifically to work with the MPR121 Breakout in the Adafruit shop
  ----> https://www.adafruit.com/products/

  These sensors use I2C communicate, at least 2 pins are required
  to interface

  Adafruit invests time and resources providing this open source code,
  please support Adafruit and open-source hardware by purchasing
  products from Adafruit!

  Written by Limor Fried/Ladyada for Adafruit Industries.
  BSD license, all text above must be included in any redistribution
**********************************************************/

#include <Wire.h>
#include "Adafruit_MPR121.h"

// You can have up to 4 on one i2c bus but one is enough for testing!
Adafruit_MPR121 cap1 = Adafruit_MPR121();
Adafruit_MPR121 cap2 = Adafruit_MPR121();

// Keeps track of the last pins touched
// so we know when buttons are 'released'
uint16_t lasttouched1 = 0;
uint16_t currtouched1 = 0;

uint16_t lasttouched2 = 0;
uint16_t currtouched2 = 0;

void setup() {
  while (!Serial);        // needed to keep leonardo/micro from starting too fast!

  Serial.begin(9600);
//  Serial.println("Adafruit MPR121 Capacitive Touch sensor test");

  //init_cap( cap1, 0x5A );
  //init_cap( cap2, 0x5D );

  // Default address is 0x5A, if tied to 3.3V its 0x5B
  // If tied to SDA its 0x5C and if SCL then 0x5D
  
  //cap1.setThreshholds(6, 3);
  //cap2.setThreshholds(6, 3);

  //Serial.println( "looking for 0x5A" );
  if (!cap1.begin(0x5A)) {
    //Serial.println("MPR121 0x5A not found, check wiring?");
    while (1);
  }
  Serial.println("MPR121 0x5A found!");


  //Serial.println( "looking for 0x5D" );
  if (!cap2.begin(0x5D)) {
    //Serial.println("MPR121 0x5D not found, check wiring?");
    while (1);
  }
 Serial.println("MPR121 0x5D found!");


}

void loop() {
  // Get the currently touched pads
  currtouched1 = cap1.touched();
  currtouched2 = cap2.touched();

  for (uint8_t i = 0; i < 12; i++) {

    // check if touched
    if ((currtouched1 & _BV(i)) && !(lasttouched1 & _BV(i)) ) {
      Serial.println(i);
//      Serial.println(" TOUCHED");
    }

    // check if released
    if (!(currtouched1 & _BV(i)) && (lasttouched1 & _BV(i)) ) {
//      Serial.print(i); Serial.println(" RELEASED");
    }

    if ((currtouched2 & _BV(i)) && !(lasttouched2 & _BV(i)) ) {
      Serial.println(i + 12);
//      Serial.println(" TOUCCHED!");
    }

    if (!(currtouched2 & _BV(i)) && (lasttouched2 & _BV(i)) ) {
//      Serial.print(i + 12); Serial.println(" RELEASED");
    }

  }

  // reset our state
  lasttouched1 = currtouched1;
  lasttouched2 = currtouched2;

  // comment out this line for detailed data from the sensor!
  return;

  // debugging info, what

  Serial.print("\t\t\t\t\t\t\t\t\t\t\t\t\t 0x"); Serial.println(cap1.touched(), HEX);
  Serial.print("Filt: ");
  for (uint8_t i = 0; i < 12; i++) {
    Serial.print(cap2.filteredData(i)); Serial.print("\t");
  }
  Serial.println();
  Serial.print("Base: ");
  for (uint8_t i = 0; i < 12; i++) {
    Serial.print(cap2.baselineData(i)); Serial.print("\t");
  }
  Serial.println();


  // put a delay so it isn't overwhelming
  delay(100);
}

