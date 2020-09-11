float rad = 60;        // Width of the shape
float xpos, ypos;    // Starting position of shape    

float xspeed = 2.8;  // Speed of the shape
float yspeed = 2.2;  // Speed of the shape

int xdirection = 1;  // Left or Right
int ydirection = 1;  // Top to Bottom
float i = 0, j=0;

Table xy;
int index = 0;

float r = 135;
float g = 206;
float b = 235;
float leftX, middleX, rightX, theta, sunRadius = 100;

void setup() 
{
  size(1000, 1000);
  noStroke();
  // Set the starting position of the shape
  xpos = 0;
  ypos = 0;
  leftX = random(0, width);
  middleX = random(width/6, width/3);
  rightX = random(width/2, width);
  xy = loadTable("http://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2020-08-15T19%3A06%3A09&rToDate=2020-08-17T19%3A06%3A09&rFamily=wasp&rSensor=ES_B_06_418_7BED&rSubSensor=HUMA", "csv");
}

void draw() 
{

  background(r, g, b);

  //day
  if (ypos < height) {
    // sun
    frameRate(30);
    sun();
    clouds();
    rightX++;
    leftX++;
    middleX--;
  } else {
    frameRate(1);
    //night
    moon();
        quadraticForm(int(random(3, 25)), random(10, 20), random(10, 20));

    pushMatrix();
    //frameRate(5);
    translate(random(width), random(height/10, height-300));
    popMatrix();
  }
  grass();
}

void circles() {
  circle(random(width), random(height), 6);
}

void skyColour() {
  if (ypos < height/2) {
    r = r + 0.3;
    g = g + 0.08;
    b = b - 0.6;
  } 
  if (ypos > height/2) {
    r= r - 1.4;
    g = g - 1;
    b = b - 1;
  }
}

void moon() {
  pushMatrix();
  fill(255);
  translate(270, height/2);
  rotate(-PI/2);
  arc(0, 0, 75, 75, 0, PI*4);
  fill(r, g, b);
  arc(10, 10, 75, 75, 0, PI*4);
  fill(255);
  //circle(random(width), random(height), 10);
  //circle(random(width), random(height), 10);
  //circle(random(width), random(height), 10);
  popMatrix();
}

void sun() {
  pushMatrix();
  pushStyle();
  //frameRate(30);
  ellipseMode(RADIUS);
  //// Update the position of the sun
  xpos = xpos + ( xspeed * xdirection );
  ypos = ypos + ( yspeed * ydirection );
  fill(255, 170, 0);
  stroke(255, 170, 0);
  rad = rad + 0.5;
  skyColour();
  ellipse(xpos, ypos, rad, rad);
  popStyle();
  popMatrix();
}

void grass() {
  pushStyle();
  fill(34, 139, 34);
  stroke(0, 0, 0, 100);
  strokeWeight(4);
  bezier(0, height-200, width/3, height-350, width/2, height-450, width, height); // middle top
  bezier(-300, height-200, 200, height-450, 300, height-350, 400, height);//left top
  bezier(width/2, height-200, width-200, height-350, width-100, height-450, width+300, height); //right top

  bezier(0, height, width/3, height-150, width/2, height-250, width, height); //middle bottom
  bezier(width/2, height, width-200, height-150, width-100, height-250, width+300, height); //right bottom
  bezier(-300, height, 200, height-250, 300, height-150, 400, height); //left bottom
  popStyle();
}

void clouds() {
  // clouds 
  fill(255, 255, 255);
  // left cloud
  ellipse(leftX, 150, 126, 97);
  ellipse(leftX+62, 150, 70, 60);
  ellipse(leftX-62, 150, 70, 60);

  ellipse(middleX, 150, 126, 97);
  ellipse(middleX+62, 150, 70, 60);
  ellipse(middleX-62, 150, 70, 60);

  // right cloud
  ellipse(rightX, 100, 126, 97);
  ellipse(rightX+62, 100, 70, 60);
  ellipse(rightX-62, 100, 70, 60);
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
  //colourChanger();
  pushStyle();
  color(0, 128, 0);
  strokeWeight(10);
  line(cx-controlRadius, cy, cx-controlRadius, height);
  popStyle();
  endShape();
}
