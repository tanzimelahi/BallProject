import java.util.Random;
interface Displayable {
  void display();
}
interface Moveable {
  void move();
}
interface Collideable{
  boolean isTouching(Thing other);
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
  Random r;
  PImage img;
  int imag;
  Rock(float x, float y) {
    super(x, y);
    r = new Random();
    imag = r.nextInt(2);
    if (imag == 0) img = loadImage("Rock3.jpg");
    else img = loadImage("Rock.jpg");
   
  }

  void display() { 
    fill(33,31,33);
    image(img,x,y,50,50);
  }
  
  void move(){}
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x,y);
    
  }
  void display(){
    super.display();
    if (imag==0){
    fill(255,255,255);
    ellipse(x+20,y+18,10,6);
    ellipse(x+40,y+18,10,6);
    fill(0,0,0);
    ellipse(x+20,y+18,3,3);
    ellipse(x+40,y+18,3,3);
  }
  else 
  fill(255,255,255);
  ellipse(x+15,y+20,10,6);
  ellipse(x+35,y+20,10,6);
      fill(0,0,0);
    ellipse(x+15,y+20,3,3);
    ellipse(x+35,y+20,3,3);
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

class Ball extends Thing implements Displayable, Moveable,Collideable {
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
    fill(0+random(165));
    ellipse(x,y,1.5*r,1.5* r);
    
  }
  boolean isTouching(Thing other){
    if (dist(x,y,other.x,other.y)<=1.5*r){
      return true;
    }
    else{
      return false;
    }
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
