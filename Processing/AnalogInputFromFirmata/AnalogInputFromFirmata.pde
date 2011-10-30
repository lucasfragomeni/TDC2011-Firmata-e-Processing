import processing.serial.*;
import cc.arduino.*;

Arduino arduino;         //Declaração da Arduino

void setup() {
  size(500, 500);      //Configura as dimensões da tela
  background(255);     //Configura a cor do fundo (branco)
  noStroke();          //Remove a borda das figuras
  
  arduino = new Arduino(this, Arduino.list()[0]);  //Inicializa a Arduino
}

void draw() {
  int leitura = arduino.analogRead(1);           //Lê a porta A1 da Arduino

  fill(map(leitura, 0, 1023, 0, 255));      //Converte a leitura da lux de 0-1023 para 
                                            //a escala de cinza entre 0-255;

  int diametro = (int)map(leitura, 0, 1023, 0, width);  //Converte a leitura num diâmetro

  background(255);                                  //Limpa o fundo (branco);
  ellipse(width/2, height/2, diametro, diametro);   //Desenha o circulo
}

