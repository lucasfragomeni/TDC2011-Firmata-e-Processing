import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

int pista1 = 0;
int pista2 = 0;

PFont f;

void setup() {
  size(600, 400);
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  delay(1000);
  
  arduino.pinMode(3, Arduino.INPUT);
  delay(100);
  arduino.pinMode(4, Arduino.INPUT);
  delay(100);
  arduino.pinMode(13, Arduino.OUTPUT);
  delay(100);
  
  f = loadFont("Serif-48.vlw");
  textFont(f,36);
  fill(#000000);
}

boolean ledState = false;
boolean high1 = false;
boolean high2 = false;

void draw() {
  background(#FFFFFF);
  
  if(arduino.digitalRead(3) == Arduino.HIGH) {
    println("HIGH");
    if(!high1) {
      pista1++;
      ledState = !ledState;
      high1 = true;
    }
  } else {
    println("!HIGH");
    high1 = false;
  }

  arduino.digitalWrite(13, ledState ? Arduino.HIGH : Arduino.LOW);

  text("Pista 1: " + pista1, 10, 100);  
  text("Pista 2: " + pista2, 10, 200);
}
