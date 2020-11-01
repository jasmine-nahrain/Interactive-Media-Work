PImage img;
int resolution;
float r, g, b, rX, gX, bX;
color c;
void setup() {
  img = loadImage("cars.jpg");
  resolution = 200;

  size(1920, 1080);
  image(img, 0, 0);
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    c = pixels[i];
    r= red(c);
    g= green(c);
    b= blue(c);
    pixels[i] = color(r, g, b);
  }
  updatePixels();
} // end setup()

void draw() {
  int xInc = width/resolution;
  int yInc = height/resolution;
  image(img, 0, 0);
  for (int y=0; y<img.height; y+=yInc) {
    for (int x=0; x<img.width; x+=xInc) {     
      // variation with line()
      c = img.get(x, y);
      r = rX + red(c);
      g = gX + green(c);
      b = bX + blue(c);
      strokeWeight(3);
      img.set(x, y, color(r,g,b));
      stroke(img.get(x, y));
      line(x, y, x+10, y+10);
      fill(img.get(x, y));
      rect(x, y, xInc, yInc);
    }
  }
  
  fill(get(mouseX, mouseY));
  rect(10, 10, 50, 50);
}

void mousePressed() {
  img.copy(img, mouseX-50, mouseY-50,width/6,height/6,mouseX,mouseY,width/6,height/6);  
}

void keyPressed() {
  if (key == '+') {
    resolution+=10;
  }
  if (key == '-' && resolution > 10) {
    resolution-=10;
  }
  if (key == 'r') {
    if( r <= 245 || r <= 0) rX += 10;
    else if (r > 245) rX -= 10;
  }
  if (key == 'g') {
    if( g <= 245 || g <= 0) gX += 10;
    else if (g > 245) gX -= 10;
  }
  if (key == 'b') {
    if( b <= 245 || b <= 0) bX += 10;
    else if (b > 245) bX -= 10;
    println(bX);
  }
}
