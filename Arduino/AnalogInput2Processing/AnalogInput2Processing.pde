void setup() {                
  //Configura o pino A1 como INPUT
  pinMode(A3, INPUT);

  //Inicializa a comunicação serial  
  Serial.begin(9600);
}

void loop() {
  //Lê o pino A0
  int leitura = analogRead(A3);
  
  //Envia para a porta serial
  Serial.println(leitura);
  delay(75);
}
