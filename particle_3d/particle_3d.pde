import processing.opengl.*;

ArrayList<Particle> plist;
int max_num = 1000;
float[] prev_speed = new float[max_num];
int count = 0;
float gravity = 0.1;
float y_friction_bounce = 0.8;
float xz_friction_bounce = 0.95;
float y_friction_limit = 0.3;
float xz_friction_limit = 0.0001;
float xz_friction_ground = 0.99;

boolean first_count_flag = true;
void setup(){
  
size(900, 900, OPENGL);
plist = new ArrayList<Particle>();
sphereDetail(10);
noStroke();

float fov = radians(120);

perspective(fov, float(width)/float(height), 100.0, 1000.0);

}

 void draw() {
   rotateX(frameCount*0.1);
   camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
   background(0);
   lights();
   fill(255);
   float init_speed_x = mouseX - pmouseX;
   float init_speed_y = mouseY - pmouseY;
   Particle p = new Particle(init_speed_x, init_speed_y);
   if (mousePressed){
    background(0);
     if (count >= max_num){
       count = 0;
       first_count_flag = false;
     }
     if (first_count_flag){
       plist.add(p);
     } else {
       plist.set(count, p);
     }
     count ++;
   }
   
   if (plist.size() != 0){
     for (int i = 0; i < plist.size(); i++){
     
       if (plist.get(i).x < 0 || plist.get(i).x > width){
         plist.get(i).bounce("x");
       }
       if (plist.get(i).z > width || plist.get(i).z < 0){
         plist.get(i).bounce("z");
       }
       if (plist.get(i).y > height){
         plist.get(i).bounce("y");
       }
       if(plist.get(i).y  < height){  
         plist.get(i).gravitate();  
       }
       if((abs(plist.get(i).yspeed) < 0.05 && abs(plist.get(i).y - height) < 5) || 
       abs(prev_speed[i] -plist.get(i).yspeed) < 0.01){
         plist.get(i).friction_ground();
         
       }
       plist.get(i).move();
       plist.get(i).display();
       if (frameCount % 9 == 0){
          prev_speed[i] = (plist.get(i).yspeed);
        }
       
     }
    
   }
   
}

class Particle{
  float x;
  float y;
  float z;
  float xspeed;
  float yspeed;
  float zspeed;
  int r;
  int g;
  int b;
  int o;
  Particle(float init_speed_x, float init_speed_y){
    x = mouseX;
    y = mouseY;
    z = 0;
    xspeed = init_speed_x;
    yspeed = init_speed_y;
    zspeed = random(10);
    r = int(random(255));
    g = int(random(255));
    b = int(random(255));
    o = int(128+random(128));
  }
  
  void display(){
    fill(r, g, b, o);
    pushMatrix();
    translate(x, y, z);
    sphere(10);
    popMatrix();
  }
  void move(){
    x += xspeed;
    y += yspeed;
    z += zspeed;
    
  }
  void gravitate(){
    yspeed += gravity;
   
  }
  
  void bounce(String direction){
    if  (direction == "x"){
      xspeed = friction_calc(xspeed, direction);
    } else if (direction == "z") {
      zspeed = friction_calc(zspeed, direction);
    } else if (direction == "y") {
      y = height;
      yspeed = friction_calc(yspeed, direction);
      
    } 
    
  }
  
  void friction_ground(){
  y = height;
  xspeed = xspeed*xz_friction_ground;
  zspeed = zspeed*xz_friction_ground;
  if (xspeed < 0.01){
    xspeed = 0;
    
  }
  if (zspeed < 0.01){
    zspeed = 0;
  }
  
}

}
float friction_calc(float w, String direction){
  if (direction == "x" || direction == "z"){
      if(abs(w) < xz_friction_limit){
        w = 0;
      } else {
        w = -w*xz_friction_bounce;
      }
  } else if (direction == "y"){
      if(abs(w) < y_friction_limit){
        w = 0;
      } else {
        w = -w*y_friction_bounce;
      }
    }
  return w;
}
