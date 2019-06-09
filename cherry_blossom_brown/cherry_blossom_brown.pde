import processing.opengl.*;
int num = 100;
float[] r_revo = new float[num];//radius of revolution
float[] r = new float[num];//radius of planets

float[][] s = new float[num][3];// speed controller
float[][] c = new float[num][4];// color controller

void setup() {
     size(800, 800, OPENGL);
     noStroke();
     //stroke(0,0,200,200);
     background(0);
     for (int i = 0; i < num; i++){
      r_revo[i] = random(20);
      r[i] = random(20);
      for(int j = 0; j < 3; j++){
      s[i][j] = random(0.1);
      } 
      
   }
     
}
   void draw() {
     background(0);
     for (int i = 0; i < num; i++){
  
     
     translate(width/2, height/2, 0); // center the sun
     rotateX(frameCount* s[i][0]/10); // revolution around the center
     rotateY(frameCount* s[i][1]/10);
     rotateZ(frameCount* s[i][2]/10);
     ellipse(width/2,height/2,
     30, 30); 
     
     } 
}
