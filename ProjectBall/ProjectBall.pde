import java.util.Random;
interface Displayable {
  void display();
}
interface Moveable {
  void move();
}
interface Collideable{
  boolean isTouching(Thing other);
  void changeDisplay();
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

class Rock extends Thing implements Displayable, Collideable{
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
    txt = 0;
  }

  void display() { 
    fill(33,31,33);
    image(img,x,y,50,50);
  }
  
  void move(){}
  
   boolean isTouching(Thing other) {
    return (other.x >= this.x && other.x <= this.x + 50 &&
            other.y >= this.x && other.y <= this.x + 50);
  }
  
  void changeDisplay(){
    if (x >= 500) x -= 5;
    else x += 5;
    if (y >= 400) y -= 5;
    else y += 5;
  }
}

public class LivingRock extends Rock implements Moveable, Collideable{
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
   //fix so it doesn't get stuck at top.
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

abstract class Ball extends Thing implements Displayable, Moveable, Collideable {
  float r, vx, vy, theta, colour;
  
  Ball(float x, float y, float r, float v, float theta, float colour) {
    super(x, y);
    this.r = r;
    this.theta = theta * (PI / 180);
    vx = v * cos(theta);
    vy = v * sin(theta);
    this.colour = colour;
  }

  void display() {
    fill(colour);
    ellipse(x,y,1.5*r,1.5* r);
    
  }
  void changeDisplay(){
    fill(165,0,0);
    ellipse(x,y,1.5*r,1.5*r);
  }
  boolean isTouching(Thing other) {
    return (dist(x,y,other.x,other.y) <=1.5*r);
  }
  abstract void move();
}

class GravityBall extends Ball {
  float acc, maxHeight;
  
  GravityBall(float x, float y, float r, float v, float theta, float colour, float acc) {
    super(x, y, r, v, theta, colour);
    this.acc = acc;
    maxHeight = height - y;
  }
    boolean isTouching(Thing other) {
    return (dist(x,y,other.x,other.y) <=3*r);
  }
  void Display(){
    fill(colour);
     triangle(x,y,x+1.5*r,y,(x+x+2*r)/2,y+1.5*r*(float)Math.pow(3,1/2));
     triangle(x,y,x-1.5*r,y,(x+x-2*r)/2,y+1.5*r*(float)Math.pow(3,1/2));
     triangle(x,y,x+1.5*r,y,(x+x+2*r)/2,y-1.5*r*(float)Math.pow(3,1/2));
     triangle(x,y,x-1.5*r,y,(x+x-2*r)/2,y-1.5*r*(float)Math.pow(3,1/2));
     triangle(x,y,(x+x+1.5*r)/2,y-1.5*r*(float)Math.pow(3,1/2),(x+x-1.5*r)/2,y-1.5*r*(float)Math.pow(3,1/2));
     triangle(x,y,(x+x+1.5*r)/2,y+1.5*r*(float)Math.pow(3,1/2),(x+x-1.5*r)/2,y+1.5*r*(float)Math.pow(3,1/2));
  }
   void display(){
     fill(colour);
     rect(x,y,3*r,1.2*r);
     rect(x+0.5,y,2.8*r,-3*r);
     rect(x+1*r,y-3*r,1*r,-1*r);
     triangle(x,y,x+1.5*r,y,(x+x+1.5*r)/2,y+3*r);
     triangle(x+1.5*r,y,x+3*r,y,(x+1.5*r+x+3*r)/2,y+3*r);
     
   }
    void changeDisplay(){
     fill(165,0,0);
     triangle(x,y,x+1.5*r,y,(x+x+2*r)/2,y+1.5*r*(float)Math.pow(3,1/2));
     triangle(x,y,x-1.5*r,y,(x+x-2*r)/2,y+1.5*r*(float)Math.pow(3,1/2));
     triangle(x,y,x+1.5*r,y,(x+x+2*r)/2,y-1.5*r*(float)Math.pow(3,1/2));
     triangle(x,y,x-1.5*r,y,(x+x-2*r)/2,y-1.5*r*(float)Math.pow(3,1/2));
     triangle(x,y,(x+x+1.5*r)/2,y-1.5*r*(float)Math.pow(3,1/2),(x+x-1.5*r)/2,y-1.5*r*(float)Math.pow(3,1/2));
     triangle(x,y,(x+x+1.5*r)/2,y+1.5*r*(float)Math.pow(3,1/2),(x+x-1.5*r)/2,y+1.5*r*(float)Math.pow(3,1/2));
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

class SineBall extends Ball {
  float amp, t;
  SineBall(float x, float y, float r, float v, float theta, float amp, float colour) {
    super(x, y, r, v, theta, colour);
    this.amp = amp;
    if (theta % 180 == 0) vx = v;
    else vy = v;
    t = 0;
  }
   void display(){
     fill(50,165,0);
     ellipse(this.x,this.y,3*r,3*r);
     fill(random(165),random(165),random(165));
     ellipse(this.x,this.y,3*r/2,3*r/2);
     triangle(this.x,this.y,this.x+3*r,this.y+3*r/4,this.x+4*r,this.y);
     triangle(this.x,this.y,this.x-3*r,this.y+3*r/4,this.x-4*r,this.y);
    
   }
     boolean isTouching(Thing other) {
    return (dist(x,y,other.x,other.y) <=3*r);
  }
  void move() {
    if (theta % 180 == 0) vy = amp * sin((t / 25));
    else vx = amp * sin((t / 25));
    x += vx;
    y += vy;
    if (x > width - r) {
      vx *= -1;
      x = width - r;
    } else if (x < r) {
      vx *= -1;
      x = r;
    } else if (y > height - r) {
      vy *= -1;
      y = height - r;
    } else if (y < r) {
      vy *= -1;
      y = r;
    }
    t += 1;
  }
}

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable>thingsThatCollide;
ArrayList<Thing>everything;

void setup() {
  size(1000, 800);
  thingsThatCollide=new ArrayList<Collideable>();
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  everything=new ArrayList<Thing>();
  for (int i = 0; i < 10; i++) {
    Ball b;
    if (i % 2 == 0) b = new GravityBall(50+random(width-100),50+random(height)-100, 12.5, random(5, 8), random(-90,90),0, 0.99);//second last color
    else b = new SineBall(50+random(width-100),50+random(height)-100, 12.5, random(5, 8), int(random(0, 4)) * 90, random(3,5), random(165));// last color
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    thingsThatCollide.add(b);
  //  everything.add(b);
    Rock r = new Rock(50+random(width-100),50+random(height)-100);
    thingsToDisplay.add(r);
    thingsThatCollide.add(r);
    everything.add(r);
    
  }

  LivingRock m = new LivingRock(50+random(width-100),50+random(height)-100);
  thingsToDisplay.add(m);
  thingsToMove.add(m);
  thingsThatCollide.add(m);
  everything.add(m);
  
}

void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
  for(Thing thing: everything){
    for(Collideable collide : thingsThatCollide){
      if(collide.isTouching(thing)){
        collide.changeDisplay();
      }
      else{ // stuff.display();
      }
    }
  }
}
