import processing.video.*;

Capture video;
float r, g, b;
float x;
int videoScale = 10;
int cols, rows;
float video3Width, video3Height, video3Scale1, video3Scale2;
float y;
void setup() {
  size(640, 480);
  r = random(0, 255);
  g = random(0, 255);
  b = random(0, 255);
  x = width/2;  
  y = height/2;
  cols = width/2 / videoScale;  
  rows = height/2 / videoScale;  
  video3Width = -width/2; 
  video3Height = -height;
  video3Scale1 = -1;
  video3Scale2 = -1;
  video = new Capture(this, width, height); 
  video.start();
}

void captureEvent(Capture video) {  
  video.read();
}

void draw() {  
  if (video.available()) {    // if a new image is available
    video.read();             // read the current image
  }
  //video #1
  image(video, 0, 0, width/2, height/2);
  video.loadPixels();  
  // Begin loop for columns  
  for (int i = 0; i < cols; i++) {    
    // Begin loop for rows    
    for (int j = 0; j < rows; j++) {      
      // Where are you, pixel-wise?      
      int x = i*videoScale;      
      int y = j*videoScale;    

      // Reverse the column to mirro the image.
      int loc = (video.width - i - 1) + j * video.width;       

      color c = video.pixels[loc];
      // A rectangle's size is calculated as a function of the pixel’s brightness. 
      // A bright pixel is a large rectangle, and a dark pixel is a small one.
      float sz = (brightness(c)/255) * videoScale;       

      rectMode(CENTER);      
      fill(255);      
      noStroke();      
      rect(x + videoScale/2, y + videoScale/2, sz, sz);
    }
  }

  //video #2
  pushStyle();
  tint(r, g, b);
  image(video, width/2, 0, width/2, height/2);
  popStyle();

  //video #3
  pushMatrix();
  //filter(INVERT);
  scale(video3Scale1, video3Scale2);
  image(video, video3Width, video3Height, width/2, height/2);
  popMatrix();

  //video #4
  video.loadPixels();
  float newx = constrain(x + random(-20, 20), width/2, width);   
  float newy = constrain(y + random(-20, 20), height/2, height-1);

  // Find the midpoint of the line
  int midx = int((newx + x) / 2);
  int midy = int((newy + y) / 2);
  // Pick the color from the video, reversing x
  color c = video.pixels[(width-1-midx) + midy*video.width];

  // Draw a line from (x,y) to (newx,newy)  
  stroke(c);  
  strokeWeight(4);  
  line(x, y, newx, newy);  

  // Save (newx,newy) in (x,y)  
  x = newx;  
  y = newy;
}

void mousePressed() {
  if (MouseIsOver(width/2, 0, width, height/2)) {
    r = random(0, 255);
    g = random(0, 255);
    g = random(0, 255);
  }

  if (MouseIsOver(0, height/2, width/2, height)) {
    if (video3Scale1 == -1 && video3Scale2 == -1) {
      video3Scale1 = 1;
      video3Scale2 = 1;
      video3Width = 0;
      video3Height = height/2;
    } else if (video3Scale1 == 1 && video3Scale2 == 1) {
      video3Scale1 = -1;
      video3Scale2 = -1;
      video3Width = -width/2;
      video3Height = -height;
    }
  }
}

boolean MouseIsOver(int x, int y, int w, int h) {
  if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
    return true;
  }
  return false;
}
