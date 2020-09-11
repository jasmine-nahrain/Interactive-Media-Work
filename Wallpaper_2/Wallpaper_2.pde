Table xy;
int index = 0, limbs, i = 0;
float x, y, spdX, spdY, theta, rotSpd, cornerRadiusOffset, dynamicRadius, collisionTheta, controlRadius, limbRadius;
float cx = 0, cy = 0, ax = 0, ay = 0;

void setup() {
  size(600, 600);
  smooth();
  x = width/2;
  y = height/2;
  spdX = 2.1;
  spdY = 1.5;
  rotSpd = PI/180;
  limbs = (int)random(3, 25);
  controlRadius = random(50, 100);
  limbRadius = random(50, 100);
  fill(0, 0, 0);
  noStroke();
  xy = loadTable("http://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2020-07-31T12%3A44%3A22&rToDate=2020-08-20T12%3A44%3A22&rFamily=optergy&rSensor=CB02.01-DB-01-EM-01+Lighting+-+LIGHTING", "csv");
}

void draw() {
  if ( frameCount % 10 == 0 )
    background(0, 0, 0, 200);

  if (index < xy.getRowCount()) {
    // read the 2nd column (the 1), and read the row based on index which increments each draw()
    int row = xy.getInt(index, 1); // index is the row, 1 is the column with the data.
    println(y);
    pushMatrix();
    translate(x, y);
    rotate(row);
    quadraticForm(limbs, controlRadius, limbRadius);
    if ( frameCount % 10 == 0 )controlRadius++;

    popMatrix();
    index++;
  }

  x += spdX;
  y += spdY;
  theta += rotSpd;
  collide();
  i++;
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
void collide() {
  cornerRadiusOffset = ax/cos(PI/limbs) - ax;
  dynamicRadius = abs(sin(collisionTheta)*cornerRadiusOffset);
  if (x > width-limbRadius/2) {
    spdX *= -1;
    rotSpd *= -1;
  } else if (x < limbRadius/2) {
    spdX *= -1;
    rotSpd *= -1;
  } 

  if (y > height-limbRadius/2) {
    spdY *= -1;
    rotSpd *= -1;
  } else if (y < limbRadius/2) {
    spdY *= -1;
    rotSpd *= -1;
  }

  collisionTheta *= rotSpd*limbs;
}
void colourChanger() {
  float color1 = random(0, 255);
  float color2 = random(0, 255);
  float color3 = random(0, 255);
  float color4 = random(0, 255);

  fill(color1, color2, color3);
  stroke(color1, color2, color3);
}
