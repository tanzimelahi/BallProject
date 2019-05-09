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
  int dx, dy;
  Rock(float x, float y) {
    super(x, y);
    r = new Random();
    imag = r.nextInt(2);
    if (imag == 0) img = loadImage("Rock3.jpg");
    else img = loadImage("Rock.jpg");
    dx = r.nextInt(15) - 7;
    dy = r.nextInt(15) - 7;
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
      ellipse(x+17,y+22,10,6);
      ellipse(x+30,y+22,10,6);
      fill(0,0,0);
      ellipse(x+17,y+22,3,3);
      ellipse(x+30,y+22,3,3);
    }
  else{ 
  fill(255,255,255);
  ellipse(x+20,y+15,10,6);
  ellipse(x+37,y+17,10,6);
  fill(0,0,0);
  ellipse(x+20,y+15,3,3);
  ellipse(x+37,y+17,3,3);
  }
  }
  
   void move() {
      if (x < 0) dx = -1*dx;
      if (x + 50 > 1000) dx = -1*dx;
      if (y < 0) dy *= -1;
      if (y + 50 > 800) dy *= -1;
      x += dx;
      y += dy;
     
     /*Random rng = new Random();
      int dx = rng.nextInt(10) - 5;
      int dy = rng.nextInt(10) - 5;
       if (x+incx>1000 || x+incx<0 || y+incy<0 || y+incy>800) {
      x-=incx;
      y-=incy;}
      else{
      x+=incx;
      y+=incy;
      }*/
   }
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
    //thing.move();
  }
}