
class Particle
{
  float x;
  float y;
  int parSize; // size of particles
  float initialPistonDepth;
  float speedX;
  float speedY;
  float randomizeX;
  float randomizeY;
  
  int cydSX = 50;
  int cydWidth = 300;
  
  Particle(float volume) {
    float pistonDepth = volume * 2.031;
    x = random(50, 350);
    y = random(100 + 600 - pistonDepth, 700);
    parSize = 20;
    
    speedX = random(2, 4);
    speedY = random(2, 4);
    randomizeX = random(0, 1);
    randomizeY = random(0, 1);
    if (randomizeX > 0.5) {
      speedX = speedX * -1;
    }
    if (randomizeY > 0.5) {
      speedY = speedY * -1;
    }
    
    if (volume == 0) {
      speedX = 0;
      speedY = 0;
    }
  }
  
  void move(float volume) {
    x = x + speedX;
    y = y + speedY;
    
    float pistonDepth = volume * 2.031;
    
    if ((x < cydSX) || (x > cydSX + cydWidth)) {
      speedX = speedX * -1; // reverse direction
    }
    
    if ((y < 100 + 600 - pistonDepth) || (y > 700)) {
      speedY = speedY * -1; // reverse direction
    }
    
    
  }
  
  void display() {
    noStroke();
    fill(120);
    ellipse(x, y, parSize, parSize);
  }
  
}
