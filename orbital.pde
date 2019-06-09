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
      r_revo[i] = random(400);
      r[i] = random(20);
      for(int j = 0; j < 3; j++){
      s[i][j] = random(1);
      } 
      
   }
     
}
   void draw() {
     background(0);
     for (int i = 0; i < num; i++){
     //for(int j = 0; j < 4; j++){
     // c[i][j] = random(255);
     //} color change per frame 
     pushMatrix();
     translate(width/2, height/2, 0); // center the sun
     rotateX(frameCount* s[i][0]/50); // revolution around the center
     rotateY(frameCount* s[i][1]/50);
     rotateZ(frameCount* s[i][2]/50);
     translate(r_revo[i]*cos(2*PI*i/num), r_revo[i]*sin(2*PI*i/num), 0); 
     // coordinate of planets
     //rotateX()
     //rotateY()
     //rotateZ()...rotation of planets specified 
    fill(c[i][0],c[i][1],c[i][2],c[i][3]);
     sphere(r[i]);
     popMatrix();
     
     } 
}
