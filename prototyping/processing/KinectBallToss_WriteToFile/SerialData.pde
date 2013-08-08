import processing.serial.*;

class SerialData
{
  
  Serial serial;
  String arduinoString;
  int lf = 10;

  
  SerialData( Serial ser )
  {
    serial = ser;
    serial.clear();
    arduinoString = serial.readStringUntil(lf);
    arduinoString = null;
  }
  
  void update()
  {
    //*/
    if( serial.available() == 0 )
    {
      println("THERE'S NO SERIAL");
    }
    //*/
    while( serial.available() > 0 )
    {
       String inString = serial.readStringUntil(lf);
       if( inString != null)
       { 
         //println( "inString = " + inString );
         arduinoString = trim(inString);
       }
     }
    
  }
  
  String getSerialString()
  {
    // println( "arduino string = " + arduinoString );
    return arduinoString;
  }
  
}
