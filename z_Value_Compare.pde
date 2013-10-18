int rectHigh = 2;
int rectWidth = 2;   //Design to draw one 2x2 pixel rect to show one depth value pixel
int colorIndex = 0;
String[] pointsLineFromCsv0;  //String Array to story the depth value
String[] pointsLineFromCsv1;
String xyDepth;
int X = 640;
int Y = 320;

int fuSan = 0;
int fuEr = 0;
int fuYi = 0;
int ling = 0;
int yi = 0;
int er = 0;
int san = 0;

void setup()
{
  size(X*rectWidth,Y*rectHigh);
  noStroke();
  background(255,255,255);
  textSize(24);
  textAlign(CENTER,CENTER);
  pointsLineFromCsv0 = loadStrings("0.csv"); 
  pointsLineFromCsv1 = loadStrings("1.csv"); 
  frameRate(1);
  
  int x = 0;
  int y = 0;  
  int depthValueInCSVCell = 0;
  
  for(int i = 0; i < Y; i++)
  {
    String line0 = pointsLineFromCsv0[i];
    String line1 = pointsLineFromCsv1[i];
    
    String[] pieces0 = split(line0, ", ");
    String[] pieces1 = split(line1, ", ");
    
    for(x = 0; x < pieces0.length; x++)
    {
      if(!pieces1[x].equals(""))
      {
        depthValueInCSVCell = Integer.parseInt(pieces1[x]) - Integer.parseInt(pieces0[x]);
        drawRect(x, y, depthValueInCSVCell);
      }
    }
    y++;  
  }
}

//Render engine for each depth value
color renderDepthWithColor(int depth)
{
  color rectColor = color(100,100,100);  //defaut color is RED
  
  switch(depth) {
    case -3: 
      fuSan++;
      rectColor = color(#FF3030); //Red 
      break;
    case -2: 
      fuEr++;
      rectColor = color(#FF4500); //Red -1
      break;
    case -1: 
      fuYi++;
      rectColor = color(#FF6EB4); //Red - 2
      break;
    case 0: 
      ling++;
      rectColor = color(#FAFAFA);  //white
      break;
    case 1: 
      yi++;
      rectColor = color(#76EE00);  //Green
      break;
    case 2:
      er++; 
      rectColor = color(#C0FF3E);  //Green -1
      break;
    case 3: 
      san++;
      rectColor = color(#CAFF70);  //Green -2
      break;
  }
  return rectColor;
}

//Draw one rect with x y and depth value
void drawRect(int x, int y, int depth)
{
   fill(renderDepthWithColor(depth));
   rect(rectWidth*x, rectHigh*y, rectWidth, rectHigh);
}

//The main draw function
void draw()
{
  if(xyDepth != null)
  {
    textSize(24);
    fill(0, 102, 153, 204);
    textAlign(CENTER,CENTER);
    text(xyDepth, width/2, height/2);
  }
}

//Get the xy's depth
void mouseMoved()
{ 
  int sum = X*Y - (fuSan + fuEr + fuYi + ling + yi + er + san);

  String str = "-3:" + fuSan + "  " + "-2:" + fuEr + "  " + "-1:" + fuYi + "  " + "0:" + ling + "  " + "1:" + yi + "  " + "2:" + er + "  " + "3:" + san + "  " + "Other:" + sum;
  
  updateXYDepthStr(str);
}

void updateXYDepthStr(String str)
{
  xyDepth = new String(str);
}
//Save the image capture
void mousePressed() 
{
  saveFrame();
}
