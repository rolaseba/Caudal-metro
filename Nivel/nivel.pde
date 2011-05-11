#include <LiquidCrystal.h>

LiquidCrystal lcd(12, 11, 5, 4, 3, 7);

const int analogInPin = A0;  // Analog input pin that the potentiometer is attached to
const int analogOutPin = 13; // Analog output pin that the LED is attached to

int sensorValue = 0;        // value read from the pot
int outputValue = 0;        // value output to the PWM (analog out)

void setup() 
{
  
  // initialize serial communications at 9600 bps:
  Serial.begin(9600); 
  lcd.begin(16, 2);         // defino cantidad de columnas y filas del display utilizado
  lcd.setCursor(0,0);
}

void loop() 
{
  delay(50);
  // read the analog in value:
  sensorValue = analogRead(analogInPin);            
  // map it to the range of the analog out:
  lcd.setCursor(0,0);
  lcd.print(sensorValue);
  outputValue = map(sensorValue, 0, 1023, 0, 255);  
  // change the analog out value:
  lcd.setCursor(0,1); 
  lcd.print(outputValue);
   

  // print the results to the serial monitor:
  Serial.print("sensor = " );                       
  Serial.print(sensorValue);      
  Serial.print("\t output = ");      
  Serial.println(outputValue); 
   

  // wait 10 milliseconds before the next loop
  // for the analog-to-digital converter to settle
  // after the last reading:
  delay(10);                     
}
