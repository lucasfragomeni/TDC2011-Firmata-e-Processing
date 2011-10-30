import processing.serial.*;
import cc.arduino.*;

Arduino arduino;         //Declaração da Arduino

//Motor direito
int D_TRAS = 6;
int D_FRENTE = 9;

//Motor esquerdo
int E_TRAS = 3;
int E_FRENTE = 5;

/**
 * Método de inicialização
 */
void setup() {
  size(50, 50);      //Configura as dimensões da tela
  background(255);   //Configura a cor do fundo (branco) 
  noStroke();        //Remove a borda das figuras

  println(Arduino.list());  
  arduino = new Arduino(this, Arduino.list()[0], 57600);  //Inicializa a Arduino

  //Motor esquerdo
  arduino.pinMode(E_FRENTE, Arduino.OUTPUT);
  arduino.pinMode(E_TRAS, Arduino.OUTPUT);
  
  //Motor direito
  arduino.pinMode(D_FRENTE, Arduino.OUTPUT);
  arduino.pinMode(D_TRAS, Arduino.OUTPUT);
}

/**
 * Método principal do processing, que fica em loop durante a execução do programa
 */
void draw() {
  //Lê a tecla pressionada e comanda o carro via firmata
  if(keyPressed) {
    if(key == CODED) {
      if(keyCode == UP) {
        frenteEsquerda();
        frenteDireita();
      } else if(keyCode == DOWN) {
        trasEsquerda();
        trasDireita();
      } else if(keyCode == LEFT) {
        trasEsquerda();
        frenteDireita();
      } else if(keyCode == RIGHT) {
        trasDireita();
        frenteEsquerda();
      }
    }
  } else {
    parar();
  }
}

//////////////////////////
// Controle dos Motores //
//////////////////////////

void frenteEsquerda() {
  arduino.digitalWrite(D_FRENTE, Arduino.HIGH);
  arduino.digitalWrite(D_TRAS, Arduino.LOW);
}

void frenteDireita() {
  arduino.digitalWrite(E_FRENTE, Arduino.HIGH);
  arduino.digitalWrite(E_TRAS, Arduino.LOW);
}

void trasEsquerda() {
  arduino.digitalWrite(D_FRENTE, Arduino.LOW);
  arduino.digitalWrite(D_TRAS, Arduino.HIGH);
}

void trasDireita() {
  arduino.digitalWrite(E_FRENTE, Arduino.LOW);
  arduino.digitalWrite(E_TRAS, Arduino.HIGH);
}

void parar() {
  arduino.digitalWrite(D_FRENTE, Arduino.LOW);
  arduino.digitalWrite(D_TRAS, Arduino.LOW);
  arduino.digitalWrite(E_FRENTE, Arduino.LOW);
  arduino.digitalWrite(E_TRAS, Arduino.LOW);
}
