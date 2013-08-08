int redReadPin = 3;
int greenReadPin = 4;
int blueReadPin = 5;

int redValue;
int greenValue;
int blueValue;

int value;
String valueS;


void setup()
{
  Serial.begin( 115200 );
  pinMode( redReadPin , INPUT );
  pinMode( greenReadPin , INPUT );
  pinMode( blueReadPin , INPUT );
}

void loop()
{
  redValue = digitalRead( redReadPin );
  greenValue = digitalRead( greenReadPin );
  blueValue = digitalRead( blueReadPin );
  
  checkValues();
  
  Serial.println( valueS );
  delay( 50 );
}


void checkValues()
{
  if( redValue == 0 && greenValue == 0 && blueValue == 0 )
  {
    valueS = "off";
  } 
  else if ( redValue == 1 && greenValue == 0 && blueValue == 0 )
  {
    valueS = "red";
  } 
  else if ( redValue == 1 && greenValue == 1 && blueValue == 0 )
  {
    valueS = "yellow";
  }
  else if ( redValue == 0 && greenValue == 1 && blueValue == 0 )
  {
    valueS = "green";
  } 
  else if ( redValue == 0 && greenValue == 1 && blueValue == 1 )
  {
    valueS = "cyan";
  } 
  else if ( redValue == 0 && greenValue == 0 && blueValue == 1 )
  {
    valueS = "blue";
  } 
  else if ( redValue == 1 && greenValue == 0 && blueValue == 1 )
  {
    valueS = "violet";
  } 
  else if ( redValue == 1 && greenValue == 1 && blueValue == 1 )
  {
    valueS = "on";
  } 
}
