//your variable declarations here
SpaceShip cool = new SpaceShip();
Star [] sky;
//Asteroid [] bobbo;
ArrayList <Asteroid> aList;
ArrayList <Bullet> bulls;
int numStars = 100;
int numAsteroids = 30;
public void setup() 
{
  aList = new ArrayList <Asteroid>();
  bulls = new ArrayList <Bullet>();
  size(800, 800);
  background(0);
  sky = new Star[numStars];
  for(int i = 0; i < numStars; i++)
  {
    sky[i] = new Star();
  }
  for(int i = 0; i < numAsteroids; i++)
  {
    aList.add(new Asteroid());
  }
}

public void keyPressed()
{
  if(key == 'w'){cool.accelerate(.1);}
  if(key == 'a'){cool.rotate(-15);}
  if(key == 's'){cool.accelerate(-.1);}
  if(key == 'd'){cool.rotate(15);}
  if(keyCode == 32){bulls.add(new Bullet(cool));}
  if(key == 'e'){cool.setX((int)(Math.random() * 800)); cool.setY((int)(Math.random() * 800));}
}

public void draw() 
{
  background(0);
  for(int i = 0; i < numStars; i++)
  {
    fill(255);
    sky[i].show();
  }
  cool.move();
  cool.show();
  for(int j = 0; j < aList.size(); j++)
  {
    aList.get(j).move();
    aList.get(j).show();
    if(dist(aList.get(j).getX(), aList.get(j).getY(), cool.getX(), cool.getY()) <= 20)
    {
      aList.remove(j);
    }
  }
  for(int i = 0; i < bulls.size(); i++)
  {
    bulls.get(i).show();
    bulls.get(i).move();
    for(int j = 0; j < aList.size(); j++)
    {
      if(dist(aList.get(j).getX(), aList.get(j).getY(), bulls.get(i).getX(), bulls.get(i).getY()) <= 20)
      {
        aList.remove(j);
        bulls.remove(i);
        break;
      }
      else if(bulls.get(i).getX() > 790 || bulls.get(i).getX() < 10 || bulls.get(i).getY() > 790 || bulls.get(i).getY() < 10)
      {
        bulls.remove(i);
        break;
      }
    }
  }
}

class SpaceShip extends Floater  
{
  public SpaceShip()
  {
    corners = 6;
    int[] xC = {16, 0, 2, -1, 2, 0};
    int[] yC = {0, 8, 2, 0, -2, -8};
    xCorners = xC;
    yCorners = yC;
    myCenterX = 400; 
    myCenterY = 400;
    myDirectionX = 1;
    myDirectionY = 1;
    myColor = 255;
  }
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;}
  public double getPointDirection(){return myPointDirection;}

}

class Asteroid extends Floater
{
  protected int asteroidRotation;
  public Asteroid()
  {
    asteroidRotation = (int)(Math.random() * 5) - 2;
    corners = 7;
    int [] xS = {-1, 8, 10, 6, 4, 2, -3};
    int [] yS = {0, 0, 17, 17, 4, 17, 17};
    xCorners = xS;
    yCorners = yS;
    myCenterX = Math.random() * 800;
    myCenterY = Math.random() * 800;
    myDirectionX = Math.random() * 5 - 2;
    myDirectionY = Math.random() * 5 - 2;
    myColor = color(17, 53, 114);
  }
  public void move()
  {     
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     
    myPointDirection+=asteroidRotation;
    //wrap around screen    
    if(myCenterX > width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY > height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;}
  public double getPointDirection(){return myPointDirection;}
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);
  abstract public double getDirectionX();
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection();

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX > width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

public class Star
{
  protected int myX;
  protected int myY;
  protected int mySize;
  public Star()
  {
    myX = (int)(Math.random() * 800);
    myY = (int)(Math.random() * 800);
    mySize = (int)(Math.random() * 5) + 1;
  }
  public void show()
  {
    fill(255);
    ellipse(myX, myY, mySize, mySize);
  }
}