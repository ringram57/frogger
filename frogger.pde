
int level=1; //level + 4 equals amount of bands

//float diam; 
float frogX; 
float frogY;

float bandHeight; //HEight  of each band

float hazardOffset;
float offsetChange=0.75;

boolean touch=false;

 float frogX2;
 float frogY2;

void setup()
{
  size(800,800);
  bandHeight=height/float(level+4); // divide screen into 5 bars
  frogX=width/2; // we sent the function empty values and defined the globals here 
  frogY=height-bandHeight/2;
  //diam=bandHeight/2;
  //fullScreen();
}

void draw()
{
  //calcBand();
  resetFrog();
  drawWorld();
  drawFrog(frogX,frogY,bandHeight/2); // have frog size adjust to bandheight
  drawHazards();
  
  if(!touch)
  displayMessage("LEVEL"+" "+ str(level));
  else
  displayMessage("GAME OVER");
  
  println(touch);
  
  
}

boolean objectInCanvas(float x, float y, float diam)
{
 // boolean isInCanvas;

  
   return  (x-diam/2<width && x+diam/2 > 0
  && y-diam/2<height && y+diam/2 >0);
}


void drawWorld()
{
 
  int [] amountlevels= new int [level+4]; //make an array so we can go through each bar 
  for(int i=0; i<amountlevels.length; i++) //use for loop to draw each bar at right spot
  {
    if (i==0 || i==(amountlevels.length-1)) // Make the first and last i different from the middle
    {
      fill(0,100,250);
    }
    else
    {
      fill(190);
    }
    noStroke();
    rect(0,i*bandHeight,width,bandHeight);
  }

}
void drawFrog(float x, float y, float diam)
{
  //y=offSetY+height-bandHeight/2;// allow frog to start in centre of band and stil move by adjusting the offset.
  //x=offSetX+width/2;
  
  
  
  fill(200);
  stroke(0,0,255);
  ellipse(x,y,diam,diam);
}
void moveFrog(float xChange, float yChange)
{
  // wen want to to check where the frog will be once it moves and if that position will be in canvas
  //if yes, then we allow frogX to equal frogX2. 
 frogX2=frogX+xChange;
 frogY2=frogY+yChange;
  
  if (objectInCanvas(frogX2,frogY2,bandHeight/2))
  {
  frogX=frogX2;
  frogY=frogY2;
  }
}
void keyPressed()
{ if(!touch)
  {
  //move frog up
  if(key=='w' || key=='W'
     || key=='i' || key=='I')
   {  
  //frogY+=bandHeight;
  moveFrog(0,-bandHeight);
   }
  
  //move frog left
  if (key=='a'|| key=='A'
      || key=='j' || key=='J')
      
  //frogX-=bandHeight;
  moveFrog(-bandHeight,0);
  
  //move frog right
  if (key=='d'|| key=='D'
      || key=='l' || key=='L')
      
  //frogX+=bandHeight;
  moveFrog(bandHeight,0);
  
  //move frog down
  if (key=='s'|| key =='S'
      || key=='k' || key=='K')
      
  //frogY-=bandHeight;
  moveFrog(0,bandHeight);
  }
}

boolean drawHazard(int type, float x, float y, float size)
{
  if(type==0) // here we draw the different types of hazards
  {
    fill(200,0,100);
  ellipse(x,y,size,size);
  //if (objectsOverlap(x,y,frogX2,frogY2,size, bandHeight/2))
 // touch=true;
 fill(0);
  }
  if(type==1)
  {
  fill(0,200,0);
  rect(x-size/2,y-size/2,size,size);
  //if (objectsOverlap(x-size/2,y-size/2,frogX2,frogY2,size, bandHeight/2))
 
  }
  if(type==2)
  {
    fill(200,0,0);
    ellipse(x,y,size,size);
    //if (objectsOverlap(x,y,frogX2,frogY2,size, bandHeight/2))

  }
  
  return  (objectsOverlap(x,y,frogX,frogY,size, bandHeight/2));
  //so drawhazard returns a boolean of objectsOverlap using its provided parameters which come from drawHazards
  
}

boolean drawHazards()
{
  int type=0;
  
  
  for(int i=0; i<level+2;i++) // how many bands in the middle
  {
    int bandlevel=i+3; // as per the instructions we want spacing to start at 3 and move on 
    int spacing=int(bandlevel*bandHeight); // spacing will start at 3 bandheights apart  
    int numHazards=width/spacing+2; // number of hazards will be the width of the band divided by the spacing 
    //plus 2 so we have offscreen objects for smoother visual
    for(int j=-1; j<numHazards; j++) // start at -1 for the offscreen object
    //this for loop will draw the number of hazards on the selected level
    {
      float x=0; //start drawing objects at 0
      float y=height-bandHeight*1.5-bandHeight*i;
      if ( i%2==0)// switch directions each band
      {
        x=spacing*j+(hazardOffset*bandlevel);
        
      }
      else 
      {
        x=spacing*j-(hazardOffset*bandlevel);
       
      }
        

        drawHazard(type, x, y, bandHeight);
        if(drawHazard(type, x, y, bandHeight))
        touch=true;
     
        
      // y cooridnate is calculate to move "up" by one band per i
      
    }
    type+=1;
    type%=3;// for each band cycle through the different types. 
   
  }
    if(!touch)  
   { hazardOffset+=0+offsetChange;//add offset change
    hazardOffset%=bandHeight; //offsest grows to bandheight and repeats
   }
   return touch;
}

void displayMessage(String m)
{
  fill(200,0,200);
  textSize(bandHeight/2);
  text( m, width/2-textWidth(m)/2, bandHeight-bandHeight/5);
}

boolean detectWin()
{
  return frogY<bandHeight; //check if frog is in top level
}

void resetFrog()
{  
  if(detectWin())
  {
    level+=1; 
    frogX=width/2;  //reset frog position
    frogY=height-bandHeight/2;
    
  }
  bandHeight=height/float(level+4); // recalculate the bandheight
}
  boolean ptInRect(float x, float y, float left, float top, float wide, float high){
  return (x>=left && x<=left+wide && y>=top && y<=top+high);}
  
  boolean objectsOverlap(float x1, float y1, float x2, float y2, float size1, float size2)
  {
   // return  (objectsOverlap(x,y,frogX,frogY,size, bandHeight/2));
            float tlx1=x1-size1/2;
            float tly1=y1-size1/2;
            
            float tlx2=x2-size2/2;
            float tly2=y2-size2/2;
            
            return //(ptInRect(tlx1,tly1,tlx2,tly2,size1,size2)
            //|| (ptInRect(tlx1+size1,tly1,tlx2,tly2,size1,size2)
           //|| (ptInRect(tlx1,tly1+size1,tlx2,tly2,size1,size2)
            //||(ptInRect(tlx1+size1,tly1+size1,tlx2,tly2,size1,size2)
            
             (ptInRect(tlx2,tly2,tlx1,tly1,size1,size2)
            || (ptInRect(tlx2+size2,tly2,tlx1,tly1,size1,size2)
           || (ptInRect(tlx2,tly2+size2,tlx1,tly1,size1,size2)
            || (ptInRect(tlx2+size2,tly2+size2,tlx1,tly1,size1,size2)))))
            ; 
  }
  
