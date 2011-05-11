#include <LiquidCrystal.h>

LiquidCrystal lcd(12, 11, 5, 4, 3, 7);
int i=0;

const int Columna1 = 50;      // Numero de pin asignado a columna1, pin 4 del teclado
const int Columna2 = 48;      // Numero de pin asignado a columna2, pin 6 del teclado
const int Columna3a = 52;     // Numero de pin asignado a columna3a, pin 1 del teclado
const int Columna3b = 46;     // Numero de pin asignado a columna3b, pin 8 del teclado
const int Columna3c = 44;     // Numero de pin asignado a columna3c, pin 10 del teclado

const int Fila1 = 42;     // Numero de pin asignado a fila 1, pin 2 del teclado
const int Fila2 = 40;     // Numero de pin asignado a fila 2, pin 3 del teclado
const int Fila3 = 38;     // Numero de pin asignado a fila 3, pin 5 del teclado
const int Fila4a = 36;     // Numero de pin asignado a fila 4a, pin 7 del teclado
const int Fila4b = 34;     // Numero de pin asignado a fila 4b, pin 9 del teclado
const int Fila4c = 32;     // Numero de pin asignado a fila 4c, pin 11 del teclado

const int ledPin =  13;       // the number of the LED pin
// variable que pasará a 1 
int F1 = 0;         // variable for reading the pushbutton status
int F2 = 0;
int F3 = 0; 
int F4a = 0; 
int F4b = 0; 
int F4c = 0; 
int var = 12;

void setup() 
{
  lcd.begin(16, 2);         // defino cantidad de columnas y filas del display utilizado
  lcd.setCursor(0,0);
  pinMode(ledPin, OUTPUT); // si no está asignado no prende el led y queda en un estado intermedio luz ténue
  // inicializo los pines asignados a las columnas como salida
  pinMode(Columna1, OUTPUT);      
  pinMode(Columna2, OUTPUT);      
  pinMode(Columna3a, OUTPUT);      
  pinMode(Columna3b, OUTPUT);      
  pinMode(Columna3c, OUTPUT);      
  // inicializo los pines asignados a las filas como entrada
  pinMode(Fila1, INPUT);     
  pinMode(Fila2, INPUT);     
  pinMode(Fila3, INPUT);     
  pinMode(Fila4a, INPUT);     
  pinMode(Fila4b, INPUT);     
  pinMode(Fila4c, INPUT); 
 
}// cierro void setup

void loop()
{ 
// columna1(pin4 teclado - pin 50 micro)  teclas 1-4-7
  digitalWrite(Columna1, HIGH); 
  digitalWrite(Columna2, LOW); 
  digitalWrite(Columna3a, LOW);
  digitalWrite(Columna3b, LOW);
  digitalWrite(Columna3c, LOW);

//***DETECCION DE TECLA************  
 F1 = digitalRead(Fila1);
  if(F1 == HIGH)
  { 
    delay(50);
    if(F1==digitalRead(Fila1)) 
     {
       var=1;//tecla 1
       //lcd.setCursor(0,0);
       //lcd.print("Tecla 1");
     }
  }//cierro if 1
  
 F2 = digitalRead(Fila2);
  if(F2 == HIGH)
  { 
    delay(50);
    if(F2==digitalRead(Fila2)) 
     {
       var=4;//tecla 4
       //lcd.setCursor(0,0);
       //lcd.print("Tecla 4");
     }
  }//cierro if 2
 F3 = digitalRead(Fila3);
  if(F3 == HIGH)
  { 
    delay(50);
    if(F3==digitalRead(Fila3)) 
     {
       var=7;//tecla 7
       //lcd.setCursor(0,0);
       //lcd.print("Tecla 7");
     }
  }//cierro if 3
 // digitalWrite(Columna1, LOW);
//****************************************
// columna2(pin6 teclado - pin 48 micro)  teclas 2-5-8-0
 
  digitalWrite(Columna1, LOW); 
  digitalWrite(Columna2, HIGH); 
  
  F1 = digitalRead(Fila1);
  if(F1 == HIGH)
  { 
    delay(50);
    if(F1==digitalRead(Fila1)) 
     {
       var=2;//tecla 2
       //lcd.setCursor(0,0);
       //lcd.print("Tecla 2");
     }
  }//cierro if 1
  F2 = digitalRead(Fila2);
  if(F2 == HIGH)
  { 
    delay(50);
    if(F2==digitalRead(Fila2)) 
     {
       var=5;//tecla 5
       //lcd.setCursor(0,0);
       //lcd.print("Tecla 5");
     }
  }//cierro if 2
  F3 = digitalRead(Fila3);
  if(F3 == HIGH)
  { 
    delay(50);
    if(F3==digitalRead(Fila3)) 
     {
       var=8;//tecla 8
       //lcd.setCursor(0,0);
       //lcd.print("Tecla 8");
     }
  }//cierro if 3
  F4a = digitalRead(Fila4a);
  if(F4a == HIGH)
  { 
    delay(50);
    if(F4a==digitalRead(Fila4a)) 
     {
       var=0;//tecla 0
       //lcd.setCursor(0,0);
       //lcd.print("Tecla 0");
     }
  }//cierro if 4
//****************************************
// columna3a(pin1 teclado - pin 52 micro)  teclas 3-6
  digitalWrite(Columna2, LOW);
  digitalWrite(Columna3a, HIGH);  
  F1 = digitalRead(Fila1);
  if(F1 == HIGH)
  { 
    delay(50);
    if(F1==digitalRead(Fila1)) 
     {
       var=3;//tecla 3
       //lcd.setCursor(0,0);
       //lcd.print("Tecla 3");
     }
  }//cierro if 1
  F2 = digitalRead(Fila2);
  if(F2 == HIGH)
  { 
    delay(50);
    if(F2==digitalRead(Fila2)) 
     {
       var=6;//tecla 6
       //lcd.setCursor(0,0);
       //lcd.print("Tecla 6");
     }
  }//cierro if 2
//****************************************
// columna3b(pin8 teclado - pin 46 micro)  teclas 9-#
  digitalWrite(Columna3a, LOW);
  digitalWrite(Columna3b, HIGH);  
  F3 = digitalRead(Fila3);
  if(F3 == HIGH)
  { 
    delay(50);
    if(F3==digitalRead(Fila3)) 
     {
       var=9;//tecla 9
       //lcd.setCursor(0,0);
       //lcd.print("Tecla 9");
     }
  }//cierro if 1
  F4b = digitalRead(Fila4b);
  //  F3 = digitalRead(Fila3);
  if(F4b == HIGH)
  { 
    delay(50);
    if(F4b==digitalRead(Fila4b)) 
     {
       var=10;//tecla #
       //lcd.setCursor(0,0);
       //lcd.print("Tecla #");
     }
  }//cierro if 2
//****************************************
// columna3c(pin10 teclado - pin 44 micro)  tecla *
  digitalWrite(Columna3b, LOW);
  digitalWrite(Columna3c, HIGH);  
  F4c = digitalRead(Fila4c);
  if(F4c == HIGH)
  { 
    delay(50);
    if(F4c==digitalRead(Fila4c)) 
     {
       var=11;//tecla *
       //lcd.setCursor(0,0);
       //lcd.print("Tecla *");
     }
  }//cierro if 1
  digitalWrite(Columna3c, LOW);
  
//****************************************
  switch (var) 
  {
    case 0:
      lcd.setCursor(0,0);
      lcd.print("Tecla 0");
      break;
    case 1:
      lcd.setCursor(0,0);
      lcd.print("Tecla 1");
      break;
    case 2:
      lcd.setCursor(0,0);
      lcd.print("Tecla 2");
      break;
    case 3:
      lcd.setCursor(0,0);
      lcd.print("Tecla 3");
      break;
    case 4:
      lcd.setCursor(0,0);
      lcd.print("Tecla 4");
      break;
    case 5:
      lcd.setCursor(0,0);
      lcd.print("Tecla 5");
      break;
    case 6:
      lcd.setCursor(0,0);
      lcd.print("Tecla 6");
      break;
    case 7:
      lcd.setCursor(0,0);
      lcd.print("Tecla 7");
      break;
    case 8:
      lcd.setCursor(0,0);
      lcd.print("Tecla 8");
      break;
    case 9:
      lcd.setCursor(0,0);
      lcd.print("Tecla 9");
      break;
    case 10: //#
      lcd.setCursor(0,0);
      lcd.print("Tecla #");
      break;
    case 11://*
      lcd.setCursor(0,0);
      lcd.print("Tecla *");
      break;  
    
  }//cierro switch
  
}//cierro void

