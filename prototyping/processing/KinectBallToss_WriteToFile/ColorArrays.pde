class ColorArrays
{
  String[] reds     = { "FF0000" , "E75555" , "EB7B7B" , "aa2b2b" , "8d1717" };
  String[] yellows  = { "FFBA00" , "FFD76C" , "FFF000" , "FFF991" , "D4FF79" };
  String[] greens   = { "A3ED06" , "8DC90B" , "26C90B" , "00FF00" , "149C14" };
  String[] cyans    = { "149C87" , "32D6BD" , "83EFDF" , "60D2F3" , "09B0d4" };
  String[] blues    = { "098AD4" , "0F80C8" , "0F43C8" , "3C69DC" , "0000FF" };
  String[] violets  = { "935CEF" , "621CD5" , "6000FF" , "9000FF" , "D350F9" };
  
  String[] whites   = { "FFBFBF" , "FCFFD9" , "C5FFBF" , "BFE6FF" , "CABFFF" , "F1bFFF" };
  String[] blacks   = { "3E0707" , "9E8600" , "12340A" , "0A3434" , "0A1534" , "2B0A34" };
  
  int colorVar;
  String col;
  
  ColorArrays()
  {
  }
  
  String on = "on";
  String off = "off";
  String red = "red";
  String yellow = "yellow";
  String green = "green";
  String cyan = "cyan";
  String blue = "blue";
  String violet = "violet";
  
  void update( String inString )
  {
     println(inString);
     if(inString != null )
     {
       if( inString.equals(off ) )          { colorVar = 0; }
       else if( inString.equals( on ) )     { colorVar = 1; }
       else if( inString.equals( red ) )    { colorVar = 2; }
       else if( inString.equals( yellow ) ) { colorVar = 3; }
       else if( inString.equals( green ) )  { colorVar = 4; }
       else if( inString.equals( cyan ) )   { colorVar = 5; }
       else if( inString.equals( blue ) )   { colorVar = 6; }
       else if( inString.equals( violet ) ) { colorVar = 7; }
     }
  }
  
  String getColor()
  {
    chooseColor();
    return col;
  }
  
  
  void chooseColor()
  {
    switch( colorVar )
    {
      case 0:
        col = whites[ int( random( whites.length - 1 ) ) ];
        break;
      case 1:
        col = blacks[ int( random( blacks.length - 1 ) ) ];
        break;
      case 2:
        col = reds[ int( random( reds.length - 1 ) ) ];
        break;
      case 3:
        col = yellows[ int( random( yellows.length - 1 ) ) ];
        break;
      case 4:
        col = greens[ int( random( greens.length - 1 ) ) ];
        break;
      case 5:
        col = cyans[ int( random( cyans.length - 1 ) ) ];
        break;
      case 6:
        col = blues[ int( random( blues.length - 1 ) ) ];
        break;
      case 7:
        col = violets[ int( random( violets.length - 1 ) ) ];
        break;
    }
  }
  
  
  
}
