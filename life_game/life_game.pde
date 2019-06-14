boolean time_stop = true;
int f_rate = 1;
int num_horizontal;
int num_vertical;
boolean[][] state;
int generation;

void setup(){
  size(800, 800);
  num_vertical = height/10;
  num_horizontal = width/10;
  state = new boolean[num_horizontal][num_vertical];
  stroke(255);
  strokeWeight(1);
  background(0);
  fill(255);
  reset();
  frameRate(60);
}

 void draw() {
   if (!time_stop){
     if (true){
      calc();
      generation++;
     }
   } 
   render(); 
   println(generation);
}

/*
time on <==> off
*/
void time_control(){
  if (time_stop){
    time_stop = false;
  } else {
    time_stop = true;
  }
}

/*
initialize the state and graphics
*/
void reset(){
  background(0);
  for (float i = 0; i < width; i+=10){    
       line(i, 0 , i, height); 
     }
   for (float i = 0; i < height; i+=10){    
       line(0, i, width, i);
     }
   generation = 0;
   initialize_state();
}

/*
kill every cell
*/
void initialize_state(){
  for (int i = 0; i < num_horizontal; i++){    
    for (int j = 0; j < num_vertical; j++){    
       state[i][j] = false;
     } 
   }
}
/*
change the state of clicked or dragged cells 
*/

void mouseDragged() 
{ 
  try{
    int coordinate_x = mouseX / 10;
    int coordinate_y = mouseY / 10;
    
    if (state[coordinate_x][coordinate_y]){
      state[coordinate_x][coordinate_y] = false;
    } else {
      state[coordinate_x][coordinate_y] = true;
    }
  } catch(ArrayIndexOutOfBoundsException e){
    
  }
 }

void mouseClicked() 
{ 
  try{
    int coordinate_x = mouseX / 10;
    int coordinate_y = mouseY / 10;
    
    if (state[coordinate_x][coordinate_y]){
      state[coordinate_x][coordinate_y] = false;
    } else {
      state[coordinate_x][coordinate_y] = true;
    }
  } catch(ArrayIndexOutOfBoundsException e){
    
  }
 }

/*
reflect the current state to graphics
*/
void render(){
  for (int i = 0; i < num_horizontal; i++){    
    for (int j = 0; j < num_vertical; j++){     
      if (state[i][j] == true){
        fill(255);
        stroke(255);
        rect((i*10), (j*10), (i*10)+10, (j*10)+10);
        
      } else if (state[i][j] == false){
        fill(0);
        
        rect((i*10)+0, (j*10)+0, (i*10)+10, (j*10)+10);
      }
     } 
   }
}

/*
SPACE: time on <==> off
ENTER: reset
LEFT: speed down
RIGHT: speed up
*/
void keyPressed(){
  if (key == ' '){
     time_control(); 
   }
   if (key == ENTER){
     reset(); 
   }
   if (keyCode == LEFT){
     frameRate(--f_rate);
   }
   if (keyCode == RIGHT){
     frameRate(++f_rate);
   }
}
 
/*
calculates the state of next step
*/
 void calc(){
   boolean[][] state_tmp = new boolean[num_horizontal][num_vertical];
   for (int i = 0; i < num_horizontal; i++){    
    for (int j = 0; j < num_vertical; j++){
      state_tmp[i][j] = state[i][j];  
    }
   }
   for (int i = 0; i < num_horizontal; i++){    
    for (int j = 0; j < num_vertical; j++){     
      int count = 0;
      if (i == 0 && j == 0){
        count = int(state_tmp[i+1][j] == true)
        + int(state_tmp[i][j+1] == true)
        + int(state_tmp[i+1][j+1] == true);
      } else if (i == 0 && j == num_vertical-1){
        count = int(state_tmp[i+1][j] == true)
        + int(state_tmp[i][j-1] == true)
        + int(state_tmp[i+1][j-1] == true);  
      } else if (i == num_horizontal-1 && j == 0){
        count = int(state_tmp[i-1][j] == true)
        + int(state_tmp[i][j+1] == true)
        + int(state_tmp[i-1][j+1] == true);  
      } else if (i == num_horizontal-1 && j == num_vertical-1){
        count = int(state_tmp[i-1][j] == true)
        + int(state_tmp[i][j-1] == true)
        + int(state_tmp[i-1][j-1] == true);
      } else if (i == 0){
        count = int(state_tmp[i][j-1] == true)
        + int(state_tmp[i+1][j-1] == true)
        + int(state_tmp[i+1][j] == true)
        + int(state_tmp[i+1][j+1] == true)
        + int(state_tmp[i][j+1] == true);
      } else if (i == num_horizontal-1){
        count = int(state_tmp[i][j-1] == true)
        + int(state_tmp[i-1][j-1] == true)
        + int(state_tmp[i-1][j] == true)
        + int(state_tmp[i-1][j+1] == true)
        + int(state_tmp[i][j+1] == true);  
      } else if (j == 0){
        count = int(state_tmp[i-1][j] == true)
        + int(state_tmp[i-1][j+1] == true)
        + int(state_tmp[i][j+1] == true)
        + int(state_tmp[i+1][j+1] == true)
        + int(state_tmp[i+1][j] == true);  
      } else if (j == num_vertical-1){
        count = int(state_tmp[i-1][j] == true)
        + int(state_tmp[i-1][j-1] == true)
        + int(state_tmp[i][j-1] == true)
        + int(state_tmp[i+1][j-1] == true)
        + int(state_tmp[i+1][j] == true); 
      } else {
         count = int(state_tmp[i-1][j-1] == true)
        + int(state_tmp[i][j-1] == true)
        + int(state_tmp[i+1][j-1] == true)
        + int(state_tmp[i+1][j] == true)
        + int(state_tmp[i+1][j+1] == true)
        + int(state_tmp[i][j+1] == true)
        + int(state_tmp[i-1][j+1] == true)
        + int(state_tmp[i-1][j] == true);
      }
      
     if (state_tmp[i][j] == false && count == 3){
       state[i][j] = true; // birth
     }  else if (state_tmp[i][j] == true && count <= 1){
       state[i][j] = false; // isolation
     } else if (state_tmp[i][j] == true && count >= 4){
       state[i][j] = false; //overpopulation
     }
   } 
 }
 
}
 
