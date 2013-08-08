// Serial Library
import processing.serial.*;
Serial serialIn;
SerialData serialData;

// Kinect library
import SimpleOpenNI.*;
SimpleOpenNI kinect;
KinectData kinectData;

ColorArrays colorArray;

// JAVA Bridge -- needed to minimize window
import javax.swing.*;

// Writer to text file
PrintWriter output; 
String position;
String colors;

// kinect image sizes, they don't get bigger than this
int kinWidth = 640;
int kinHeight = 480;

int screenW = 1024;
int screenH = 768;

// makes our sketch full screen
/*
boolean sketchFullScreen() 
{
  return true;
}
*/

// Init
void setup()
{
  //frameRate( 60 );
  size(screenW , screenH);
    
  println("Starting Serial");
  println( Serial.list() );
  serialIn = new Serial(this, Serial.list()[0], 115200 );
  serialData = new SerialData( serialIn );
  println("Serial Initialized");
  if( serialIn.available() == 0 )
  {
    println( "::SETUP - NO SERIAL::");
  }
  
  
  println("Starting Kinect");
  kinect = new SimpleOpenNI( this );
  kinectData = new KinectData(kinect);
  println("Kinect Initialized");
  
  
  colorArray = new ColorArrays();
  
  
  // graphics
  smooth();
  noStroke();
          
  // draw() will only run once, because we need to calibrate
  noLoop();
}

String textKin;

void draw()
{  
  // if it's the first time running, just jump out of draw()
  if( frameCount > 0 )
  {
    
    serialData.update();
    kinectData.update();
    
    if( kinectData.isObjectInRange == true )
    {
      colorArray.update( serialData.getSerialString() );
      colors = colorArray.getColor();
      position = kinectData.collectData();
      printToFile();
    }
  } else 
  { 
    return; 
  }
}

// for testing and calibration 
void mousePressed()
{
  // calibrates then starts loop 
  kinectData.calibrate();
  loop();
  
  // minimizes window to run sketch in background
  this.frame.setExtendedState(JFrame.ICONIFIED);
}

void printToFile( )
{
  output = createWriter("new.txt");
  String data = position + ",\"color\":\"#" + colors + "\"}";
  println( data );
  output.print( data );
  output.flush();
}

