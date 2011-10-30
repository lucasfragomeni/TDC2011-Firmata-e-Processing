import processing.serial.*;

Serial serial;         //Declaração a porta serial

void setup() {
  size(500, 500);      //Configura as dimensões da tela
  background(255);     //Configura a cor do fundo (branco)
  noStroke();          //Remove a borda das figuras
  
  serial = new Serial(this, Serial.list()[0], 9600);  //Inicializa a comunicação serial
}

void draw() {
  if(serial.available() > 0) {                  //Verifica se tem algum dado para ler

    String dados = serial.readStringUntil(10);  //Lê a String até encontrar uma quebra 
                                                //de linha (10 em ASCII)

    if(dados != null) {                         //Verifica se os dados vieram bem formatados

      int leitura = int(trim(dados));           //Converte para um inteiro

      fill(map(leitura, 0, 1023, 0, 255));      //Converte a leitura da lux de 0-1023 para 
                                                //a escala de cinza entre 0-255;

      int diametro = (int)map(leitura, 0, 1023, 0, width);  //Converte a leitura num diâmetro

      background(255);                                  //Limpa o fundo (branco);
      ellipse(width/2, height/2, diametro, diametro);   //Desenha o circulo
    }
  }
}

