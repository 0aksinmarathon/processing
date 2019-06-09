import processing.opengl.*;
int num = 50;
float[] r_revo = new float[num];//radius of revolution


float[][] s = new float[num][3];// speed controller
float[][][] c = new float[num][num][4];// color controller

void setup() {
     size(800, 800, OPENGL);
     //noStroke();
     stroke(0,0,200,200);
     background(0);
     for (int i = 0; i < num; i++){
      r_revo[i] = random(400);
      for(int j = 0; j < 3; j++){
      s[i][j] = random(0.05);
      } 
      for(int j = 0; j < i; j++){
        for(int k = 0; k < 4; k++){  
      c[i][j][k] = random(128)+128;
        }  
    } 
      
   }
     
}
   void draw() {
     background(255);
     for (int i = 0; i < num; i++){
       for (int j = 0; j < i; j++){
         //stroke(c[i][j][0], c[i][j][1],c[i][j][2],c[i][j][3]);
         //stroke(128);
         noStroke();
         line(width/2 + r_revo[i]*cos(frameCount* s[i][0]/10), 
         height/2 + r_revo[i]*cos(frameCount* s[i][1]/10),
         r_revo[i]*cos(frameCount* s[i][2]/10),
         width/2 + r_revo[j]*cos(frameCount* s[j][0]/10), 
         height/2 + r_revo[j]*cos(frameCount* s[j][1]/10),
         r_revo[j]*cos(frameCount* s[j][2]/10)); // network edges
         
         for (int k = 0; k < j; k++){
         if (floor(floor(frameCount/30)*(s[i][0]+s[i][1]+s[i][2]+
         s[j][0]+s[j][1]+ s[j][2]+s[k][0]+s[k][1]+ s[k][2])) % 5 == 0 ){
         // frameCount/n controls the speed of change
           fill(c[i][j][0],c[i][j][1],c[i][j][2],80); // colors of triangles
           beginShape();
           vertex(width/2 + r_revo[i]*cos(frameCount* s[i][0]/10),
           height/2 + r_revo[i]*cos(frameCount* s[i][1]/10),
           r_revo[i]*cos(frameCount* s[i][2]/10));
           vertex(width/2 + r_revo[i]*cos(frameCount* s[j][0]/10),
           height/2 + r_revo[i]*cos(frameCount* s[j][1]/10),
           r_revo[i]*cos(frameCount* s[j][2]/10));
           vertex( width/2 + r_revo[i]*cos(frameCount* s[k][0]/10),
           height/2 + r_revo[i]*cos(frameCount* s[k][1]/10),
           r_revo[i]*cos(frameCount* s[k][2]/10));
           endShape(CLOSE);
         }  
       }
         
       }

     }
     
}
