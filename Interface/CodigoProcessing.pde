
String  xLabel = "Tiempo (Min : Seg)";
String  yLabel = "Temperatura ºC";
String  Heading = "Gráfico de Temperatura";
String  URL1 = "01/06/2011";

//***********************************************************

String  xLabel1 = "Tiempo";
String  yLabel1 = "Caudal m3/s";
String  Heading1 = "Gráfico de Caudal";
String  URL2 = "01/06/2011";

//**********************************************************

String  xLabel2 = "Tiempo";
String  yLabel2 = "Nivel de Agua (Cm)";
String  Heading2 = "Gráfico de Nivel";
String  URL = "01/06/2011";

//********Imagen de Fondo***********************************
PImage a; 

//***********Axis Temperatura*******************************
//float Vcc = 5.0;    // the measured voltage of your usb
int NumOfVertDivisions=4;      //Divisiones Verticales
int NumOfVertSubDivisions=8;  // Subdivisiones Verticales
int NumOfBars=5; 
//***********Axis Caudal***********************************
int NumOfVertDivisions1=3;      //Divisiones Verticales
int NumOfVertSubDivisions1=18;  // Subdivisiones Verticales
int NumOfBars1=10;    
//***********Axis Nivel************************************

int NumOfVertDivisions2=15;      //Divisiones Verticales
int NumOfVertSubDivisions2=15;  // Subdivisiones Verticales
int NumOfBars2=15; 

int ScreenWidth = 600, ScreenHeight = 400;
/////////////////////////////////////////////////////////
boolean firstContact = false;
int[] serialInArray = new int[6];
int serialCount = 0;
///////////////////////////////////////////////
int LeftMargin=100;
int RightMArgin=80;
int TextGap=50;
int GraphYposition=80;
float BarPercent = 0.4;
int value;
PFont font;
PImage bg;
int temp;
float yRatio = 0.58;
int BarGap, BarWidth, DivisounsWidth;
int[] bars = new int[NumOfBars];

//*******************************************************

 import processing.serial.*;
 Serial myPort;        // The serial port
 int xPos = 84;        //Donde arranca el grafico horizontalmente

//******************************************************* 

final String ss="Mover el mouse aquí\nO haga click derecho en cualquier lado ...";
String s=ss;
int mill;
int n = 0;

//*******************************************************

  //int d = day();    
  //int m = month();  
  //int y = year();  
  int sec = 0;
  int startingTime;
  int seconds; 
  int minutes;
  int hours;
  
//*******************************************************

int xPosOld = 84;

//*******************************************************

void setup()
{
   
if(n==0)
{
  myPort = new Serial(this, Serial.list()[1], 9600);
  a = loadImage("acuario.jpg"); 
  size(600,400); //Defino widht y height
  if (frame!=null) 
  frame.setResizable(true);
  background(0);
  font = loadFont("Arial.vlw"); 
  textFont(font, 15);
  
  fill(108,227,114); // Color de letra de "mover el mouse aqui"
  setupMainMenu(); // setup main menu
} 

if(n==1||n==2||n==3)
{

    font = loadFont("agency.vlw"); 
    textFont(font, 20); 
    if(n==1)
    { 
     background(235,242,51); 
    } 
    if(n==2)
    {
     background(111,232,110);
    }//cierro if(n==2) 
    if(n==3)
    {    
     background(57,220,224);  
    }
/*	
//********************************************************* 
  int s2 = second();  // Values from 0 - 59
  int m2 = minute();  // Values from 0 - 59
  int h2 = hour();    // Values from 0 - 23
  String x = String.valueOf(h2);
  fill(6,57,35);
  text(x, 270, 20);
  text(":", 300, 20);
  x = String.valueOf(m2);
  text(x, 310, 20); 
  text(":", 340, 20);
  x = String.valueOf(s2);
  text(x, 350, 20);
  //*********************************************************
 */
}//cierro if(n==1)

}//cierro void setup
//***************************************************************************
void draw()
{
  
 if(n==0) // n==0 estoy en la pantalla principal
 { 
  image(a, 0, 0, a.width, a.height); //cargo la imagen de fondo con sus dimensiones originales
  //text(font, 20);
  text("Proyecto Final", 5, 330);
  text("- Rolando Sebastian", 80, 357);
  text("- Trellini Bruno", 80, 385);
  
  /* 
  //Flecha en el menú principal
  stroke(g.fillColor); 
  if (s.length()>30) 
  { // Dibujo Línea
    pushMatrix();
      translate(20,20); rotate(PI/4);
      line(15,0,85,0); 
      triangle(0,0,15,-3,15,3);
    popMatrix();
  }
  text(s, (width-textWidth(s))/2,150);
  if ((millis()-mill)>3000) s=ss;
  */
 }//cierro if n==0
//************************************
if(n==1) //Temperatura
{
  Axis();
  Labels();
  String inString = myPort.readStringUntil('\n');
  
  if(inString != null) 
  {
   
   inString = trim(inString);
   float inByte = float(inString); 
   inByte = map(inByte, 0, 40, 0, height);
   
    stroke(73,50,234); //linea color azul
    line(xPos, height - 81, xPos, (319-2*inByte/3)+16); // Para 20ºC inByte vale 200,000 pq es un float
    stroke(229,39,39); //linea color rojo
    line(xPos, height - 81, xPos, (319-2*inByte/3+18));
    font = loadFont("agency.vlw"); 
    textFont(font, 20); 
    stroke(235,242,51); //linea color amarillo
    line(xPos, height - 81, xPos, (319-2*inByte/3+20));
    //**************************************************************
	if((inByte/10) <= 18 || (inByte/10) >= 22) //Alerta
	{
	 stroke(46,40,41);
	 fill(247,0,21); //rojo
	 ellipse(550, 50, 30, 30);
	 //text("Alarma", 520, 30);
	 //saveFrame("AlarmaTemp-####.jpeg");
	}
	else
	{
	 stroke(46,40,41);
	 fill(20,193,18); // verde
	 ellipse(550, 50, 30, 30);
	}
    //**************************************************************
    int seconds = (millis() - startingTime) / 1000;
	//seconds1 = seconds ;
	
	int minutes = seconds / 60;
	
	seconds = seconds - 60 * minutes;
	
    //int hours = minutes / 60;
    fill(6,57,35); // color del texto que me indica la tamperatura y el tiempo	
	
	if(xPos > (xPosOld +90)) // Lo hago para actualizar al haber recorrido 100 pixels.
	{
	xPosOld = xPos;
	//font = loadFont("Arial.vlw");  //Fuente todos los labels 
    textFont(font,16);  //Tamaño de fuente del label del eje vertical
	text(minutes, xPos, (319-2*inByte/3)+5); //minutos
    text(":", (xPos + 13), (319-2*inByte/3)+2); // separador :
    text(seconds, (xPos + 20), (319-2*inByte/3)+5); //segundos
	
	/*
    String x = String.valueOf(m1);
    text(x, xPos, (319-2*inByte/3)+5); //minutos
    text(":", (xPos + 21), (319-2*inByte/3)+2); // separador :
    x = String.valueOf(s1);
    text(x, (xPos + 30), (319-2*inByte/3)+5); //segundos
	*/
	text((inByte/10), xPos-10, (319-2*inByte/3)-16); //temperatura
	text("ºC",xPos+40,(319-2*inByte/3)-16);
	stroke(28,21,21); //linea color oscuro
	line(xPos, height - 75, xPos,(319-2*inByte/3)+12);
    //text(":", 340, 20);
    //x = String.valueOf(s2);
    //text(x, 350, 20);
    }
   if (xPos >= width - 30) 
        {
		  saveFrame("Temp-####.jpeg"); 
		  //save("Temp.jpeg");
          xPos = 84;//Posicion de x donde vuelve a comenzar el grafico
		  xPosOld = 84;
          background(235,242,51); //Cuando se para de una ventana el color de fondo
        } 
     else 
      {
          // increment the horizontal position:
          xPos++;
		  
      }//cierro else
  }//cierro if(inString != null)
 
}//cierro if(n==1) 

if(n==2) //Caudal
{
  Axis1();
  Labels1();
  String inString = myPort.readStringUntil('\n');

  if(inString != null) 
  {
   // trim off any whitespace:
   inString = trim(inString);
   // convert to an int and map to the screen height:
   float inByte = float(inString); 
   inByte = map(inByte, 0, 1023, 0, height);
 
   // draw the line:
   stroke(73,50,234); //linea color azul
   line(xPos, height - 81, xPos, (height - inByte - 78)*(-4));
   stroke(229,39,39); //linea color azul
   line(xPos, height - 81, xPos, (height - inByte - 79)*(-4));
   font = loadFont("agency.vlw"); 
   textFont(font, 20); 
   stroke(111,232,110); 
   line(xPos, height - 81, xPos, (height - inByte - 80)*(-4));
   if (xPos >= width - 30) 
        {
		  saveFrame("Caudal-##.jpeg"); 
          xPos = 84;//Posicion de x donde vuelve a comenzar el grafico
          background(111,232,110);
        }  
     else 
      {
          // increment the horizontal position:
          xPos++;
		  
      }//cierro else
  }//cierro if(inString != null)
 
}//cierro if(n==2) 
if(n==3) //Nivel
{
 Axis2();
 Labels2();
 String inString = myPort.readStringUntil('\n');

  if(inString != null) 
  {
   // trim off any whitespace:
   inString = trim(inString);
   // convert to an int and map to the screen height:
   float inByte = float(inString); 
   inByte = map(inByte, 0, 1023, 0, height);
 
   // draw the line:
   stroke(73,50,234); //linea color azul
   line(xPos, height - 81, xPos, (height - inByte - 78)*(-4));
   stroke(229,39,39); //linea color azul
   line(xPos, height - 81, xPos, (height - inByte - 79)*(-4));
   font = loadFont("agency.vlw"); 
   textFont(font, 20); 
   stroke(57,220,224); 
   line(xPos, height - 81, xPos, (height - inByte - 80)*(-4));
   
     if (xPos >= width - 30) 
        {
		  saveFrame("Nivel-##.jpeg"); 
          xPos = 84;//Posicion de x donde vuelve a comenzar el grafico
          background(57,220,224);
	    } 
     else 
      {
          // increment the horizontal position:
          xPos++;
		  
      }//cierro else
  }//cierro if(inString != null)
  
}//cierro if(n==3) 

}//cierro void draw

//*************************************************************************

void mouseClicked()
{
  mill=millis();
  if (mouseButton==RIGHT) 
  popupMenu(); 
}

//*************************************************************************

void setupMainMenu()
{
    SMenu m=new SMenu(this); // create new main menu (at 0,0)

//*************************************************************************************************

  m.SMSubM("Temperatura"); // new submenu 
    m.SMItem("Medir            ",new actn(){public void a(){fOpen();}}); // Voy a la funcion fOpen()    
    m.SMEnd();
    
  m.SMSubM("Caudal     ");
    m.SMItem("Medir       ",new actn(){public void a(){fOpen1();}}); // Voy a la funcion fOpen1()
    m.SMEnd();
    
//*************************************************************************************************

  m.SMSubM("Nivel         ");
    m.SMItem("Medir       ",new actn(){public void a(){fOpen2();}}); // Voy a la funcion fOpen1()
    m.SMEnd();
  m.SMEnd(); // end all with SMEnd() 

 
}//cierro void setupMainMenu()

//*************************************************************************************************
void fOpen() //Temperatura
{ 
  
  n=1;
  xPos = 84; //cuando paso de un gráfico a otro reinicio la referencia
  xPosOld = 84;
  //int s = second();  // Cuando comienzo a graficar temperatura tomo el tiempo de base
  //int m = minute();  // 
  //int h = hour();    // 
  startingTime = millis();
  setup();
  draw();
}//cierro fOpen()

//*********************

void fOpen1()//Caudal
{ 
  n=2;
  xPos = 84;
  setup();
  draw();
   
}//cierro fOpen()

//*********************

void fOpen2()//Caudal
{ 
  n=3;
  xPos = 84;
  setup();
  draw();
}//cierro fOpen()

//**********************

void fSaveAs()
{
  s="Save as clicked";
}

//**************************

void About()
{
  s="Simple Menu for Processing";
}

//-----------------------------------------------------------------------
// Popup Menu
//-----------------------------------------------------------------------

void popupMenu()
{
  SMenu p=new SMenu(this,mouseX,mouseY);
  p.SMItem("Cierro",new actn(){public void a(){pPng();}});//s="Popup red clicked";fill(#FF0000);}}); 
  p.SMEnd();
}

void pPng()
{ // your code here ...
  n=0;
  xPos = 84;
  font = loadFont("Arial.vlw"); 
  textFont(font, 15);
  sec = 0;
  fill(108,227,114); // Color de letra de "mover el mouse aqui"
  setupMainMenu(); // setup main menu
  
}

//*********************************Temperatura********************************************
void Axis()
{
  strokeWeight(1);
  stroke(0); //color lineas horizontales
  
  /*
  //interlineado
  for(float x=0;x<=NumOfVertSubDivisions;x++)
  {
  int bars=(ScreenHeight-GraphYposition)-int(yRatio*(ScreenHeight)*(x/NumOfVertSubDivisions));
  line(LeftMargin-15,bars,ScreenWidth-RightMArgin-DivisounsWidth+50,bars);
  }//cierro for
  strokeWeight(1);
  stroke(0); // color del interlineado horizontal 
  */
  /*
  //Lineas principales
  for(float x=0;x<=NumOfVertDivisions;x++)
  {
    int bars=(ScreenHeight-GraphYposition)-int(yRatio*(ScreenHeight)*(x/NumOfVertDivisions));
    line(LeftMargin-15,bars,ScreenWidth-RightMArgin-DivisounsWidth+50,bars);
  }//cierro for
  */
  
  line(LeftMargin-15,204,ScreenWidth-RightMArgin + 50,204); //20ºC
  line(LeftMargin-15,230,ScreenWidth-RightMArgin + 50,230); //10ºC
  line(LeftMargin-15,170,ScreenWidth-RightMArgin + 50,170); //25ºC
  line(LeftMargin-15,140,ScreenWidth-RightMArgin + 50,140); //30ºC
  
  strokeWeight(2);
  stroke(39,227,59); //color 22ºC verde
  line(LeftMargin-15,190,ScreenWidth-RightMArgin + 50,190); //22ºC Ideal
  
  font = loadFont("agency.vlw");  //Fuente todos los labels 
  textFont(font,12);  //Tamaño de fuente del label del eje vertical
  fill(50);
  text("20 ºC",LeftMargin-50, 205);
  text("22 ºC",LeftMargin-50, 190);
  text("25 ºC",LeftMargin-50, 175);
  text("10 ºC",LeftMargin-50, 235);
  text("30 ºC",LeftMargin-50, 145);
  //Ejes
  strokeWeight(2);
  stroke(0);  // color de los ejes
  line(LeftMargin-15, ScreenHeight-GraphYposition+2, ScreenWidth-RightMArgin-DivisounsWidth+50, ScreenHeight-GraphYposition+2);
  line(LeftMargin-15,ScreenHeight-GraphYposition+2,LeftMargin-15,GraphYposition);
  strokeWeight(1);
  
}//cierro void Axis

void Labels()
{
  font = loadFont("agency.vlw");  //Fuente todos los labels 
  textFont(font,25);  //Tamaño de fuente del label del eje vertical
  fill(50);
  rotate(radians(-90)); // roto el label del eje vertical a 90º antihorar
  text(yLabel,-ScreenHeight/2+20,LeftMargin-70); //con los 2 ultimos parametros corrijo la posicion del texto
  textFont(font,16); //numeros escala vertival
  /*
  for(float x=0;x<=NumOfVertDivisions;x++)
  {
    int bars=(ScreenHeight-GraphYposition)-int(yRatio*(ScreenHeight)*(x/NumOfVertDivisions));
    text(round(x),-bars,LeftMargin-20); //números eje vertival
  } 
  */
  textFont(font,30);
  rotate(radians(90));
  text(xLabel,LeftMargin+(ScreenWidth-LeftMargin-RightMArgin-50)/2,ScreenHeight-GraphYposition+40); //Posicion de "Tiempo"
  textFont(font,30);
  fill(50);
  text(Heading,LeftMargin+(ScreenWidth-LeftMargin-RightMArgin-180)/2,70);// Posicion de Potenciometro Nivel""
  textFont(font,30);  //Fecha

  fill(50);
  text(URL,ScreenWidth-RightMArgin-40,ScreenHeight-15);
  textFont(font,10);

}//cierro void labels

//**************************Caudal**************************************************
void Axis1()
{
  strokeWeight(1);
  stroke(0); //color lineas horizontales
  for(float x=0;x<=NumOfVertSubDivisions1;x++)
  {
  int bars=(ScreenHeight-GraphYposition)-int(yRatio*(ScreenHeight)*(x/NumOfVertSubDivisions1));
  line(LeftMargin-15,bars,ScreenWidth-RightMArgin-DivisounsWidth+50,bars);
  }//cierro for
  strokeWeight(1);
  stroke(0); // color del interlineado horizontal 
  for(float x=0;x<=NumOfVertDivisions1;x++)
  {
    int bars=(ScreenHeight-GraphYposition)-int(yRatio*(ScreenHeight)*(x/NumOfVertDivisions1));
    line(LeftMargin-15,bars,ScreenWidth-RightMArgin-DivisounsWidth+50,bars);
  }//cierro for
  strokeWeight(2);
  stroke(0);  // color de los ejes
  line(LeftMargin-15, ScreenHeight-GraphYposition+2, ScreenWidth-RightMArgin-DivisounsWidth+50, ScreenHeight-GraphYposition+2);
  line(LeftMargin-15,ScreenHeight-GraphYposition+2,LeftMargin-15,GraphYposition);
  strokeWeight(1);
}//cierro void Axis

void Labels1()
{
  font = loadFont("agency.vlw");  //Fuente todos los labels 
  textFont(font,25);  //Tamaño de fuente del label del eje vertical
  fill(50);
  rotate(radians(-90)); // roto el label del eje vertical a 90º antihorar
  text(yLabel1,-ScreenHeight/2-80,LeftMargin-50); //con los 2 ultimos parametros corrijo la posicion del texto
  textFont(font,16); //numeros escala vertival
  for(float x=0;x<=NumOfVertDivisions1;x++)
  {
    int bars=(ScreenHeight-GraphYposition)-int(yRatio*(ScreenHeight)*(x/NumOfVertDivisions1));
    text(round(x),-bars,LeftMargin-20);
  } 
  textFont(font,30);
  rotate(radians(90));
  text(xLabel1,LeftMargin+(ScreenWidth-LeftMargin-RightMArgin-50)/2,ScreenHeight-GraphYposition+40); //Posicion de "Tiempo"
  textFont(font,30);
  fill(50);
  text(Heading1,LeftMargin+(ScreenWidth-LeftMargin-RightMArgin-180)/2,70);// Posicion de Potenciometro Nivel""
  textFont(font,30);  //Fecha

  fill(50);
  text(URL,ScreenWidth-RightMArgin-40,ScreenHeight-15);
  textFont(font,10);

}//cierro void labels

//****************************Nivel***********************************************************
void Axis2()
{
  strokeWeight(1);
  stroke(0); //color lineas horizontales
  for(float x=0;x<=NumOfVertSubDivisions2;x++)
  {
  int bars=(ScreenHeight-GraphYposition)-int(yRatio*(ScreenHeight)*(x/NumOfVertSubDivisions2));
  line(LeftMargin-15,bars,ScreenWidth-RightMArgin-DivisounsWidth+50,bars);
  }//cierro for
  strokeWeight(1);
  stroke(0); // color del interlineado horizontal 
  for(float x=0;x<=NumOfVertDivisions2;x++)
  {
    int bars=(ScreenHeight-GraphYposition)-int(yRatio*(ScreenHeight)*(x/NumOfVertDivisions2));
    line(LeftMargin-15,bars,ScreenWidth-RightMArgin-DivisounsWidth+50,bars);
  }//cierro for
  strokeWeight(2);
  stroke(0);  // color de los ejes
  line(LeftMargin-15, ScreenHeight-GraphYposition+2, ScreenWidth-RightMArgin-DivisounsWidth+50, ScreenHeight-GraphYposition+2);
  line(LeftMargin-15,ScreenHeight-GraphYposition+2,LeftMargin-15,GraphYposition);
  strokeWeight(1);
}//cierro void Axis

void Labels2()
{
  font = loadFont("agency.vlw");  //Fuente todos los labels 
  textFont(font,25);  //Tamaño de fuente del label del eje vertical
  fill(50);
  rotate(radians(-90)); // roto el label del eje vertical a 90º antihorar
  text(yLabel2,-ScreenHeight/2-80,LeftMargin-50); //con los 2 ultimos parametros corrijo la posicion del texto
  textFont(font,16); //numeros escala vertival
  for(float x=0;x<=NumOfVertDivisions2;x++)
  {
    int bars=(ScreenHeight-GraphYposition)-int(yRatio*(ScreenHeight)*(x/NumOfVertDivisions2));
    text(round(x),-bars,LeftMargin-20);
  } 
  textFont(font,30);
  rotate(radians(90));
  text(xLabel2,LeftMargin+(ScreenWidth-LeftMargin-RightMArgin-50)/2,ScreenHeight-GraphYposition+40); //Posicion de "Tiempo"
  textFont(font,30);
  fill(50);
  text(Heading2,LeftMargin+(ScreenWidth-LeftMargin-RightMArgin-180)/2,70);// Posicion de Potenciometro Nivel""
  textFont(font,30);  //Fecha

  fill(50);
  text(URL,ScreenWidth-RightMArgin-40,ScreenHeight-15);
  textFont(font,10);

}//cierro void labels
