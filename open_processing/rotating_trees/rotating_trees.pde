// one line is drawn in several strokes and each stroke gets shorter 
// so that one line seems written in one stroke but with deceleration
// the starting (end) point of one stroke is prevx prevy (nextx, nexty)
// when a stroke is short enough, it is divided into a few branches
// and that coordinate is the (endx, endy)

////////////////////
// update         //
////////////////////

// mawaruyonishita
// colored


class Createbranch{
    float startx;
    float starty;
    float endx;
    float endy;
    float length;
    float degree;
    float nextx;
    float nexty;
    float prevx;
    float prevy;
    boolean next_flag;
    boolean draw_flag;
  
  Createbranch(float sx, float sy, float ex, float ey, float sl, float sd){
    startx = sx;
    starty = sy;
    endx = ex;
    endy = ey;
    length = sl;
    degree = sd;
    nextx = startx;
    nexty = starty;
    prevx = startx;
    prevy = starty;
    next_flag = true;
    draw_flag = true;

  }
  void update() {
    // extending line
    nextx += (endx - nextx) * 0.4;
    nexty += (endy - nexty) * 0.4;
    s_color = int(count / 10.0);
    s_weight = 3.0 / (count / 100 + 1);
    
   // branch division
   // passing arguments to branches
    if (abs(nextx - endx) < 1.0 && abs(nexty - endy) < 1.0 && next_flag == true) {
      next_flag = false;
      draw_flag = false;
      nextx = endx;
      nexty = endy;
      float num = int(random(2, 4));
      for (float i = 0; i < num; i++) {
        float sx = endx;
        float sy = endy;
        float sl = random(random(10.0, 20.0), length * 0.99);
        
        float sd = random(-24.0, 24.0);
        
        float ex = sx + sl * cos(radians(sd + degree ));
        float ey = sy + sl * sin(radians(sd + degree ));
        if (count > 100){
          sd = random(-90.0, 90.0);
        }
        
        if (num_tree == 0){
        ex = sx + sl * cos(radians(sd + degree + offset));
        ey = sy + sl * sin(radians(sd + degree + offset));
        }
        
        
        Createbranch b = new Createbranch(sx, sy, ex, ey, sl, sd + degree);
        branch.add(b);
      }
      count += 1;
    }
    
    // sufficint number of brnaches -> next tree 
    if (branch.size() > 10000) {
    //if (branch.size() > 6000) {  
      count = 0;
      s_color = 0;
      s_weight = 0;
      float sx = random(width);
      //float sl = random(max(200.0-3*num_tree, 0), max(400.0-3*num_tree, 100));
      float sl = random(0,100);
      branch = new ArrayList<Createbranch>();
      
      Createbranch b = new Createbranch((width/2)+100*cos(radians(num_tree*360/PI)), (height/2)+100*sin(radians(num_tree*360/PI)),
      (width/2)+(100+sl)*cos(radians((num_tree))*360/PI), (height/2)+(100+sl)*sin(radians((num_tree))*360/PI), sl, (num_tree*360/PI));
      //Createbranch b = new Createbranch(sx, height, sx, height - sl, sl, 0.0);
      branch.add(b);
    
      num_tree++;
    }
  }
  void render() {
    if (draw_flag == true) {
      stroke(86 + (0-86)*sqrt((s_color/255)), 
      69 + (105-69)*sqrt(s_color/255), 
      57 + (60-57)*sqrt(s_color/255),
      255-208*sqrt(s_color/255));
      //86 69  57
      // 0 135 60
      //stroke(s_color);
      strokeWeight(s_weight);
      line(prevx, prevy, nextx, nexty);
    }
    prevx = nextx;
    prevy = nexty;
  }
}

ArrayList<Createbranch> branch;
float offset = -90.0;
float count;
float s_color;
float s_weight;
float num_tree;

void setup () {  
  pixelDensity(displayDensity ());
  size(800, 800, OPENGL);
  background(255);
  colorMode(RGB, 255, 255, 255, 100);
  branch = new ArrayList<Createbranch>();
  
  for(int i = 0; i < 20; i++){
      fill(random(255),random(255),random(255),random(255));
      circle(width/2,height/2, 10*(20-i));
    } // center circle
  
  //Createbranch b = new Createbranch(width / 2, height, width / 2, height - 80.0, 80.0, 0.0);
  Createbranch b = new Createbranch(width/2, height/2-100, width / 2, height/2 - 150.0, 80.0, 0.0);
  branch.add(b);
  count = 0;
  s_color = 0;
  s_weight = 0;
  
  
}
void draw (){
  lights();
  fill(0);
  pushMatrix();
  translate(width/2, height/2);
  rotateZ(frameCount*0.01);
  sphere(100);
  popMatrix();
  for (int i = 0; i < branch.size(); i++) {
    branch.get(i).render();
    branch.get(i).update();
    
  }
  
}
