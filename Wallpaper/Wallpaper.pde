Table xy;
int index = 0;


float x, y, w;
float spdX, spdY, theta, rotSpd;
float cornerRadiusOffset, dynamicRadius, collisionTheta;
int h = height;
float radius = 100;

void setup() { 
  size(1000, 1000); 
  background(255); 
  //colorMode(HSB);
  translate(width/2, height/2); 
  x = width/2;
  y = height/2;
  w = 150;
  spdX = 2.1;
  spdY = 1.5;
  rotSpd = PI/180;
  //quadraticForm(int(random(3, 25)), radius--, random(50, 100));
   xy = loadTable("http://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2020-08-15T19%3A06%3A09&rToDate=2020-08-17T19%3A06%3A09&rFamily=wasp&rSensor=ES_B_06_418_7BED&rSubSensor=HUMA", "csv");
} 

void draw() {
    pushStyle();
      color(0, 128, 0);
      strokeWeight(10);
      line(width/2, height--, width/2, height);
    popStyle();
  if (index < xy.getRowCount()) {
    // read the 2nd column (the 1), and read the row based on index which increments each draw()
    int y = xy.getInt(index, 1); // index is the row, 1 is the column with the data.
    //println(y);
    //curveEllipse(4, random(0, 360), random(0, y), -.675); 

    //Random Spots
    //pushMatrix();
    //translate(random(width), random(height));
    //rotate(theta);
    //quadraticForm(int(random(3, 25)), radius--, random(50, 100));
    //popMatrix();

    //Center, gets larger
    pushMatrix();
    translate(width/2, height--);
    rotate(theta);
    //rect(-w/2, -w/2, w, w); //rectangle with changing color => add colour changer
    quadraticForm(int(random(3, 25)), radius--, random(50, 100));
    popMatrix();
    index++;
  }
 
  x += spdX;
  y += spdY;
  theta += rotSpd;
  collide();
}


void curveEllipse(int pts, float radius, float handleRadius, float tightness) { 
  float theta = 0; 
  float cx = 0, cy = 0; 
  float ax = 0, ay = 0; 
  float rot = TWO_PI/pts; 
  curveTightness(tightness);
  beginShape();
  for (int i=0; i<pts; i++) {
    // need control before vertex 1 along the ellipse 
    if (i==0) { 
      cx = cos(theta - rot)*radius; 
      cy = sin(theta - rot)*radius; 
      ax = cos(theta)*radius; 
      ay = sin(theta)*radius; 
      curveVertex(cx, cy); 
      curveVertex(ax, ay);
    } else { 
      ax = cos(theta)*radius; 
      ay = sin(theta)*radius; 
      curveVertex(ax, ay);
    } // close ellipse 

    if (i==pts-1) { 
      cx = cos(theta + rot)*radius; 
      cy = sin(theta + rot)*radius; 
      ax = cos(theta + rot*2)*radius; 
      ay = sin(theta + rot*2)*radius; 
      curveVertex(cx, cy); 
      curveVertex(ax, ay);
    }

    // draw anchor points/control points 
    fill(random(0, 255)); 
    ellipse(random(width), random(height), handleRadius*2, handleRadius*2); 
    theta += rot;
  } 
  fill(0, 127); 
  strokeWeight(0);
  noStroke(); 
  endShape();
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
    println(cx);
    println(cy);
    println(ax);
    println(ay);
    if (i==0) { 
      vertex(ax, ay);
    } else {
      quadraticVertex(cx, cy, ax, ay);
      fill(0, 0, 255);
      //rect(cx-3, cy-3, 6, 6);
      //ellipse(ax, ay, 6, 6);
      //line(ax, ay, cx, cy);
    }
    theta += rot;

    if (i == limbs-1) {
      cx = cos(0)*controlRadius;
      cy = sin(0)*controlRadius;
      ax = cos(rot)*limbRadius;
      ay = sin(rot)*limbRadius;
      quadraticVertex(cx, cy, ax, ay);

      //rect(cx-3, cy-3, 6, 6);
      //ellipse(random(width), random(height), 6, 6);
      //line(ax, ay, cx, cy);
    }
  }
  colourChanger();
  endShape();
}

void colourChanger() {
  float color1 = random(0, 255);
  float color2 = random(0, 255);
  float color3 = random(0, 255);
  float color4 = random(0, 255);

  fill(color1, color2, color3, color4);
  stroke(color1, color2, color3, color4);
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
