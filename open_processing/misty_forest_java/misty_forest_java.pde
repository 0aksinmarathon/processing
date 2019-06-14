int tree_cnt = 0;
int num_trees = 20;
ArrayList<FloatDict> branch_list;
FloatDict branch;
int branch_index;
ArrayList<FloatDict> leaf_list;
FloatDict leaf;
int leaf_index;
float leaf_size = 6;
boolean generate_tree = true;
float scale = 0.5;

void setup() {
  size(800, 800);
  background(255);
  colorMode(HSB, 255);
}

float randSign() {
  return random(1) < 0.5 ? -1 : 1;
}

void branch(float sx, float sy, float sdir, float dir_range, 
float thickness, float slength, float segs, float level) {
  float x, y, px, py, dir, len;
  x = sx;
  y = sy;
  float leaf_hue = 45+int(random(1)*45);
  for (int i = 0; i < segs; ++i) {
    px = x;
    py = y;

    // Randomize direction & length of the new segment and set x,y to the end point of this new segment
    dir = (random(1) * dir_range - dir_range / 2) * i / segs;
    len = random(1) * slength + slength;
    x += cos(sdir + dir) * len;
    y += sin(sdir + dir) * len;

    // Set the thickness and color and draw the segment
    float weight = pow(segs - i, 0.5) * thickness + 0.2;
    branch = new FloatDict();
    branch.set("weight", weight);
    branch.set("dir", dir);
    branch.set("x", x);
    branch.set("y", y);
    branch.set("px", px);
    branch.set("py", py);
  
    branch_list.add(branch);
    branch_index++;
    float branch_chance = i / segs+0.1;
    if (random(1) < branch_chance) {
      // Make the new branch angle away from the current branch and adjust the settings a bit
      float bdir = sdir + dir + PI / 2.5 * (1 - i / segs) * randSign();
      float bdir_range = min(dir_range * 1.3, PI / 2);
      branch(x, y, bdir, bdir_range, thickness / 2, slength * 0.65, segs - 3, level+1);
    }
    else if (level > 1) {
      leaf = new FloatDict();
      leaf.set("hue", leaf_hue);
      leaf.set("value", int((1-i/segs)*100));
      leaf.set("alpha", int((1-i/segs)*20)+20);
      leaf.set("x", x);
      leaf.set("y", y);
      leaf_list.add(leaf);
      leaf_index++;  
  }
  }
}

void draw() {
  if (generate_tree) {
    // Add some mist
    for (int v=0; v<height; ++v) {
      strokeWeight(1);
      stroke(150, 50, 255, int(50/height*v));
      line(0, v, width, v);
    }
    filter(BLUR, 1);
    branch_list = new ArrayList<FloatDict>();
    branch_index = 0;
    leaf_list = new ArrayList<FloatDict>();
    leaf_index = 0;
    scale = 0.5 + random(1)*0.5;
    // Start the tree with the main trunk
    branch(int(random(1) * width), height, -PI / 2, PI / 4, 10 * scale, height / 50 * scale, 18, 0);
    generate_tree = false;
    branch_index = 0;
    leaf_index = 0;
    if (++tree_cnt == num_trees) noLoop();
  } else {
    // Draw the tree
    for (int i = 0; i < 200; ++i) {
      if (branch_index < branch_list.size()) {
        // Branch
        strokeWeight(branch_list.get(branch_index).get("weight"));
        stroke(20, 30, 50);
        strokeCap(SQUARE);
        line(branch_list.get(branch_index).get("px"), branch_list.get(branch_index).get("py"), branch_list.get(branch_index).get("x"), branch_list.get(branch_index).get("y"));
        // Highlight
        strokeWeight(branch_list.get(branch_index).get("weight")/8);
        stroke(20, 30, 160);
        strokeCap(PROJECT);
        float  ox = cos(branch_list.get(branch_index).get("dir"))*branch_list.get(branch_index).get("weight")/2;
        float  oy = sin(branch_list.get(branch_index).get("dir"))*branch_list.get(branch_index).get("weight")/2;
        line(branch_list.get(branch_index).get("px")+ox, branch_list.get(branch_index).get("py")+oy, branch_list.get(branch_index).get("x")+ox, branch_list.get(branch_index).get("y")+oy);
        // Next
        branch_index++;
      } else if (leaf_index < leaf_list.size()) {
        // Leaf
        noStroke();
        fill(leaf_list.get(leaf_index).get("hue"), 70, leaf_list.get(leaf_index).get("value"), leaf_list.get(leaf_index).get("alpha"));
        ellipse(leaf_list.get(leaf_index).get("x"), leaf_list.get(leaf_index).get("y"), int(random(1)*leaf_size)+leaf_size * scale, int(random(1)*leaf_size)+leaf_size * scale);
        // Next
        leaf_index++;
      }
      else {
        generate_tree = true;
        break;
      }
    }
  }
}
