serpiente sepientita;
comida comidita;
PImage img, bolitas;

void setup(){
  img = loadImage("fondo.png");
  bolitas = loadImage("bolita.png");
  size(600, 600);
  frameRate(14);
  sepientita = new serpiente();
  comidita = new comida();
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
}

void draw(){
  background(0);
  image(img, 0, 0);
  drawScoreboard();

  sepientita.move();
  sepientita.display();
  comidita.display();

  if( dist(comidita.xpos, comidita.ypos, sepientita.xpos.get(0), sepientita.ypos.get(0)) < sepientita.sidelen ){
    comidita.reset();
    sepientita.addLink();
  }
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == LEFT){
      sepientita.dir = "left";
    }
    if(keyCode == RIGHT){
      sepientita.dir = "right";
    }
    if(keyCode == UP){
      sepientita.dir = "up";
    }
    if(keyCode == DOWN){
      sepientita.dir = "down";
    }
  }
}

void drawScoreboard(){
  fill(0, 0 ,0);
  textSize(20);
  text( "Puntos: " + sepientita.len, 70, 35);
}

class comida{
  float xpos, ypos;
  comida(){
    xpos = random(100, width - 100);
    ypos = random(100, height - 100);
  }
 void display(){
   image(bolitas,xpos, ypos, 15,15 );
 }
 void reset(){
    xpos = random(100, width - 100);
    ypos = random(100, height - 100);
 }
}

class serpiente{
  int len;
  float sidelen;
  String dir;
  ArrayList <Float> xpos, ypos;
  serpiente(){
    len = 1;
    sidelen = 17;
    dir = "right";
    xpos = new ArrayList();
    ypos = new ArrayList();
    xpos.add( random(width) );
    ypos.add( random(height) );
  }
  void move(){
   for(int i = len - 1; i > 0; i = i -1 ){
    xpos.set(i, xpos.get(i - 1));
    ypos.set(i, ypos.get(i - 1));
   }
   if(dir == "left"){
     xpos.set(0, xpos.get(0) - sidelen);
   }
   if(dir == "right"){
     xpos.set(0, xpos.get(0) + sidelen);
   }

   if(dir == "up"){
     ypos.set(0, ypos.get(0) - sidelen);

   }

   if(dir == "down"){
     ypos.set(0, ypos.get(0) + sidelen);
   }
   xpos.set(0, (xpos.get(0) + width) % width);
   ypos.set(0, (ypos.get(0) + height) % height);

    if( choque() == true){
      len = 1;
      float xtemp = xpos.get(0);
      float ytemp = ypos.get(0);
      xpos.clear();
      ypos.clear();
      setup();
    }
  }
  void display(){
    for(int i = 0; i <len; i++){
      stroke(0, 0, 0);
      fill(0, 0, 0);
      rect(xpos.get(i), ypos.get(i), sidelen, sidelen);
    }
  }
  void addLink(){
    xpos.add( xpos.get(len-1) + sidelen);
    ypos.add( ypos.get(len-1) + sidelen);
    len++;
  }
   boolean choque(){
    for(int i = 1; i < len; i++){
     if( dist(xpos.get(0), ypos.get(0), xpos.get(i), ypos.get(i)) < sidelen){
       return true;
     }
    }
    return false;
   }
}
