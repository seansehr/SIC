import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import SimpleOpenNI.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class KinectPixelTracker extends PApplet {


SimpleOpenNI kinect;

int closestValue;
int closestX , closestY;
int currentX , currentY ;
int previousX , previousY ;
float furthestDepth;

int docWidth = 640;
int docHeight = 480;


public void setup()
{
	frameRate( 60 );
	size( docWidth , docHeight );

	//furthestDepth = 96 * 25.4;

	kinect = new SimpleOpenNI( this );
	if( kinect.enableDepth() == false )
        {
           println("Can't open the depthMap, maybe the camera is not connected!"); 
           exit();
           return;
        }
}


public void draw()
{
	closestValue = 8000;

	kinect.update();
	int[] depthValues = kinect.depthMap();

	for( int y = 0 ; y < height ; y++ )
	{
		for( int x = 0 ; x < width ; x++ )
		{
			int i = x + y * 640 ;
			int currentDepthValue = depthValues[i];
			if( currentDepthValue > 0 && currentDepthValue < closestValue )//&& currentDepthValue < furthestDepth )
			{
				closestValue = currentDepthValue;
				currentX = x;
				currentY = y;
			} 
			

		}
	}
  

  	closestX = ( closestX + currentX ) / 2;
  	closestY = ( closestY + currentY ) / 2;

    noStroke();
    
    //PImage img = kinect.depthImage();
    //image( img , 0 , 0 );
    fill( 0xffdddddd , 10 ); 
    rect( 0 , 0 , width , height );
        
    translate( width , 0 );
	fill( 255 , 0 , 0 , 128 );
	//ellipse( closestX , closestY , 20 , 20 ); 

	println( closestValue / 25.4f );

	stroke( 0xffFF0000 );
	line( -previousX , previousY , -closestX , closestY );

	previousX = closestX ; 
	previousY = closestY ;

	//delay( 50 );

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "KinectPixelTracker" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
