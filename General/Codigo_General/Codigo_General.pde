#include <LiquidCrystal.h>
#include <OneWire.h> //librería para sensor de temperatura DS18S20
//****Declaración de funciones*****
int nivel();
void temperatura();
void caudal();
void velocidad();
void rpm_fun();

void menu_3();  //submenu del menu general
//*****Inicialización del display******

LiquidCrystal lcd(12, 11, 5, 4, 3, 7);

//***********Teclado*****************
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
int var = 20;
int var1 = 20;
int var2 = 20;

int va=0;


int mostrar;


//***********Nivel******************

const int analogInPin = A0;  // Analog input pin that the potentiometer is attached to
const int analogOutPin = 13; // Analog output pin that the LED is attached to

int sensorValue = 0;        // value read from the pot
int outputValue = 0;        // value output to the PWM (analog out)

//**********Velocidad***************

 volatile byte rpmcount;
 unsigned int rpm;
 unsigned long timeold;
 
//**********Temperatura************

OneWire  ds(10);  // on pin 10

//************************************
void setup() 
{
  Serial.begin(9600); //inicializo la comunicación serie
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
  
  lcd.clear();
  lcd.print("-Proyecto Final-");
  delay(2000);
/*   // salteo presentación
  lcd.clear();
  lcd.print("RolandoSebastian");
  lcd.setCursor(0,1); 
  lcd.print("Trellini Bruno");
  delay(2000);
  lcd.clear();
  lcd.print("-Menu Principal-");
  lcd.setCursor(0,1); 
  lcd.print("--6 funciones--");
  delay(2000);
  lcd.clear();
  lcd.print("Con * Avanza");
  lcd.setCursor(0,1); 
  lcd.print("Con # Retrocede");
  delay(2000);
*/ 
}// cierro void setup

//***********************************************************************************************************************************

void loop()

{

otra_vez:

lcd.clear();
lcd.print("1- Velocidad");
lcd.setCursor(0,1); 
lcd.print("2- Temperatura");
delay(500); 

  
 
var1 = teclado();  // cuando la fn teclado() no me encuentra nada, var1 deberia tener otro valor, asigno 20
 
while(var1 != 20)  //si no hay ninguna tecla apretada, var1=20 y no entro
{
 var1 = teclado();

  switch (var1) 
  {
    case 1:  //menu 1
   //   menu1();
       break;
          
    case 2:  //menu 2
   //   menu2();
       break; 
    case 11: //tecla * avanza
       goto otra_vez1;
       break;
  
  }

}
goto otra_vez;

otra_vez1:        //etiqueta para el salto cuando retrocedo a opciones 3-4
      
      lcd.clear();
      lcd.print("3- Nivel");
      lcd.setCursor(0,1); 
      lcd.print("4- Caudal");
      delay(500);

    
while(var1 != 20)//hasta que no se presione una de las 3 teclas no hago nada
{
   var1 = teclado();
 
  switch (var1) 
  {
    case 3:
      menu_3();
      break;
    
    case 4:
   //   menu=4;
      
    case 11://tecla * 
      goto otra_vez; //vuelvo a las opciones 1-2
     
  }//cierro switch
}//cierro while  
goto otra_vez1;

}//cierro loop()
//------------------------------------------
 
void menu_3()
{
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Nivel:");
  var1=20;
  
  
  while(var1 != 11)
  {
  var1 = teclado();
  
  mostrar=nivel();
  lcd.setCursor(0,1);
  lcd.print(mostrar);
  }

}//cierro menu_3
  


//***********************************************************************************************************************

int teclado() //una vez que ingreso a la función queda ciclando hasta que se presione una tecla y retorna el valor de la misma
{
  
   while(1==1) //bucle para ciclar hasta que una tecla sea presionada
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
    
       return(1);//tecla 1
     }
  }//cierro if 1
  
 F2 = digitalRead(Fila2);
  if(F2 == HIGH)
  { 
    delay(50);
    if(F2==digitalRead(Fila2)) 
     {
    
        return(4);//tecla 4
     }
  }//cierro if 2
 F3 = digitalRead(Fila3);
  if(F3 == HIGH)
  { 
    delay(50);
    if(F3==digitalRead(Fila3)) 
     {
      
        return(7);//tecla 7
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
     
        return(2);//tecla 2
     }
  }//cierro if 1
  F2 = digitalRead(Fila2);
  if(F2 == HIGH)
  { 
    delay(50);
    if(F2==digitalRead(Fila2)) 
     {
   
        return(5);//tecla 5
     }
  }//cierro if 2
  F3 = digitalRead(Fila3);
  if(F3 == HIGH)
  { 
    delay(50);
    if(F3==digitalRead(Fila3)) 
     {
    
        return(8);//tecla 8
     }
  }//cierro if 3
  F4a = digitalRead(Fila4a);
  if(F4a == HIGH)
  { 
    delay(50);
    if(F4a==digitalRead(Fila4a)) 
     {
   
       return(0);//tecla 0
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
  
       return(3);//tecla 3
     }
  }//cierro if 1
  F2 = digitalRead(Fila2);
  if(F2 == HIGH)
  { 
    delay(50);
    if(F2==digitalRead(Fila2)) 
     {
     
       return(6);//tecla 6
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
     
        return(9);//tecla 9
     }
  }//cierro if 1
  F4b = digitalRead(Fila4b);
  //  F3 = digitalRead(Fila3);
  if(F4b == HIGH)
  { 
    delay(50);
    if(F4b==digitalRead(Fila4b)) 
     {
    
        return(10);//tecla #
     }
  }//cierro if 2
//***************************************
// columna3c(pin10 teclado - pin 44 micro)  tecla *
  digitalWrite(Columna3b, LOW);
  digitalWrite(Columna3c, HIGH);  
  F4c = digitalRead(Fila4c);
  if(F4c == HIGH)
  { 
    delay(50);
    if(F4c==digitalRead(Fila4c)) 
     {
   
        return(11);//tecla *
     }
  }//cierro if 1
  digitalWrite(Columna3c, LOW);
  }//cierro while


// agrego  
var1=20; // 20 es el valor que toma var cuando no hay tecla
  
  
}//cierro teclado

//***********************Nivel**********************************************

int nivel()
{

  delay(50);
  // read the analog in value:
  sensorValue = analogRead(analogInPin);   
  
  // map it to the range of the analog out:
  outputValue = map(sensorValue, 0, 1023, 0, 255);  //valor escalado
  
  
  // wait 10 milliseconds before the next loop
  // for the analog-to-digital converter to settle
  // after the last reading:
  delay(10);                  
//}//cierro while
return(outputValue);
  
}//cierro void nivel

//*************************Velocidad*******************************************

void velocidad()
{  
   lcd.clear();
   lcd.print("Velocidad");
   digitalWrite(2, HIGH); //pullup
   attachInterrupt(0, rpm_fun, RISING); //declaro interrupción 0, es pin 2, cuando interrumpe llama a rpm_fun
   rpmcount = 0;
   rpm = 0;
   timeold = 0;
   va=0;//flag que uso para tecla presionada
   while(va==0)//hasta que no se presione una de las 3 teclas no hago nada
   {
     var1 = teclado();
     va=0; // con esto solucione que se salga del submenu, en teclado debe estar el problema
      if(var1==11) //si presioné * me voy
       {
         va=1;
       }
       if (rpmcount >= 20)  
       { 
        // Update RPM every 20 counts, increase this for better RPM resolution,
        // decrease for faster update
        rpm = 30*1000/(millis() - timeold)*rpmcount; // 1000 para pasar de milis a segundos, 30 porque son 2 pulsos 1 vuelta (60xmin) 
        timeold = millis();   //tiempo de inicio del programa
        rpmcount = 0;
        Serial.println(rpm,DEC);
	lcd.setCursor(0, 1);
        lcd.print(rpm);
       }//cierro if
   }//cierro while
   return;
}//cierro void velocidad
 void rpm_fun()
 {
   rpmcount++;
   //Each rotation, this interrupt function is run twice
 }

//*************************Temperatura*******************************************

void temperatura()
{
   va=0;//flag que uso para tecla presionada
   while(va==0)//hasta que no se presione una de las 3 teclas no hago nada
   {
     var1 = teclado();
     va=0; // con esto solucione que se salga del submenu, en teclado debe estar el problema
      if(var1==11) //si presioné * me voy
       {
         va=1;
       }
    byte i;
    byte present = 0;
    byte data[12];
    byte addr[8];
    float temp;
    byte signo;

    if ( !ds.search(addr)) 
     {
      //    Serial.print("No more addresses.\n");  //Aparentemente indica que no hay más dispositivos
      ds.reset_search();
      delay(250);
      return;
     }//cierro if

  //  Serial.print("R=");              //este paso se podría evitar, solo manda al puerto serie la dirección del dispositivo
  //  for( i = 0; i < 8; i++) 
  //    {
  //    Serial.print(addr[i], HEX);
  //    Serial.print(" ");
  //    }

/*     if ( OneWire::crc8( addr, 7) != addr[7]) 
     {
      Serial.print("CRC is not valid!\n");
      return;
     }
     if ( addr[0] != 0x10) 
     {
      Serial.print("Device is not a DS18S20 family device.\n");
      return;
     }
  // The DallasTemperature library can do all this work for you!
*/  
  ds.reset();
  ds.select(addr);
  ds.write(0x44,1);         // start conversion, with parasite power on at the end
  delay(1000);     // maybe 750ms is enough, maybe not
  // we might do a ds.depower() here, but the reset will take care of it.
  present = ds.reset();
  ds.select(addr);    
  ds.write(0xBE);         // Read Scratchpad
  //  Serial.print("P=");
  //  Serial.print(present,HEX);            
  //  Serial.print(" ");
  for ( i = 0; i < 9; i++) 
  {           // we need 9 bytes
    data[i] = ds.read();
   //    Serial.print(data[i], HEX);    //este paso se podría evitar, manda al puerto serie toda la pila leida, a mi solo me interesan 2
   // bytes
   //    Serial.print(" ");

  }//cierro for
  //  Serial.print(" CRC=");
  //  Serial.print( OneWire::crc8( data, 8), HEX);
  //  Serial.print(" Temperatura=");
  temp=data[0];
  if(data[1]>0)
    temp=temp * -1;        // acomoda para temperaturas negativas (comprobar)
  temp=temp/2;
  //Serial.print(temp,2);
  //Serial.println();

  // Print a message to the LCD.
  lcd.clear();
  //lcd.setCursor(0, 0);
  lcd.print("Temperatura");
  lcd.setCursor(0, 1);
  lcd.print(temp);
  lcd.setCursor(6, 1);
  lcd.print("oC");
 
 }//cierro while 
 delay(100);
 lcd.clear();
 return;   
  
}//cierro void temperatura

//********************************************************************

void caudal()
{
}//cierro void caudal

//********************************************************************

