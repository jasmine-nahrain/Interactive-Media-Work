size(1000,1000);
ellipseMode(CORNER);

//Head
float headHeight = 500;
float headWidth = headHeight * 1.3;
float head_x = (width - headWidth)/2;
float head_y = (height - headHeight)/2;

//Eyes
float eyeWidth = headWidth/5;
float eyeHeight = eyeWidth/2;
float irisDiam = eyeHeight;
float eye_y = head_y + headHeight/2 - eyeHeight/2;
//left
float leftEye_x = head_x + eyeWidth;
float leftIris_x = leftEye_x + eyeWidth/2 - irisDiam/2;
//right
float rightEye_x = head_x + eyeWidth*3;
float rightIris_x = rightEye_x + eyeWidth/2 - irisDiam/2;

//ears

float ear_y1 = head_y - headHeight/6;
float ear_y2 = head_y + 100;
float ear_y3 = head_y + 150;

float rightEar_x1 = headWidth + head_x;
float rightEar_x2 = head_x + headWidth/2;
float rightEar_x3 = head_x + headWidth/1.1;
float leftEar_x1 = width - rightEar_x1;
float leftEar_x2 = width - rightEar_x3;
float leftEar_x3 = head_x + headWidth/2;

//inner ear
float innerEar_y1 = ear_y1 + headHeight/10;
float innerEar_y2 = ear_y2;
float innerEar_y3 = ear_y3;

float rightInnerEar_x1 = rightEar_x1 - rightEar_x1/40;
float rightInnerEar_x2 = rightEar_x2 + rightEar_x2/20;
float rightInnerEar_x3 = rightEar_x3 - rightEar_x2/20;
float leftInnerEar_x1 =  width - rightInnerEar_x1;
float leftInnerEar_x2 = leftEar_x2 + leftEar_x2/20;
float leftInnerEar_x3 = leftEar_x3 - leftEar_x3/20;

//nose
float nose_x1 = width/2 - headHeight/10;
float nose_x2 = width/2 + headHeight/10;
float nose_x3 = width/2;
float nose_y1 = height/2 + 20;
float nose_y2 = nose_y1 + headHeight/10;

//whiskers
float whisker_x1 = nose_x3;
float whisker_y1 = nose_y2;
float whisker_x2 = whisker_y1;
float whisker_y2 = whisker_y1 + headHeight/15;
// left
float whiskerLeft_x2 = width - whisker_y1;
float whiskerLeft_y2 = whisker_y1 + headHeight/15;

stroke(230, 186, 80);
background(0,0,0);
strokeWeight(5);
pushStyle();
strokeWeight(8);

//tail
pushStyle();
beginShape();
noFill();
strokeWeight(100);
stroke(230, 186, 80);
vertex(head_x+headWidth/2, head_y+headHeight); // first point
bezierVertex(head_x+headWidth/2, 250, head_x+headWidth/2, 50, head_x, 100);
bezierVertex(20, 130, 175, 140, 120, 120);
endShape();
popStyle();

//ear
triangle(leftEar_x1, ear_y1, leftEar_x2, ear_y3, leftEar_x3, ear_y2);
triangle(rightEar_x1, ear_y1, rightEar_x2, ear_y2, rightEar_x3, ear_y3);

//whiskers
//left
line(head_x, width/2+20, head_x-100, width/2-20);
line(head_x+10, width/2+50, head_x-60, width/2+50);
line(head_x+20, width/2+80, head_x-100, width/2+120);
//right
line(head_x+headWidth, width/2+20, head_x+headWidth+100, width/2-20);
line(head_x+headWidth-10, width/2+50, head_x+headWidth+60, width/2+50);
line(head_x+headWidth-20, width/2+80, head_x+headWidth+100, width/2+120);
popStyle();

//inner ear
pushStyle();
strokeWeight(0);
fill(253, 206, 138);
triangle(leftInnerEar_x1, innerEar_y1, leftInnerEar_x2, innerEar_y3, leftInnerEar_x3, innerEar_y2);
triangle(rightInnerEar_x1, innerEar_y1, rightInnerEar_x2, innerEar_y2, rightInnerEar_x3, innerEar_y3);
popStyle();

//body
ellipse(head_x, head_y+headHeight-100, headWidth, headHeight);

//head
ellipse(head_x, head_y, headWidth, headHeight);

//nose
pushStyle();
fill(253, 206, 138);
triangle(nose_x1, nose_y1, nose_x2, nose_y1, nose_x3, nose_y2);
popStyle();

//under nose
line(whisker_x1, whisker_y1, whisker_x2, whisker_y2);
line(whisker_x1, whisker_y1, whiskerLeft_x2, whiskerLeft_y2);

//eye
fill(0, 0, 0);
ellipse(leftIris_x, eye_y, irisDiam, irisDiam);
ellipse(rightIris_x, eye_y, irisDiam, irisDiam);

line(head_x+headWidth/4, height, head_x+headWidth/4, height-100);
line(head_x+headWidth-headWidth/4, height, head_x+headWidth-headWidth/4, height-100);
