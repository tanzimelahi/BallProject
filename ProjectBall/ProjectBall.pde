import java.util.Random;
interface Displayable {
  void display();
}
interface Moveable {
  void move();
}
abstract class Thing implements Displayable{
  float x, y;
  
  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
  abstract void move();
}

class Rock extends Thing implements Displayable{
  PImage img;
  Rock(float x, float y) {
    super(x, y);
     img = loadImage("Rock.jpg");
  }

  void display() { 
      fill(33,31,33);
    image(img,x,y,30,30);
  }
  
  void move(){}
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x,y);
    
  }
   void move() {
    Random rng = new Random();
      int incx = rng.nextInt()%10;
      int incy= rng.nextInt()%10;
 if (x+incx>1000 || x+incx<0 || y+incy<0 || y+incy>800) {
      x-=incx;
    y-=incy;}
  else{
      x+=incx;
      y+=incy;
  }}
}

class Ball extends Thing implements Displayable, Moveable {
  float r, vx, vy, acc, maxHeight;
  Ball(float x, float y, float r, float v, float theta, float acc) {
    super(x, y);
    this.r = r;
    vx = v * cos(theta);
    vy = v * sin(theta);
    this.acc = acc;
    maxHeight = height - y;
  }

  void display() {
    fill(random(255),random(255),random(255));
    ellipse(x,y,2 * r,2 * r);
  }

  void move() {
    x += vx;
    y += vy;
    vy += acc;
    if (x > width - r) {
      vx *= -1;
      x = width - r;
    } else if (x < r) {
      vx *= -1;
      x = r;
    }
    if (y > height - r) {
      maxHeight *= sqrt(acc);
      vy = -sqrt(2 * acc * maxHeight);
      y = height - r;
    } else if (y < r) {
      y = r;
    }
  } 
}
}
ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100),50+random(height)-100, 12.5, random(5, 8), random(-90,90), 0.99);
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100),50+random(height)-100);
    thingsToDisplay.add(r);
  }

  LivingRock m = new LivingRock(50+random(width-100),50+random(height)-100);
  thingsToDisplay.add(m);
  thingsToMove.add(m);
}

void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
}
