// Kinect library
import SimpleOpenNI.*;
SimpleOpenNI kinect;

// values to determine object distance
int closestValue;
int closestX , closestY;
int currentX , currentY ;
float previousX , previousY ;

// values to determine distance range where the ball can be found
float minDistance;
float maxDistance; 
int distanceFromWall = 20;
int ballSize = 100;

// kinect image sizes, they don't get bigger than this
int kinWidth = 640;
int kinHeight = 480;

// makes our sketch full screen
boolean sketchFullScreen() {
  return true;
}


// Init
void setup()
{
	frameRate( 60 );
	size( displayWidth , displayHeight );

        // initialize our kinect, check if we have kinect available and enable depthImage
	kinect = new SimpleOpenNI( this );
	if( kinect.enableDepth() == false )
        {
           println("Can't open the depthMap, maybe the camera is not connected!"); 
           exit();
           return;
        }
        // allow rgb image usage
        kinect.enableRGB();
        // update from kinect, this needs to run anytime we want to grab new data from kinect
        kinect.update();
        
        // grab an image from kinect depthImage and display it
        PImage img = kinect.depthImage();
        image( img , 0 , 0 );
        
        // graphics
        smooth();
        noStroke();
        
        // draw() will only run once, and we need to calibrate
        noLoop();
        
}


void draw()
{
  // if it's the first time running, just jump out of draw()
  if( frameCount == 0 )
  { return; }
  
  // set this every loop so we can get new values
  closestValue = 8000;

  // update the kinect and create an array from the depth data
  kinect.update();
  int[] depthValues = kinect.depthMap();

  // iterate through the height and width of the depthMap data to find 
  //the corresponding depth by pixel
  for( int y = 0 ; y < kinHeight ; y++ )
  {
    for( int x = 0 ; x < kinWidth ; x++ )
    {
      // i is the current pixel we are looking at 
      int i = x + y * kinWidth ;
      // currentDepthValue is the value of the depth data of this pixel
      int currentDepthValue = depthValues[i];
      // compare the current pixel's depth value with the min and max distance
      // values we came up with earlier as well as the closestValue which is set here
      // set the current x and current y based on this pixel we are checking in this array.
      if( currentDepthValue > minDistance && currentDepthValue < maxDistance && currentDepthValue < closestValue )
      {
        closestValue = currentDepthValue;
	currentX = x;
	currentY = y;
      } 
    }
  }
  
  // map the closest pixel x y to an x y on the actual screen
  float transX = map( currentX , 0 , kinWidth , 0 , width );
  float transY = map( currentY , 0 , kinHeight , 0 , height );

  // In range? do something.
  if( closestValue > minDistance && closestValue < maxDistance )
  {
    //createRGBImage();
    fill( #FF0000 , 120 );
    ellipse( transX , transY , 20 , 20 );
    
    Splatter s = new Splatter( );
    s.drawSplatter( transX , transY , 30 , 10 );
    
    println( "closestValue = " + closestValue );
    println( "X = " + transX + "   Y = " + transY );
  }
  
}

// for testing and calibration 
void mousePressed()
{
  int[] depthVal = kinect.depthMap();
  int clickPosition = mouseX + ( mouseY * kinWidth );
  int pos = depthVal[ clickPosition ];
  
  maxDistance = pos - distanceFromWall;
  minDistance = pos - distanceFromWall - ballSize;
  
  println("Max = " + maxDistance + "   Min = " + minDistance );
  
  //noStroke();
  fill( 255 );
  rect( 0 , 0 , width , height );
  
  //createRGBImage();
  
  
  
  loop();
}

// testing purposes. creates a new rgb image over the top
void keyPressed()
{
  if ( keyPressed )
  {
    if ( key == ENTER || key == RETURN || key == ' ')
    {
      //createRGBImage();
      fill( 255 );
      rect( 0 , 0 , width , height );
  
      println("keypressed");
    }
  } 
}

// testing and calibration purposes
void createRGBImage()
{
  PImage img = kinect.rgbImage();
  image( img , 0 , 0 , width , height );
}
