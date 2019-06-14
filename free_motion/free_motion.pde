class Rec {
  float wid;
  float lefttopx = random(width);
  float bottom = random(width);
  float speed = random(30)+2;
  float r = random(255);
  float g = random(255);
  float b = random(255);
  float o = random(255);
  float r1 = random(100);
  float r2 = random(100);
  float r3 = random(100);
  float r4 = random(100);
  String direction;
  Rec(float arg_wid){
    wid = arg_wid; 
    direction = "down";
}

  void down_shift(){
    bottom+=speed;
  }  
  void up_shift(){
    bottom-=speed;
  }  
  void left_shift(){
    lefttopx-=speed;
  }  
  void right_shift(){
    lefttopx+=speed;
  }  
  
  void display(){
    fill(r,g,b,o);
    rect(lefttopx, bottom, wid, 5);
  }
  
  void route_change(){
    if (frameCount % floor(r1+r2+r3+r4) < r1){
      direction = "up";
    } else if (r1 < frameCount % floor(r1+r2+r3+r4) & 
    frameCount % floor(r1+r2+r3+r4) < r1 + r2){
      direction = "left";
    } else if (r1+r2 < frameCount % floor(r1+r2+r3+r4) & 
    frameCount % floor(r1+r2+r3+r4) < r1+r2+r3){
      direction = "right";
    } else{
      direction = "down";
    }
  }
 
 void redo(){
   lefttopx = random(width);
   bottom = random(height);
   r = random(255);
   g = random(255);
   b = random(255);
   o = random(255);
   r1 = random(100);
   r2 = random(100);
   r3 = random(100);
   r4 = random(100);
 }
}
int num = 500;
Rec[] r = new Rec[num]; 
float a = random(800);
float arg_wid = 10;


void setup(){
  size(500, 500);
  noStroke();
 
  for (int i = 0; i < num; i+=1){
    r[i] = new Rec(arg_wid);
  }
  
}
 

void draw(){ 

  for (int i = 0; i < num; i+=1){
    r[i].route_change();
    
    if (r[i].direction == "up"){
      r[i].up_shift();
    } else if (r[i].direction == "left"){
      r[i].left_shift();
    } else if (r[i].direction == "right"){
      r[i].right_shift();
    } else{
      r[i].down_shift();
    }
    
    r[i].display();
    if (r[i].bottom > height || 0 > r[i].bottom ||
    r[i].lefttopx + arg_wid > width || r[i].lefttopx < 0){
      r[i].redo();
    }
  }
  saveFrame("frames/######.png");
}
