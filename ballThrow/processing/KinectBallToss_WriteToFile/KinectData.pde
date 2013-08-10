
//import SimpleOpenNI.*;

class KinectData
{
  
  SimpleOpenNI kin;

   // values to determine object distance  
  int closestValue;
  int closestX , closestY;
  int currentX , currentY;
  
  boolean isObjectInRange = false;

  // values to determine distance range where the ball can be found
  float minDistance;
  float maxDistance; 
  int distanceFromWall = 20;
  int ballSize = 100;


  KinectData(SimpleOpenNI k)
  {
    // initialize our kinect, check if we have kinect available and enable depthImage
    kin = k;
    if( kin.enableDepth() == false )
    {
      println("Can't open the depthMap, maybe the camera is not connected!"); 
      exit();
      return;
    }
            
    // allow rgb image usage
    //kin.enableRGB();
    // update from kinect, this needs to run anytime we want to grab new data from kinect
    kin.update();
            
    // grab an image from kinect depthImage and display it
    PImage img = kin.depthImage();
    image( img , 0 , 0 );
           
  }
  
  float transX , transY;
  
  void update()
  {
    // set this every loop so we can get new values
    closestValue = 8000;
            
    // update the kinect and create an array from the depth data
    kin.update();
    int[] depthValues = kin.depthMap();
        
    // iterate through the height and width of the depthMap data to find 
    // the corresponding depth by pixel
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
            isObjectInRange = true;
          }
        }
      }
  
    // map the closest pixel x y to an x y on the actual screen
    transX = map( currentX , 0 , kinWidth , 0 , width );
    transY = map( currentY , 0 , kinHeight , 0 , height );
  }
  
  
  String txt;
  
  String collectData()
  {
    // text to be sent to file
    txt = "{\"x\":"+transX + ",\"y\":" + transY; // + ",\"z\":" + "0" + ",\"h\":" + "0" + ",\"w\":" + "0";

    //turn off object in range. we only want to send data when it is.
    isObjectInRange = false;
    
    return txt;
    
  }
  
  void calibrate()
  {
    int[] depthVal = kin.depthMap();
    int clickPosition = mouseX + ( mouseY * kinWidth );
    int pos = depthVal[ clickPosition ];
  
    maxDistance = pos - distanceFromWall;
    minDistance = pos - distanceFromWall - ballSize;
  
    println("Max = " + maxDistance + "   Min = " + minDistance );
  }
}
