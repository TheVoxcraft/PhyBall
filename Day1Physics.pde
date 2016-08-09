// Simple physics  engine for future development
// With use of objects
public int windowX = 800;
public int windowY = 600;
public float deltaTime;
public float SimulationSpeed = 30;
public int nBalls = 10;
public int count = 0;
public PhyObject[] balls;


void setup(){
  size(800, 600);
  noStroke();
  
  balls = new PhyObject[nBalls];
  for (int x = 0; x < nBalls; x++) {
    balls[x] = new PhyObject(round(random(-29, 30)), round(random(-29, 30)), round(random(1, 800-20)), round(random(0, 400)), str(count));
    count++;
  }
  
}

void draw(){
  background(0);
  updateDeltaTime();
  
  for (int x = 0; x < nBalls; x++) {
    balls[x].updatePhysics();
    balls[x].updateGraphics();
    ellipse(balls[x].xPos,balls[x].yPos,20,20);
    for (int xx = 0; xx < nBalls; xx++) {
      if(balls[x].xPos > balls[xx].xPos && balls[x].xPos+20 < balls[xx].xPos+20){
        if(balls[x].yPos > balls[xx].yPos && balls[x].yPos+20 < balls[xx].yPos+20){
          balls[x].phyReact();
        }
      }
      
    }
  }
}


void updateDeltaTime(){
  deltaTime = SimulationSpeed / frameRate;
}

class PhyObject{
  int objSize;
  float gravity;
  float gravityInc = 0.1;
  int xPos;
  int yPos;
  int framesDead = 0;
  
  int currentXSpeed;
  int currentYSpeed;
  
  int maxSpeed = 30;
  int maxGravity = 10;
  String objName;
  
  public PhyObject(int _currentXSpeed, int _currentYSpeed, int _xPos, int _yPos, String _name){
    currentXSpeed = _currentXSpeed;
    currentYSpeed = _currentYSpeed;
    xPos = _xPos;
    yPos = _yPos;
    objName = _name;
  }
  
  void drawDebug(){
    text("Delta Time: "+deltaTime,20,20);
    text("Gravity: "+gravity,20,40);
    text("Gravity Increment: "+gravityInc,20,60);
    text("Current Y Speed: "+currentYSpeed,20,80);
    text("Current X Speed: "+currentXSpeed,20,100);
  }
  
  void updatePhysics(){
    checkCollision();
    
    xPos = round(xPos + (currentXSpeed  * deltaTime));
    yPos = round(yPos + (currentYSpeed  * deltaTime));
    
    if(gravity < maxGravity){
      gravity = gravity + gravityInc;
    }
    if(currentXSpeed < maxSpeed){
      currentYSpeed = currentYSpeed + round(gravity * deltaTime);
    }
    if(currentYSpeed < maxSpeed){
      if(currentXSpeed > 0){
        currentXSpeed = currentXSpeed - round(gravity * deltaTime);
      }
      if(currentXSpeed < 0){
        currentXSpeed = currentXSpeed + round(gravity * deltaTime);
      }
    }
  }
  
  void updateGraphics(){
    //ellipse(xPos, yPos, objSize, objSize);
  }
  
  public void phyReact(){
    currentXSpeed = round(-(currentXSpeed * .6));
    currentYSpeed = round(-(currentYSpeed * .8));
    println(objName+" Reacted");
    
  }
  
  void checkCollision(){
    if(yPos+objSize > windowY-1 ){
      phyReact();
    } else if(xPos+objSize > windowX-1){
      phyReact();
    } else if(xPos+objSize <= 1){
      phyReact();
    } else if(yPos+objSize <= 1){
      phyReact();
    } else if(yPos > windowY-1){
     phyReact();
    } else if(xPos > windowX-1){
     phyReact();
    } else if(xPos <= 1){
     phyReact();
    } else if(yPos <= 1){
     phyReact();
    }
  
  }
}