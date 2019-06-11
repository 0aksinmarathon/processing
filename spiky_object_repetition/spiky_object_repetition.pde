/*
fun to see it shifted to near side from front 
*/

import processing.opengl.*;

int num = 100;
float rotation_number = 5;
int repetition = 2;
int [][][] color_list = new int[repetition][num][4];
int count = 0;
void setup(){
  
  size(800, 800, OPENGL);
  strokeWeight(1);
  background(0);
  translate(width/2, height/2);
  
  line(-width/2 ,0 , width/2, 0);
  line(0, -height/2, 0, height/2);
  
  
  
  
   for (float i = 0; i < num; i++){
     for (float l = 0; l < repetition; l++){
     
       color_list[int(l)][int(i)][0] = 128 + int(random(128));
       color_list[int(l)][int(i)][1] = 128 + int(random(128));
       color_list[int(l)][int(i)][2] = 128 + int(random(128));
       color_list[int(l)][int(i)][3] = int(random(50));
     }
     for (int j = 0; j < 1; j++){
     
     stroke(color_list[0][int(i)][0], color_list[0][int(i)][1],
     color_list[0][int(i)][2],color_list[0][int(i)][3]);
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
void mouseReleased(){
     count--;
     translate(0,0, count*1.5);
   }


 void draw() {
  
   camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
   background(0);
   translate(width/2, height/2);
   rotateZ(frameCount*0.01);

   screen_control();
   
      for (int l = 0; l < repetition; l++){
       translate(0,0,-width/4);
       for (int i = 0; i < num; i++){
         
         pushMatrix();
         for (int j = 0; j < rotation_number; j++){
           
           rotateX(radians(90*j/rotation_number));
           pushMatrix();
           for (int k = 0; k < rotation_number; k++){
              rotateZ(radians(90*k/rotation_number));
              stroke(color_list[l][i][0], color_list[l][i][1],
              color_list[l][i][2],color_list[l][i][3]);
 
              line_draw(i);
         
       }
       popMatrix(); 
     }
   popMatrix();
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


void screen_control(){

 if (keyCode == UP){
     count--;
     translate(0,0, count*1.5);
   }
   if (keyCode == DOWN){
     count++;
     translate(0,0, count*1.5);
   }
   if (keyCode == RIGHT){
     count-=5;
     translate(0,0, count*1.5);
   }
   if (keyCode == LEFT){
     count+=5;
     translate(0,0, count*1.5);
   }
   if (key == 'a'){
     translate(0,0, count*1.5);
   } 
}
    
