import SimpleOpenNI.*;
SimpleOpenNI kinect;

int closestValue;
int closestX , closestY;
int currentX , currentY ;
float previousX , previousY ;

float prevX , prevY;
float minDistance;
float maxDistance; 

int distanceFromWall = 60;
int handSize = 130;

int kinWidth = 640;
int kinHeight = 480;


boolean sketchFullScreen() {
  return true;
}

void setup()
{
	frameRate( 60 );
	size( displayWidth , displayHeight );

	kinect = new SimpleOpenNI( this );
	if( kinect.enableDepth() == false )
        {
           println("Can't open the depthMap, maybe the camera is not connected!"); 
           exit();
           return;
        }
        
        kinect.enableRGB();
        
        kinect.update();
        PImage img = kinect.depthImage();
        image( img , 0 , 0 );
        
        
        noLoop();
}


void draw()
{
  if( frameCount == 0 )
  { return; }
  
  

	closestValue = 8000;

	kinect.update();
	int[] depthValues = kinect.depthMap();

        //PImage img = kinect.depthImage();
        //image( img , 0 , 0 );

	for( int y = 0 ; y < kinHeight ; y++ )
	{
		for( int x = 0 ; x < kinWidth ; x++ )
		{
                        //int reversedX = 640 - x - 1;
			//int i = reversedX + y * 640 ;
      
                        int i = x + y * kinWidth ;
			int currentDepthValue = depthValues[i];
			if( currentDepthValue > minDistance && currentDepthValue < maxDistance && currentDepthValue < closestValue )
			{
				closestValue = currentDepthValue;
				currentX = x;
				currentY = y;
			} 
		}
	}

  
        float interpX = lerp( previousX , currentX , 0.3f );
        float interpY = lerp( previousY , currentY , 0.3f );
        
        float transX = map( interpX , 0 , kinWidth , 0 , width );
        float transY = map( interpY , 0 , kinHeight , 0 , height );
        
        if( previousY >= 1 && previousX < width )
        {
          //noStroke();
         // fill( #dddddd , 10 ); 
          //rect( 0 , 0 , width , height );
          //stroke( #FF0000 );
         // line( previousX , previousY , interpX , interpY );
         

  
         
         makeMark( transX , transY );
        }
        
        
        previousX = interpX ; 
        previousY = interpY ;
        
        prevX = transX;
        prevY = transY;
}



void makeMark(float x , float y)
{
    noStroke();
        
    fill( 255 , 0 , 0 , 128 );
    ellipse( x , y , 10 , 10 ); 
    println( "X = " + x  +  "     Y = " + y ); 

    stroke( #FF0000 );
    noFill();
    line( prevX , prevY , x , y );
    
    
    
}

void mousePressed()
{
  int[] depthVal = kinect.depthMap();
  int clickPosition = mouseX + ( mouseY * kinWidth );
  int pos = depthVal[ clickPosition ];
  
  maxDistance = pos - distanceFromWall;
  minDistance = pos - distanceFromWall - handSize;
  
  println("Max = " + maxDistance + "   Min = " + minDistance );
  
  noStroke();
  fill( 255 );
  rect( 0 , 0 , width , height );
  
  //PImage img = kinect.rgbImage();
  //image( img , 0 , 0 );
  
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
