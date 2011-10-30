void setup() {                
  //Configura os pinos A0 e A1 como INPUT
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);

  //Inicializa a comunicação serial  
  Serial.begin(9600);
}

void loop() {
  //Lê os pinos A0 e A1
  int leituraLuz = analogRead(A0);
  int leituraPotenciometro = analogRead(A1);
  
  //Envia para a porta serial
  Serial.print(leituraLuz);
  Serial.print(",");
  Serial.print(leituraPotenciometro);
  Serial.println();
  delay(75);
}
