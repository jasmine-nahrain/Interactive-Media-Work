import beads.*;
import java.util.Arrays; 

AudioContext ac, ac2;
Glide carrierFreq, modFreqRatio;
Panner p, p2;
SamplePlayer player, player2, player3;
TapIn tin1, tin2, tin3;
TapOut tout1, tout2, tout3;
float delay1 = 1000, delay2 = 0;
int i = 0;
String audioFileName = "/Users/ja5m1/OneDrive/Desktop/Samples/533841__ultraaxvii__crickets-chirping-with-other-bugs.wav";
String audioFileName2 = "/Users/ja5m1/OneDrive/Desktop/Samples/24003__erdie__explosion-mega-thunder.wav";
String audioFileName3 = "/Users/ja5m1/OneDrive/Desktop/Samples/182474__keweldog__car-horn.wav";


void setup() {
  size(300, 300);
  ac = new AudioContext();
  ac2 = new AudioContext();
  player = new SamplePlayer(ac, SampleManager.sample(audioFileName));
  player2 = new SamplePlayer(ac, SampleManager.sample(audioFileName2));
  player3 = new SamplePlayer(ac, SampleManager.sample(audioFileName3));
  p = new Panner(ac, 0);
  p2 = new Panner(ac, 0);
  sound();
}

void sound() {

  player.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  player2.setLoopType(SamplePlayer.LoopType.LOOP_ALTERNATING);
  player3.setLoopType(SamplePlayer.LoopType.LOOP_ALTERNATING);

  tin1 = new TapIn(ac, 1000);
  tout1 = new TapOut(ac, tin1, delay1);
  Gain gDelay1 = new Gain(ac, 1, 0.5);
  gDelay1.addInput(tout1);
  tin1.addInput(gDelay1);

  tin2 = new TapIn(ac, 1000);
  tout2 = new TapOut(ac, tin2, delay2);
  Gain gDelay2 = new Gain(ac, 1, 0.9);
  gDelay2.addInput(tout2);
  tin2.addInput(gDelay2);

  tin3 = new TapIn(ac2, 1000);
  tout3 = new TapOut(ac2, tin3, 500);
  Gain gDelay3 = new Gain(ac2, 1, 0.5);
  gDelay3.addInput(tout3);
  tin3.addInput(gDelay3);

  tin1.addInput(player);
  tin2.addInput(player2);
  tin3.addInput(player3);


  Gain g = new Gain(ac, 1, 0.5);
  Gain g2 = new Gain(ac2, 1, 0.9);

  p.addInput(player);
  p.addInput(player2);
  p.addInput(tout1);
  p.addInput(tout2);
  g.addInput(p);

  p2.addInput(player3);
  p2.addInput(tout3);
  g2.addInput(p2);

  ac.out.addInput(g);
  ac2.out.addInput(g2);

  ac.start();
  ac2.start();
}

void mouseClicked() {
  if(i <= 10 && delay1 > 0) {
    tout1.setDelay(delay1-=100);
    tout2.setDelay(delay2+=100);
    i++;
        println(delay1);
    println(delay2);
  }
  if(i >= 10 && delay1 < 1000){
    tout1.setDelay(delay1+=100);
    tout2.setDelay(delay2-=100);
    println(delay1);
    println(delay2);
  }
}

void mouseDragged() {
  back = color(random(0, 255), random(0, 255), random(0, 255));
}

void mouseMoved() {
  fore = color(random(0, 255), random(0, 255), random(0, 255));
  fore = color(random(0, 255), random(0, 255), random(0, 255));
}

color fore = color(255, 102, 204);
color back = color(0, 0, 0);

void draw() {
  loadPixels();
  //set the background
  Arrays.fill(pixels, back);
  //scan across the pixels
  for (int i = 0; i < width; i++) {
    //for each pixel work out where in the current audio buffer we are
    int buffIndex = i * ac.getBufferSize() / width;
    //then work out the pixel height of the audio data at that point
    int vOffset = (int)((1 + ac.out.getValue(0, buffIndex)) * height / 2);
    //draw into Processing's convenient 1-D array of pixels
    vOffset = min(vOffset, height);
    pixels[vOffset * height + i] = fore;
  }
  updatePixels();
}


/**
 * On mouse click, starts/stops car horn
 * On mouse moved, colour of audio line changes
 * On mouse dragged, colour of backgrouond changes
 */
