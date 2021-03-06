#include <LiquidCrystal.h>
#include <OneWire.h> //librería para sensor de temperatura DS18S20
//****Declaración de funciones*****


int velocidad();
int nivel();
float temperatura();
float caudal();
int seteo(int digitos, float mom); 
                        
						//devuelve el valor ingresado de max y min y espera la cantidad de digitos y si estoy seteando el minimo == 0 o el maximo == 1 (nº para la fila)
                        //que depende de la función que llama ej: temperatura = 2 dígitos que para agua
                        //donde se crían peces está bien.

void rpm_fun();
int alertas(int caso);
void menu_1();	//menu para velocidad
void menu_2();	//menu para temperatura
void menu_3();  //menu para nivel
void menu_4();  //menu para caudal
void menu_5();  //Submenú para calibración

//*****Inicialización del display******

LiquidCrystal lcd(12, 11, 5, 4, 3, 7);

//***********Teclado*****************
const int Columna1 = 46;      // Numero de pin asignado a columna1, pin 4 del teclado
const int Columna2 = 42;      // Numero de pin asignado a columna2, pin 6 del teclado
const int Columna3a = 52;     // Numero de pin asignado a columna3a, pin 1 del teclado
const int Columna3b = 38;     // Numero de pin asignado a columna3b, pin 8 del teclado
const int Columna3c = 34;     // Numero de pin asignado a columna3c, pin 10 del teclado

const int Fila1 = 50;     // Numero de pin asignado a fila 1, pin 2 del teclado
const int Fila2 = 48;     // Numero de pin asignado a fila 2, pin 3 del teclado
const int Fila3 = 44;     // Numero de pin asignado a fila 3, pin 5 del teclado
const int Fila4a = 40;     // Numero de pin asignado a fila 4a, pin 7 del teclado
const int Fila4b = 36;     // Numero de pin asignado a fila 4b, pin 9 del teclado
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


float mostrar;


//***********Nivel******************

const int analogInPin = A0;  // Analog input pin that the potentiometer is attached to
const int analogOutPin = 13; // Analog output pin that the LED is attached to

int sensorValue = 0;        // value read from the pot
int outputValue = 0;        // value output to the PWM (analog out)
int nivel1;
//**********Velocidad***************



 volatile byte rpmcount;
 unsigned int rpm;
 unsigned long timeold=0;
 //unsigned long timeold_0; // para el 0 de las RPM en velocidad()
 
 
//**********Temperatura************
int temp1 = 0;
float temp;
OneWire  ds(10);  // on pin 10
unsigned long timeold1=0;

//***********Caudal****************
 float ancho = 200; 	        // en [milimetros], ancho de la canaleta
 float valor_caudal=0; 	        // en [m³/s]
 float factor=200;		// valor a setear, explicado mejor en caudal()
 
//***********Seteo*******************
int minimoV=200; //rpm
int maximoV=4000;
int minimoN=0;   //nivel en mm
int maximoN=150;
int minimoT=15;   // temperatura en ºC
int maximoT=27;
int minimoC=1;   // caudal en m3/seg
int maximoC=2;
int suma=0;
int n=0;

//***********************************
void setup() 
{
  Serial.begin(9600); //inicializo la comunicación serie
  lcd.begin(16, 2);         // defino cantidad de columnas y filas del display utilizado
   
  
  pinMode(ledPin, OUTPUT); // si no está asignado no prende el led y queda en un estado intermedio luz ténue
  
  //****** velocidad()*************
  digitalWrite(2, HIGH); //pullup
  attachInterrupt(0, rpm_fun, RISING); //declaro interrupción 0, es pin 2, cuando interrumpe llama a rpm_fun
 
 
  
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

void loop()

{

otra_vez: 

lcd.clear();
lcd.print("1- Velocidad");
lcd.setCursor(0,1); 
lcd.print("2- Temperatura");
delay(100); 

  var1 = teclado();

  switch (var1) 
  {
    case 1:  //menu 1
	menu_1();
        //va=1;
       	break;
    case 2:  //menu 2
	menu_2();
        //va=1;
        break; 
    case 11: //tecla * avanza
	goto otra_vez1;
	break;
  }
goto otra_vez;

otra_vez1:        
      
      lcd.clear();
      lcd.print("3- Nivel");
      lcd.setCursor(0,1); 
      lcd.print("4- Caudal");
      delay(100);

var1 = teclado();
   
  switch (var1) 
  {
    case 0:
       goto otra_vez;
       //var1=20;
       break;
    case 3:
       menu_3();
       //var1=20;
       break;
    case 4:
       menu_4();
       //var1=20;
       break;
    case 10://tecla # retrocedo 
      goto otra_vez; //vuelvo a las opciones 1-2
    case 11://tecla * avanzo 
      goto otra_vez2; //voy a las opciones 5-6  
  }//cierro switch

goto otra_vez1;

otra_vez2: 

lcd.clear();
lcd.print("5- Calibracion");
lcd.setCursor(0,1); 
lcd.print("6- Processing");
delay(100); 

  var1 = teclado();

  switch (var1) 
  {
    case 0:
       goto otra_vez;
       //var1=20;
       break;
    case 5:  //menu 1
	goto otra_vez3; //Submenú Calibración
        //va=1;
       	break;
    case 6:  //menu 2
	goto otra_vez5;
	break; 
    case 10: //tecla # retrocede
	goto otra_vez1; //vuelvo a opciones 3-4
	break;
  }
goto otra_vez2;

otra_vez3: 

lcd.clear();
lcd.print("1- Seteo Velocidad");
lcd.setCursor(0,1); 
lcd.print("2- Seteo Temp.");
delay(100); 

  var1 = teclado();

  switch (var1) 
  {
    case 0:
       goto otra_vez;
       //var1=20;
       break;
    case 1:  //menu 1
        lcd.clear();
	lcd.print("Por defecto:");
        delay(800);

        lcd.clear();
	lcd.print("Min: 200rpm");
	    lcd.setCursor(0,1);
    lcd.print("Max: 4000rpm");
			
        delay(2000);
        lcd.clear();
	lcd.print("Minimo: ");
        minimoV = seteo(3,0);  
        delay(500);
		
        lcd.setCursor(0,1);
    lcd.print("Maximo:");  
        maximoV = seteo(4,1);  
        delay(1500);
       	break;
    case 2:  //menu 2
        lcd.clear();
	lcd.print("Por defecto:");
        delay(800);
		
        lcd.clear();
	lcd.print("Min: 15 ºC");
	    lcd.setCursor(0,1); 
    lcd.print("Max: 27 ºC");
				
        delay(2000);
        lcd.clear();
	lcd.print("Minimo:");
        minimoT = seteo(2,0);  
        delay(500);
		
        lcd.setCursor(0,1); 
    lcd.print("Maximo:");   
        maximoT = seteo(2,1);  
        delay(1500);
        break;
    case 10://tecla # retrocedo 
        goto otra_vez2; //vuelvo a las opciones 5-6 del menú principal  
    case 11: //tecla * avanza
	goto otra_vez4;
	break;
  }
goto otra_vez3;

otra_vez4:        
      
      lcd.clear();
      lcd.print("3-Seteo Nivel");
      lcd.setCursor(0,1); 
      lcd.print("4-Seteo Caudal");
      delay(100);

var1 = teclado();
   
  switch (var1) 
  {
    case 0:
       goto otra_vez;
       //var1=20;
       break;
    case 3:
        lcd.clear();
	lcd.print("Por defecto:");
        delay(800);
		
        lcd.clear();
	lcd.print("Min: 0 mm");
        lcd.setCursor(0,1); 
    lcd.print("Max: 150mm ");
        delay(2000);
		
        lcd.clear();
	lcd.print("Minimo:");      
        minimoN = seteo(2,0);  
        delay(500);
		
        lcd.setCursor(0,1); 
    lcd.print("Maximo:");   
        maximoN = seteo(3,1);  
        delay(1500);
       break;
    case 4:
       lcd.clear();
	lcd.print("Por defecto:");
        delay(800);
		
        lcd.clear();
	lcd.print("Min: 0,12 [m3/s]");
        lcd.setCursor(0,1); 
        lcd.print("Max: 0,5  [m3/s] ");
        delay(2000);
		
        lcd.clear();
	lcd.print("Minimo:");   
        minimoC = seteo(3,0);  
        delay(500);
		
        lcd.setCursor(0,1); 
    lcd.print("Maximo:");   
        maximoC = seteo(3,1);  
        delay(1500);
       break;
    case 10://tecla # retrocedo 
      goto otra_vez3; //vuelvo a las opciones 1-2 del seteo
   }//cierro switch
goto otra_vez4;

//////////////////////////////////////////////************************************
otra_vez5:
lcd.clear();
lcd.print("1- Velocidad");
lcd.setCursor(0,1); 
lcd.print("2- Temperatura");
delay(100); 

  var1 = teclado();

  switch (var1) 
  {
    case 0:
       goto otra_vez;
       
       break;
    case 1:  //Processing Velocidad
	    lcd.clear();
        lcd.print("Proces. Velocidad");
		//delay(1000);
		ProcessingVelocidad();
       	break;
    case 2:  //Processing Temperatura
	    lcd.clear();
        lcd.print("Proces. Temp.");
		//delay(1000);
		ProcessingTemperatura();
        break; 
	case 10://tecla # retrocedo 
      goto otra_vez2; //vuelvo a las opciones 1-2 del seteo	
    case 11: //tecla * avanza
	goto otra_vez6;
	break;
  }
goto otra_vez5;

otra_vez6:        
      
      lcd.clear();
      lcd.print("3- Nivel");
      lcd.setCursor(0,1); 
      lcd.print("4- Caudal");
      delay(100);

var1 = teclado();
   
  switch (var1) 
  {
    case 0:
       goto otra_vez; //Vuelvo al principio del menú principal
       
       break;
    case 3:   //Processing Nivel
       lcd.clear();
       lcd.print("Proces. Nivel");
	   //delay(1000);
	   ProcessingNivel();
       break;
    case 4:   //Processing Caudal
       lcd.clear();
       lcd.print("Proces. Caudal");
	   delay(2500);
       break;
    case 10://tecla # retrocedo 
      goto otra_vez5; //vuelvo a las opciones 1-2
      
  }//cierro switch

goto otra_vez6;

//////////////////////////////////////////////************************************

}//cierro loop()

void menu_1()
{
otra: 
  lcd.clear();
  lcd.print("Velocidad");
  lcd.setCursor(8,1);
  lcd.print("RPM"); 
  rpm=0;
  while(var1 != 11)
  {
   
  var1 = teclado();
  
  mostrar=velocidad();
  if(alertas(1)==1) //a alerta le mando 
  {
   goto otra; 
  }
  lcd.setCursor(0, 1); 
  lcd.print(mostrar,0); //0 decimales
  lcd.print("   ");
 
  }
} //cierro menu_1 
 
void menu_2()
{
otra1:
  lcd.clear();
  lcd.print("Temperatura");
  lcd.setCursor(8, 1);
  lcd.print("oC");  

  while(var1 != 11)
  {
  var1 = teclado();
  mostrar = temperatura();
  if(alertas(2)==1) //a alerta le mando 
  {
   goto otra1; 
  }
  lcd.setCursor(0, 1); 
  lcd.print(temperatura(),2); //2 decimales
  lcd.print("   ");
  //lcd.setCursor(0, 1);
  //lcd.print(temperatura());
  }
} //cierro menu_2
 
 
void menu_3()
{
  var1=20;
  
  while(var1 != 11)
  {
  var1 = teclado();
  
  nivel1 = (255 - nivel())*10; // abajo me da 0mm
  
  lcd.clear();
  
  //lcd.setCursor(0,0);
  lcd.print("Nivel:");
  lcd.setCursor(0,1);
  
  lcd.print(nivel1);
  lcd.setCursor(4,1);
  lcd.print("mm de Agua");
  //lcd.print("   ");
  }

}//cierro menu_3

void menu_4()
{
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Caudal [m3/s]");
 
  var1=20;
  
  
  while(var1 != 11)
  {
  var1 = teclado();
      
  lcd.setCursor(0,1);
  lcd.print(caudal(),2);// 0 para mostrar cero decimales
  lcd.print("     ");

  
  }

}//cierro menu_4

int teclado() 
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
    delay(10);
    if(F1==digitalRead(Fila1)) 
     {
    
       return(1);//tecla 1
     }
  }//cierro if 1
  
 F2 = digitalRead(Fila2);
  if(F2 == HIGH)
  { 
    delay(10);
    if(F2==digitalRead(Fila2)) 
     {
    
        return(4);//tecla 4
     }
  }//cierro if 2
 F3 = digitalRead(Fila3);
  if(F3 == HIGH)
  { 
    delay(10);
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
    delay(10);
    if(F1==digitalRead(Fila1)) 
     {
     
        return(2);//tecla 2
     }
  }//cierro if 1
  F2 = digitalRead(Fila2);
  if(F2 == HIGH)
  { 
    delay(10);
    if(F2==digitalRead(Fila2)) 
     {
   
        return(5);//tecla 5
     }
  }//cierro if 2
  F3 = digitalRead(Fila3);
  if(F3 == HIGH)
  { 
    delay(10);
    if(F3==digitalRead(Fila3)) 
     {
    
        return(8);//tecla 8
     }
  }//cierro if 3
  F4a = digitalRead(Fila4a);
  if(F4a == HIGH)
  { 
    delay(10);
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
    delay(10);
    if(F1==digitalRead(Fila1)) 
     {
  
       return(3);//tecla 3
     }
  }//cierro if 1
  F2 = digitalRead(Fila2);
  if(F2 == HIGH)
  { 
    delay(10);
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
    delay(10);
    if(F3==digitalRead(Fila3)) 
     {
     
        return(9);//tecla 9
     }
  }//cierro if 1
  F4b = digitalRead(Fila4b);
  //  F3 = digitalRead(Fila3);
  if(F4b == HIGH)
  { 
    delay(10);
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
    delay(10);
    if(F4c==digitalRead(Fila4c)) 
     {
   
        return(11);//tecla *
     }
  }//cierro if 1
  digitalWrite(Columna3c, LOW);
  


// agrego  
var1=20; // 20 es el valor que toma var cuando no hay tecla
  
  
}//cierro teclado

int nivel()
{

  //delay(50);
  // read the analog in value:
  sensorValue = analogRead(analogInPin);   
  
  // map it to the range of the analog out:
  outputValue = map(sensorValue, 0, 1023, 0, 255);  //valor escalado
  //ouput
  
  // wait 10 milliseconds before the next loop
  // for the analog-to-digital converter to settle
  // after the last reading:
  delay(10);                  
//}//cierro while
return(outputValue);
}//cierro void nivel

int velocidad()
{ //unsigned long resta; 
     
       if (rpmcount >= 20)  
       { 
        // Update RPM every 20 counts, increase this for better RPM resolution,
        // decrease for faster update
        rpm = 30*1000/(millis() - timeold)*rpmcount; // 1000 para pasar de milis a segundos, 30 porque son 2 pulsos 1 vuelta (60xmin) 
        timeold = millis();   //tiempo de inicio del programa
        rpmcount = 0;
       	}//cierro if
		
//		resta=timeold_0-millis();
//		if(resta > 2000) 	// si no interrumpio rpm_fun() en 2 segundo, rpm = 0
//			rpm=0;							//RPM mínima a 2seg por interrrup. En 4 seg -> 1rev, a 60 seg son 15rev -> Detecta 15 RPM o más. 
			
		
	  
       	
   return(rpm);
}//cierro void velocidad
 
void rpm_fun()  //esta interrupción esta declarada en setup()
 {
//	timeold_0=millis();
	rpmcount++; //ojo con el desbordamiento, tener en cuenta si hay problemas
   //Each rotation, this interrupt function is run twice
 }

float temperatura()
{
 
    byte i;
    byte present = 0;
    byte data[12];
    byte addr[8];
    
    byte signo;
    
    
    if ( !ds.search(addr)) 
     {
      //    Serial.print("No more addresses.\n");  //Aparentemente indica que no hay más dispositivos
      ds.reset_search();
      //delay(250);
  //    return;
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
  
  if( 800 > (millis() - timeold1))
    return(temp);
    
  
  timeold1 = millis();
  //delay(800);     // maybe 750ms is enough, maybe not
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
  
 
 return(temp);   
  
}//cierro void temperatura

float caudal()
{
  float vel;
  float area;
  
  // Supongo que el ancho=200 milimetros. Fue definido arriba pero luego debería setearse
  // ver si se puede grabar en la EEPROM los sets 
  // Supongo que nivel() devuelve en milimetros  
  area=(nivel()*ancho)/100; // la cuenta es en [mm] pero /100 para pasar a [metro]
  
  
  //convierto rpm en [m/s], para eso debo hacer un ensayo y encontrar un factor de conversión "factor"
  //por ejemplo si a 200 [rpm], el agua avanza 1[m/s] (en un segundo) -> factor = 200;
  vel=velocidad()/factor;
   
      valor_caudal=area * vel;   // en [m³/s]
    
  return(valor_caudal);
  
  
}//cierro void caudal

int seteo(int digitos, int mom) //declaré en la fcion a el 2º parametro como float, pero aca digo que lo tomo como entero, pq tira un error en la declaracion
{
  
  delay(500);
vuelvo1:
  var1=20;
  suma = 0;
  n=1;
  
vuelvo: 

// Solo paso el bucle si presiono una tecla
  var1=20;
  while(var1==20)
  {
  var1 = teclado();
  delay(100);
  }
// Enciendo y apago led para indicar que me detectó tecla presionada
  digitalWrite(ledPin, HIGH);  
  delay(100);
  digitalWrite(ledPin, LOW);

  
      if((digitos -n) == 3)//primer digito * 1000 corresponde al cuarto
      {
       suma = suma + var1*1000;
	   lcd.setCursor(8,mom);
       lcd.print(suma);  	   
      }//cierro if n==0
      if((digitos -n)==2)//primer digito * 100 corresponde a centenas
      {
       suma = suma + var1*100;
       lcd.setCursor(8,mom);	   
	   lcd.print(suma);  	   
      }//cierro if n==1
      if((digitos -n)==1)//primer digito * 10 corresponde a decenas
      {
       suma = suma + var1*10; 
	   lcd.setCursor(8,mom);
	   lcd.print(suma);  	   
      }//cierro if n==2
      if(n != digitos)
	  {
        n=n+1;
        goto vuelvo;
      } 
	  suma = suma + var1;
      lcd.setCursor(8,mom); // El total desde la posicion de inicio	  
	  lcd.print(suma);  	   
      return(suma);
  
 }//cierro int seteo
 
 int alertas(int caso) // Falta las de nivel y caudal -- Llama desde menú 3 y 4
 {
  
  //*******Velocidad*********
 if(caso == 1)
 {
  if(mostrar < minimoV || mostrar >= maximoV )
  {
   
   lcd.clear();
   lcd.print("Alerta Velocidad");
   digitalWrite(ledPin, HIGH);  
   delay(300);
   digitalWrite(ledPin, LOW);
   delay(300);
   lcd.clear();
   lcd.print("Alerta Velocidad");
   digitalWrite(ledPin, HIGH);  
   delay(300);
   digitalWrite(ledPin, LOW);
   delay(300);
   lcd.clear();
   lcd.print("Alerta Velocidad");
   digitalWrite(ledPin, HIGH);  
   delay(300);
   digitalWrite(ledPin, LOW);
   delay(300);
   lcd.clear();
   lcd.print("Alerta Velocidad");
   return(1);
 }//cierro if velocidad 
 }//cierro if caso1
 
 if(caso == 2)
 {
  if(mostrar < minimoT || mostrar >= maximoT )
  {
   lcd.clear();
   lcd.print("Alerta Temperat.");
   delay(500);
   lcd.clear();
   lcd.print("Alerta Temperat.");
   delay(500);
   lcd.clear();
   lcd.print("Alerta Temperat.");
   delay(500);
   lcd.clear();
   lcd.print("Alerta Temperat.");
   return(1); 
  }//cierro if temp. 
 }//cierro if caso 2
 
 if(caso == 3)
 {
  if(mostrar <= minimoN || mostrar >= maximoN)
  {
   lcd.clear();
   lcd.print("Alerta Nivel");
   delay(500);
   lcd.clear();
   lcd.print("Alerta Nivel");
   delay(500);
   lcd.clear();
   lcd.print("Alerta Nivel");
   delay(500);
   lcd.clear();
   lcd.print("Alerta Nivel");
   return(1);
  }//cierro if nivel 
 }// if caso 3
 
 if(caso == 4)
 {
  if(mostrar <= minimoC || mostrar >= maximoC)
  {
   lcd.clear();
   lcd.print("Alerta Caudal");
   delay(500);
   lcd.clear();
   lcd.print("Alerta Caudal");
   delay(500);
   lcd.clear();
   lcd.print("Alerta Caudal");
   delay(500);
   lcd.clear();
   lcd.print("Alerta Caudal");
   return(1);
  }//cierro if caudal 
 }//cierro if caso 4  
   return(0);
   
 }//cierro void alertas

 
///////***************************************************************************************************************************** 

void ProcessingNivel()
{
  var1=20;
  while(var1 != 11)
  {
   
  var1 = teclado();
  
  sensorValue = analogRead(analogInPin);   
  //outputValue = map(sensorValue, 0, 1023, 0, 255);  //valor escalado
  Serial.println(sensorValue);
  delay(40);                  
  }//cierro while
  
}//cierro void nivel

void ProcessingVelocidad()
{ //unsigned long resta; 
      var1=20;
	  while(var1 != 11)
      {
   
       var1 = teclado();
       if (rpmcount >= 20)  
       { 
        // Update RPM every 20 counts, increase this for better RPM resolution,
        // decrease for faster update
        rpm = 30*1000/(millis() - timeold)*rpmcount; // 1000 para pasar de milis a segundos, 30 porque son 2 pulsos 1 vuelta (60xmin) 
        timeold = millis();   //tiempo de inicio del programa
        rpmcount = 0;
       	}//cierro if
		Serial.println(rpm);
        delay(10);
      }//cierro while
    	  
   
}//cierro void velocidad


void ProcessingTemperatura()
{
 
    byte i;
    byte present = 0;
    byte data[12];
    byte addr[8];
    
    byte signo;
	var1=20;
    while(var1 != 11)
    {
    
    var1 = teclado();
    
    if ( !ds.search(addr)) 
     {
      //    Serial.print("No more addresses.\n");  //Aparentemente indica que no hay más dispositivos
      ds.reset_search();
      //delay(250);
  //    return;
     }//cierro if

  ds.reset();
  ds.select(addr);
  ds.write(0x44,1);         // start conversion, with parasite power on at the end
  //if(800 > (millis() - timeold1) ) //solo manda por el puerto serie si pasaron 800ms para que sea posible la conversion
  // { 
  //Serial.print(temp,2);
    delay(40);
    Serial.println(temp,1);
  // }
    
  
 // timeold1 = millis();
  //delay(800);  
  
  present = ds.reset();
  ds.select(addr);    
  ds.write(0xBE);         // Read Scratchpad
  for ( i = 0; i < 9; i++) 
  {           // we need 9 bytes
    data[i] = ds.read();
   //    Serial.print(data[i], HEX);    //este paso se podría evitar, manda al puerto serie toda la pila leida, a mi solo me interesan 2
   // bytes
   //    Serial.print(" ");

  }//cierro for
  temp=data[0];
  if(data[1]>0)
    temp=temp * -1;        // acomoda para temperaturas negativas (comprobar)
  temp=temp/2;
  
  }//cierro while
 }//cierro void temperatura

void ProcessingCaudal()
{
  float vel;
  float area;
  
  // Supongo que el ancho=200 milimetros. Fue definido arriba pero luego debería setearse
  // ver si se puede grabar en la EEPROM los sets 
  // Supongo que nivel() devuelve en milimetros  
  area=(nivel()*ancho)/100; // la cuenta es en [mm] pero /100 para pasar a [metro]
  
  
  //convierto rpm en [m/s], para eso debo hacer un ensayo y encontrar un factor de conversión "factor"
  //por ejemplo si a 200 [rpm], el agua avanza 1[m/s] (en un segundo) -> factor = 200;
  vel=velocidad()/factor;
   
      valor_caudal=area * vel;   // en [m³/s]
    
  
  
  
}//cierro void caudal
