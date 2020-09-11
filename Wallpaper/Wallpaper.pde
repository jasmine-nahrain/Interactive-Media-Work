Table xy;
int index = 0;
float leftX, rightX;
float x, y, w;
float spdX, spdY, theta, rotSpd;
float cornerRadiusOffset, dynamicRadius, collisionTheta;
float radius = 500;
float i = 0, j=0;
float h;
float a;
float rad = 60;        // Width of the shape
float xpos, ypos;    // Starting position of shape    

float xspeed = 2.8;  // Speed of the shape
float yspeed = 2.2;  // Speed of the shape

int xdirection = 1;  // Left or Right
int ydirection = 1;  // Top to Bottom

void setup() { 
  size(1000, 1000); 
  background(184, 236, 255);
  translate(width/2, height/2); 
  leftX = random(0, width);
  h = random(0, height/2);
  sun();
  //xy = loadTable("http://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2020-08-15T19%3A06%3A09&rToDate=2020-08-17T19%3A06%3A09&rFamily=wasp&rSensor=ES_B_06_418_7BED&rSubSensor=HUMA", "csv");
} 

void draw() {
  leftX = random(0, width);
  rightX = random(0, width);

  h = random(0, height/2);

  //if (index < 5) clouds();
  //if (index < xy.getRowCount()/35) {
    //int y = xy.getInt(index, 1);
    pushMatrix();
    translate(random(width), random(height/10, height-300));
    quadraticForm(int(random(3, 25)), random(50, 100), random(50, 100));
    popMatrix();
    rotate(theta);
    index++;
  //}

  //grass();

  theta += rotSpd;
  leftX += 20;
  collide();
}

void quadraticForm(int limbs, float controlRadius, float limbRadius) {
  float theta = 0;
  beginShape();
  float cx = 0;
  float cy = 0;
  float ax = 0;
  float ay = 0;
  float rot = TWO_PI/(limbs*2);
  for (int i=0; i<limbs; i++) {
    cx = cos(theta)*controlRadius;
    cy = sin(theta)*controlRadius;
    theta += rot;
    ax = cos(theta)*limbRadius;
    ay = sin(theta)*limbRadius;
    if (i==0) { 
      vertex(ax, ay);
    } else {
      quadraticVertex(cx, cy, ax, ay);
    }
    theta += rot;

    if (i == limbs-1) {
      cx = cos(0)*controlRadius;
      cy = sin(0)*controlRadius;
      ax = cos(rot)*limbRadius;
      ay = sin(rot)*limbRadius;
      quadraticVertex(cx, cy, ax, ay);
    }
  }
  colourChanger();
  pushStyle();
  //color(0, 128, 0);
  //strokeWeight(10);
  //line(cx-controlRadius, cy, cx-controlRadius, height);
  popStyle();
  endShape();
}

void colourChanger() {
  float color1 = random(0, 255);
  float color2 = random(0, 255);
  float color3 = random(0, 255);
  float color4 = random(0, 255);

  fill(color1, color2, color3);
  stroke(color1, color2, color3);
}

//void clouds() {
//  pushStyle();
//  fill(255);
//  stroke(255);
//  translate(x, 0);
//  ellipse(leftX, h, 126, 97);
//  ellipse(leftX+62, h, 70, 60);
//  ellipse(leftX-62, h, 70, 60);
//  popStyle();
//}

void clouds() {
  // clouds 
  fill(255, 255, 255);
  noStroke();
  // left cloud
  ellipse(leftX, 150, 126, 97);
  ellipse(leftX+62, 150, 70, 60);
  ellipse(leftX-62, 150, 70, 60);

  // right cloud
  ellipse(rightX, 100, 126, 97);
  ellipse(rightX+62, 100, 70, 60);
  ellipse(rightX-62, 100, 70, 60);
}

void grass() {
  if (i < 200 && j < 150) {    
    pushStyle();
    fill(34, 139, 34);
    stroke(34, 139, 34);
    strokeWeight(10);
    bezier(0, height-i, width/3, height-150, width/2, height-250, width, height-j);
    i++;
    j++;
    popStyle();
  }
}

//void sun() {
//  pushStyle();
//  fill(255, 170, 0);
//  stroke(255, 170, 0);
//  ellipse(350, -350, 200, 200);
//  popStyle();
//}

void sun() {
  pushMatrix();
  pushStyle();
  frameRate(30);
  ellipseMode(RADIUS);
  //// Update the position of the sun
  xpos = xpos + ( xspeed * xdirection );
  ypos = ypos + ( yspeed * ydirection );
  fill(255, 170, 0);
  stroke(255, 170, 0);
  rad = rad + 0.5;
  ellipse(xpos, ypos, rad, rad);
  popStyle();
  popMatrix();
}

void collide() {
  cornerRadiusOffset = w/2/cos(PI/4) - w/2;
  dynamicRadius = abs(sin(collisionTheta)*cornerRadiusOffset);
  if (x > width-w/2) {
    spdX *= -1;
    rotSpd *= -1;
  } else if (x < w/2) {
    spdX *= -1;
    rotSpd *= -1;
  } 

  if (y > height-w/2) {
    spdY *= -1;
    rotSpd *= -1;
  } else if (y < w/2) {
    spdY *= -1;
    rotSpd *= -1;
  }

  collisionTheta *= rotSpd*2;
}
