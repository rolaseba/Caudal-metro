// Feel Free to edit these variables ///////////////////////////
String  xLabel = "Tiempo";
String  yLabel = "Nivel de Agua (Cm)";
String  Heading = "Potenciometro Nivel";
String  URL = "24/05/2011";
float Vcc = 5.0;    // the measured voltage of your usb
int NumOfVertDivisions=10;      //Divisiones Verticales
int NumOfVertSubDivisions=20;  // Subdivisiones Verticales

int NumOfBars=5;    
// if these are changed, background image has problems
// a plain background solves the problem
int ScreenWidth = 600, ScreenHeight=400;
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
 void setup () 
 {
     size(600, 400);      
     font = loadFont("agency.vlw"); 
     //textFont(font, 20); 
     //  font = createFont("Arial",12);
     textAlign(CENTER); //Alineación del texto superior e inferior "Potenciometro y Nivel "
     textFont(font, 30);
     myPort = new Serial(this, Serial.list()[1], 9600);
     background(235,242,51);
 }//cierro void setup
//*******************************************************
 void draw () 
 {
  Axis();
  Labels();
   String inString = myPort.readStringUntil('\n');
 
  if (inString != null) 
  {
   // trim off any whitespace:
   inString = trim(inString);
   // convert to an int and map to the screen height:
   float inByte = float(inString); 
   inByte = map(inByte, 0, 1023, 0, height);
 
   // draw the line:
   stroke(73,50,234); //linea color azul
   line(xPos, height+200, xPos, (height - inByte - 78)*(-4));
   stroke(229,39,39); //linea color azul
   line(xPos, height+200, xPos, (height - inByte - 79)*(-4));
   stroke(235,242,51); //linea color amarillo
   line(xPos, height+200, xPos, (height - inByte - 80)*(-4));
 
   // at the edge of the screen, go back to the beginning:
     if (xPos >= width - 30) 
        {
          xPos = 84;//Posicion de x donde vuelve a comenzar el grafico
          background(235,242,51); //Cuando se para de una ventana el color de fondo
        } 
     else 
      {
          // increment the horizontal position:
          xPos++;
      }//cierro else
  }//cierro if(inString != null)
 }//cierro void draw
 
 //
 
 void serialEvent (Serial myPort) 
 {
 // get the ASCII string:

 }//cierro void serialEvent
 
void Axis()
{
  strokeWeight(1);
  stroke(0); //color lineas horizontales
  for(float x=0;x<=NumOfVertSubDivisions;x++)
  {
  int bars=(ScreenHeight-GraphYposition)-int(yRatio*(ScreenHeight)*(x/NumOfVertSubDivisions));
  line(LeftMargin-15,bars,ScreenWidth-RightMArgin-DivisounsWidth+50,bars);
  }//cierro for
  strokeWeight(1);
  stroke(0); // color del interlineado horizontal 
  for(float x=0;x<=NumOfVertDivisions;x++)
  {
    int bars=(ScreenHeight-GraphYposition)-int(yRatio*(ScreenHeight)*(x/NumOfVertDivisions));
    line(LeftMargin-15,bars,ScreenWidth-RightMArgin-DivisounsWidth+50,bars);
  }//cierro for
  strokeWeight(2);
  stroke(0);  // color de los ejes
  line(LeftMargin-15, ScreenHeight-GraphYposition+2, ScreenWidth-RightMArgin-DivisounsWidth+50, ScreenHeight-GraphYposition+2);
  line(LeftMargin-15,ScreenHeight-GraphYposition+2,LeftMargin-15,GraphYposition);
  strokeWeight(1);
}//cierro void Axis

void Labels()
{
  font = loadFont("agency.vlw"); 
  textFont(font,25);  // label eje vertival "Voltage"
  fill(50);
  rotate(radians(-90)); // roto el label del eje vertical a 90º antihorar
  text(yLabel,-ScreenHeight/2,LeftMargin-45);
  textFont(font,16); //numeros escala vertival
  for(float x=0;x<=NumOfVertDivisions;x++)
  {
    int bars=(ScreenHeight-GraphYposition)-int(yRatio*(ScreenHeight)*(x/NumOfVertDivisions));
    text(round(x),-bars,LeftMargin-20);
  } 
  textFont(font,30);
  rotate(radians(90));
  text(xLabel,LeftMargin+(ScreenWidth-LeftMargin-RightMArgin-50)/2,ScreenHeight-GraphYposition+40);
  textFont(font,30);
  fill(50);
  text(Heading,LeftMargin+(ScreenWidth-LeftMargin-RightMArgin-50)/2,70);
  textFont(font,30);  //Fecha

  fill(50);
  text(URL,ScreenWidth-RightMArgin-40,ScreenHeight-15);
  textFont(font,10);

}//cierro void labels


