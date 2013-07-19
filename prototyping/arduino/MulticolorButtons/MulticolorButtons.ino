/*
Setup 
red in from button = pin 13;
green in from button = pin 12;
blue in from button = pin 11;

red out from pin 6;
green led pin 5
blue led from pin 4



*/

int redPin = 13;
int redPinValueCurrent;
int redValue;
boolean isRedOn = false;
int redLED = 6;


int greenPin = 12;
int greenPinValueCurrent;
int greenValue;
boolean isGreenOn = false;
int greenLED = 5;

int bluePin = 11;
int bluePinValueCurrent;
int blueValue;
boolean isBlueOn = false;
int blueLED = 4;

void setup()
{
  Serial.begin( 9600 );
  Serial.println( "setup" );
  
  pinMode( redPin , INPUT );
  pinMode( redLED , OUTPUT );
  redValue = digitalRead( redPin );
  
  pinMode( greenPin , INPUT );
  pinMode( greenLED , OUTPUT );
  greenValue = digitalRead( greenPin );
  
  pinMode( bluePin , INPUT );
  pinMode( blueLED , OUTPUT );
  blueValue = digitalRead( bluePin );
  
  Serial.println( "READY" );
  
}


void loop()
{
  getRed();
  getGreen();
  getBlue();
  
  delay( 50 );
}


void getRed()
{
 redPinValueCurrent = digitalRead( redPin );
  Serial.print( "redPinValueCurrent = " );
  Serial.println( redPinValueCurrent );
    digitalWrite( redLED , !redPinValueCurrent );
    
    /*
  if( redPinValueCurrent == HIGH )
  {
    //digitalWrite( redLED , LOW );
    if( redPinValueCurrent != redValue )
    {
      isRedOn = !isRedOn;
    }
  } else
  {
    //digitalWrite( redLED , HIGH );
  }
  redValue = redPinValueCurrent;
  
  Serial.print( "isRedOn: " );
  Serial.println( isRedOn ); 
  digitalWrite( redLED , !isRedOn );
  */
}



void getGreen()
{
  greenPinValueCurrent = digitalRead( greenPin );
  Serial.print( "GreenPinValueCurrent = " );
  Serial.println( greenPinValueCurrent );
    digitalWrite( greenLED , !greenPinValueCurrent );
    
    /*
  if( greenPinValueCurrent == HIGH )
  {
    //digitalWrite( greenLED , LOW );
    if( greenPinValueCurrent != greenValue )
    {
      isGreenOn = !isGreenOn;
    }
  } else 
  {
    //digitalWrite( greenLED , HIGH );
  }
  greenValue = greenPinValueCurrent;
  
  Serial.print( "isGreenOn: " );
  Serial.println( isGreenOn ); 
  
   digitalWrite( greenLED , !isGreenOn );
  */
}

void getBlue()
{
  bluePinValueCurrent = digitalRead( bluePin );
  Serial.print( "BluePinValueCurrent = " );
  Serial.println( bluePinValueCurrent );
  digitalWrite( blueLED , !bluePinValueCurrent );
  /*  
  if( bluePinValueCurrent == HIGH )
  {
    
    //digitalWrite( blueLED , LOW );
    if( bluePinValueCurrent != blueValue )
    {
      isBlueOn = !isBlueOn;
    }
  } else 
  {
    //digitalWrite( blueLED , HIGH );
  }
  blueValue = bluePinValueCurrent;
  
  Serial.print( "isBlueOn: " );
  Serial.println( isBlueOn ); 
  
  digitalWrite( blueLED , !isBlueOn );
  */
}
