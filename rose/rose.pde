float rose_k = 8;
int iteration = 1080;
int rotation_number_X = 3;
int rotation_number_Y = 1;
int update = 1;
int repetition = 2;
int[][][] color_list = new int[repetition][iteration][4]; 
int count = 0;

void setup(){
  size(800, 800, P3D);
  stroke(255);
  
  translate(width/2, height/2);
  
  fill(255);
  for (int i = 0; i < repetition; i++){
    for (int j = 0; j < iteration; j++){
      for (int k = 0; k < 4; k++){
        color_list[i][j][k] = int(random(255));
      }
     }
    }
  }

void draw(){
  camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  background(0);
  translate(width/2, height/2);
  
  //circle(250, 0, 15);
  //circle(-300, 0, 15);
 
  screen_control();
  
  //translate(0, 0, frameCount*0.01);
//  for (int i = 0; i < 7200; i++){
    //line(0, 0, 0, 
    //200*cos(radians(i*rose_k))*cos(radians(i)), 200*sin(radians(i*rose_k))*sin(radians(i)), 0);
   for (int l = 0; l < repetition; l++){
     translate(0,0,-width);
     int a = 0; 
     for (int j = 0; j < rotation_number_X; j++){
       pushMatrix(); 
       rotateX(radians(30*j/rotation_number_X));
       for (int k = 0; k < rotation_number_Y; k++){
          pushMatrix();
          rotateY(radians(30*k/rotation_number_Y));
          for (int i = 0; i < iteration; i++){
            //circle(300, 0, 15);
            stroke(color_list[l][i][0],color_list[l][i][1], color_list[l][i][2],color_list[l][i][3]);
            line(200*cos(radians(i*rose_k))*cos(radians(i)), 200*cos(radians(i*rose_k))*sin(radians(i)), 0,
            200*cos(radians(((a+update)*rose_k)))*cos(radians((a+update))), 200*cos(radians((a+update)*rose_k))*sin(radians((a+update))), 0);
            a +=update;
          }
          popMatrix();
       }
      popMatrix();
     }
  }
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
