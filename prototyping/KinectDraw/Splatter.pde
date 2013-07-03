class Splatter
{
  int splatterRadius = 30;
  int level = 10;
  
  int placeX , placeY;
  
  void Splatter( )///int pX , int pY )
  {
    //placeX = pX ; 
    //placeY = pY ;
    
    //ellipse( placeX , placeY , splatterRadius , splatterRadius );
    
  }
  
  void update()
  {
  }
  
  
  void drawSplatter( float pX , float pY , int pRadius , int pLevel )
  {
    float red = 126 * pLevel / 6.0; 
    fill ( 116 , 0 , red );
    ellipse( pX , pY , pRadius*2, pRadius*2);
    if (pLevel > 1) 
    {
      pLevel = pLevel - 1;
      int num = int (random(2, 5));
      for(int i=0; i<num; i++) 
      { 
        float a = random(0, TWO_PI);
        float nx = pX + cos(a) * 4 * pLevel; 
        float ny = pY + sin(a) * 4 * pLevel; 
        drawSplatter(nx, ny, pRadius/2, pLevel); 
      }
    } 
  }
  
  
  
}
