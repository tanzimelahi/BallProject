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
  Random r;
  PImage img;
  Rock(float x, float y) {
    super(x, y);
    r = new Random();
    int imag = r.nextInt(2);
    if (imag == 0) img = loadImage("Rock.jpg");
    else img = loadImage("Rock3.jpg");
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
  Ball(float x, float y) {

    super(x, y);
  }

  void display() {
    fill(random(255),random(255),random(255));
    ellipse(x,y,50,50);
  }

  void move() {
    /* ONE PERSON WRITE THIS */
  }
  void polygon(int x,int y,int n,int size){
    
}
}
ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100),50+random(height)-100);
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