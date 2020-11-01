import processing.video.*;

color black = color(0);
color white = color(255);
float r, g, b;
int numPixels;
Capture video;
int capture = 1;

void setup() {
  size(640, 480);
  strokeWeight(5);
  r = random(0, 255);
  g = random(0, 255);
  b = random(0, 255);
  video = new Capture(this, width, height);
  video.start(); 
  numPixels = video.width * video.height;
}

void draw() {
  if (video.available()) {
    video.read();
    video.loadPixels();
    float pixelBrightness; 
    loadPixels();
    for (int i = 0; i < numPixels; i++) {
        pixelBrightness = brightness(video.pixels[i]);
        if (pixelBrightness > 200) { 
          pixels[i] = color(r, g, b);
        } else if ( pixelBrightness < 200 && pixelBrightness > 150) {
          pixels[i] = color(r, 255-g, b);
        } else if (pixelBrightness < 150 && pixelBrightness > 100) {
          pixels[i] = color(255-r, g, b);
        } else if (pixelBrightness < 100 && pixelBrightness > 50) {
          pixels[i] = color(r, g, 255-b);
        } else if (pixelBrightness < 50 && pixelBrightness > 25) {
          pixels[i] = color(255-r, g, 255-b);
        } else if (pixelBrightness < 25 && pixelBrightness > 10) {
          pixels[i] = color(255-r, 255-g, 255-b);
        } else { 
          pixels[i] = black;
        }
      
    }
    updatePixels();
    //image(video, 0, height/2);
  }
}

void mousePressed() {
  r = random(0, 255);
  g = random(0, 255);
  g = random(0, 255);
}

void mouseDragged() {
}

void keyPressed() {
  if(key == 's') {
    video.stop();
  }
  if(key == 'p') {
    video.start();
  }
  if(key == 'c') {
    saveFrame("data/image" + capture + ".jpg");
    capture++;
  }
}
