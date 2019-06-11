/*
fun to see it shifted to near side from front 
*/

import processing.opengl.*;

int num = 10;
float rotation_number = 3;
int repetition = 5;
int [][] color_list = new int[num][4];
void setup(){
  
  size(800, 800, OPENGL);
  strokeWeight(1);
  background(0);
  translate(width/2, height/2);
  
  line(-width/2 ,0 , width/2, 0);
  line(0, -height/2, 0, height/2);
  
  
  
  //camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
   for (float i = 0; i < num; i++){
     
       color_list[int(i)][0] = 128 + int(random(128));
       color_list[int(i)][1] = 128 + int(random(128));
       color_list[int(i)][2] = 128 + int(random(128));
       color_list[int(i)][3] = int(random(50));
       
     for (int j = 0; j < 1; j++){
     
     stroke(color_list[int(i)][0], color_list[int(i)][1],color_list[int(i)][2],color_list[int(i)][3]);
     line_draw(i);
     pushMatrix();
       rotateX(radians(90*j));
       line_draw(i);
     popMatrix();
     pushMatrix();
       rotateY(radians(90*j));
       line_draw(i);
     popMatrix();
     pushMatrix();
       rotateZ(radians(90*j));
       line_draw(i);
     popMatrix();
     }
  }
   
}



 void draw() {
   //camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 
   //0, 0, 1, 0);
  
   background(0);
   translate(width/2, height/2);
   translate(0,0,-width/100);
   rotateZ(radians(frameCount*0.4));
   
   //scale(frameCount*0.003);
   /*
   rotateX(frameCount*0.01);
   rotateY(frameCount*0.0085);
   rotateZ(frameCount*0.018);
   */
   
   translate(0,0, frameCount*0.3);
   if (mousePressed){
     translate(0,0, frameCount*1);
   }
   
     
   for (float i = 1; i < num; i++){
     stroke(color_list[int(i)][0], color_list[int(i)][1],color_list[int(i)][2],color_list[int(i)][3]);
     line_draw(i);
     for (int j = 0; j < rotation_number; j++){
    
      // less spiky
     /*
     line_draw(i);
     pushMatrix();
       rotateX(radians(90*j/rotation_number));
       line_draw(i);
     popMatrix();
     pushMatrix();
       rotateY(radians(90*j/rotation_number));
       line_draw(i);
     popMatrix();
     pushMatrix();
       rotateZ(radians(90*j/rotation_number));
       line_draw(i);
     popMatrix();
     */
     //
      // more spiky or even furry
      
       for (int k = 0; k < rotation_number; k++){
         
             rotateX(radians(90*j/rotation_number));
             rotateZ(radians(90*k/rotation_number));
             line_draw(i);
           
         }
       //   
       
     }  
    }
   
   
 }

void line_draw(float i){
   line((width/2)*((i-num)/num), 0, 0, 0, (i/num)*height/2, 0 ) ;
   line((width/2)*((i-num)/num), 0, 0, 0, (-i/num)*height/2, 0 ) ;
   line((width/2)*((num-i)/num), 0, 0, 0, (i/num)*height/2, 0 ) ;
   line((width/2)*((num-i)/num), 0, 0, 0, (-i/num)*height/2, 0 ) ; 
   
   line(0, 0, (width/2)*((i-num)/num), 0, (i/num)*height/2, 0 ) ;
   line(0, 0, (width/2)*((i-num)/num), 0, (-i/num)*height/2, 0 ) ;
   line(0, 0, (width/2)*((num-i)/num), 0, (i/num)*height/2, 0 ) ;
   line(0, 0, (width/2)*((num-i)/num), 0, (-i/num)*height/2, 0 ) ; 
   
   line((width/2)*((i-num)/num), 0, 0, 0, 0, (i/num)*height/2 ) ;
   line((width/2)*((i-num)/num), 0, 0, 0, 0, (-i/num)*height/2 ) ;
   line((width/2)*((num-i)/num), 0, 0, 0, 0, (i/num)*height/2 ) ;
   line((width/2)*((num-i)/num), 0, 0, 0, 0, (-i/num)*height/2 ) ;
}
    
