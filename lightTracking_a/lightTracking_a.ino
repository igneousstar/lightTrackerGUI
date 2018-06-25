/**
 * This code was written 
 * by a friend of mine. 
 * Thank you Sir Harington,
 * the betrothed of 
 * Lady Tavia. 
 */

const int P1 = A0;
const int P2 = A1;
const int P3 = A2;

int P1value = 0;
int P2value = 0;
int P3value = 0;


void setup() {
  Serial.begin(9600);
}

String toSend = "";
void loop() {
  P1value = analogRead(P1)/4;
  delay(5);                 //the analog read function requires a few ms delay
  P2value = analogRead(P2)/4;
  delay(5);
  P3value = analogRead(P3)/4;
  delay(5);

  Serial.print(P1value);
  Serial.print(',');
  Serial.print(P2value);
  Serial.print(',');
  Serial.print(P3value);
  Serial.print('\n');

  delay(100);
}
