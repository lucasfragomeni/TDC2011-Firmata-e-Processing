import cc.arduino.*;
import processing.serial.*;
import guicomponents.*;

PFont f;

GWSlider sdr1, sdr2, sdr3, sdr4, sdr5;
GCheckbox cbx1, cbx2, cbx3, cbx4, cbx5;

Arduino arduino;

void setup() {
  size(420, 500);  

  /////////////
  // Arduino //
  /////////////

  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  
  //Botões
  arduino.pinMode(2, Arduino.INPUT);
  arduino.pinMode(3, Arduino.INPUT);
  arduino.pinMode(4, Arduino.INPUT);
  arduino.pinMode(5, Arduino.INPUT);
  arduino.pinMode(6, Arduino.INPUT);

  //Led
  arduino.pinMode(7, Arduino.OUTPUT);

  ///////////////////////
  // Interface Gráfica //
  ///////////////////////
  
  //Input A0
  sdr1 = new GWSlider(this,"blue18px",80,25,260);
  sdr1.setLimits(0, 0f, 1023f);
  
  //Input A1
  sdr2 = new GWSlider(this,"blue18px",80,85,260);
  sdr2.setLimits(0, 0f, 1023f);

  //Input A2
  sdr3 = new GWSlider(this,"blue18px", 80,145,260);
  sdr3.setLimits(0, 0f, 1023f);

  //Input A3
  sdr4 = new GWSlider(this,"blue18px",80,205,260);
  sdr4.setLimits(0, 0f, 1023f);
  sdr4.setInertia(10);
  
  //Input A4
  sdr5 = new GWSlider(this,"blue18px",80,265,260);
  sdr5.setLimits(0, 0f, 1023f);
  sdr4.setInertia(10);

  //Checkbox's botões
  cbx1 = new GCheckbox(this, "Digital 2", 10, 305, 100);
  cbx2 = new GCheckbox(this, "Digital 3", 10, 345, 100);
  cbx3 = new GCheckbox(this, "Digital 4", 10, 385, 100);
  cbx4 = new GCheckbox(this, "Digital 5", 10, 425, 100);
  cbx5 = new GCheckbox(this, "Digital 6", 10, 465, 100);

  //Labels
  f = loadFont("Serif-48.vlw");
  fill(0);
}

void draw() {
  background(200,200,255);
  
  text("Analog 0: ", 35, 30);
  int analog0 = arduino.analogRead(0);
  sdr1.setValue(analog0);

  text("Analog 1: ", 35, 90);
  int analog1 = arduino.analogRead(1);
  sdr2.setValue(analog1);

  text("Analog 2: ", 35, 150);
  int analog2 = arduino.analogRead(2);
  sdr3.setValue(analog2);

  text("Analog 3: ", 35, 210);
  int analog4 = arduino.analogRead(4);
  sdr4.setValue(analog4);

  text("Analog 4: ", 35, 270);
  int analog3 = arduino.analogRead(3);
  sdr5.setValue(analog3);

  cbx1.setSelected(arduino.digitalRead(2) == Arduino.HIGH);
  cbx2.setSelected(arduino.digitalRead(3) == Arduino.HIGH);
  cbx3.setSelected(arduino.digitalRead(4) == Arduino.HIGH);
  cbx4.setSelected(arduino.digitalRead(5) == Arduino.HIGH);
  cbx5.setSelected(arduino.digitalRead(6) == Arduino.HIGH);
}

void keyPressed() {
  if(key == ENTER) {
    arduino.digitalWrite(7, Arduino.HIGH);
  }
}

void keyReleased() {
  if(key == ENTER) {
    arduino.digitalWrite(7, Arduino.LOW);
  }
}
