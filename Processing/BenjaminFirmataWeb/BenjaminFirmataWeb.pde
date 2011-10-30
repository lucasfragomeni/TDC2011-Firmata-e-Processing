import processing.serial.*;
import processing.net.*;
import cc.arduino.*;
import cc.bebop.*;

Arduino arduino;         //Declaração da Arduino
Server server;           //Declaração do Servidor

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
  size(50, 50);        //Configura as dimensões da tela
  background(255);     //Configura a cor do fundo (branco) 
  noStroke();          //Remove a borda das figuras

  println(Arduino.list());  
  arduino = new Arduino(this, Arduino.list()[0], 57600);  //Inicializa a Arduino

  server = new Server(this, 8080);   //Inicializa o servidor web na porta 8080

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
  //Aceita a requisição web
  Client client = server.available();
  if(client != null) {
    
    //Obtém a requisição
    String requestStr = client.readString();
    HTTPRequest request = new HTTPRequest(requestStr);
    
    //Obtém a direção dos parâmetros
    String direcao = request.getParameter("direcao");

    //Comanda o carro via firmata com base na direção informada
    if(direcao != null) {
      if(direcao.equals("1")) {
        println("frente");
        frenteEsquerda();
        frenteDireita();
      } 
      else if(direcao.equals("3")) {
        println("tras");
        trasEsquerda();
        trasDireita();
      } 
      else if(direcao.equals("4")) {
        println("esquerda");
        trasEsquerda();
        frenteDireita();
      } 
      else if(direcao.equals("2")) {
        println("direita");
        trasDireita();
        frenteEsquerda();
      } 
      else if(direcao.equals("0")) {
        parar();
      }
    } 
    else {
      direcao = "0";
    }

    //Lê o arquivo HTML e monta a página
    String lines[] = loadStrings("benjaminFirmataWeb.html");
    println("there are " + lines.length + " lines");
    for (int i=0; i < lines.length; i++) {
      server.write(lines[i]);
    }
    
    //Disconecta o cliente
    server.disconnect(client);
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

