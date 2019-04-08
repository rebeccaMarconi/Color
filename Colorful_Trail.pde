import gab.opencv.*;
import processing.video.*;
float threshold = 100;


Capture webcam;
OpenCV cv;


void setup() {
  size(1920, 1080);


  cv = new OpenCV(this, width, height);
  cv.startBackgroundSubtraction(100, 3, 1);


  String[] inputs = Capture.list();
  printArray(inputs);

  if (inputs.length == 0) {
    println("Couldn't detect any webcams connected!");
    exit();
  }
  //webcam = new Capture(this, inputs[0]);
  webcam = new Capture(this, 1920, 1080, "HD Webcam C615", 30);
  webcam.start();
}


void draw() {
  if (webcam.available()) {

    //color pixelColor1= color(120,60,random(255));
    //color pixelColor2= color(0); 

    color c1 = color(255, 150, 0);
    color c2 = color(0, 150, 255);
    float pct = random(0, 1);
    color pixelColor1 = lerpColor(c1, c2, pct);
    color pixelColor2= color(0);
    
    //background(120,60,random(255));
    fill(0, 10);
    rect(0,0, width,height);


    webcam.read();

    cv.loadImage(webcam);

    cv.findCannyEdges(100, 100);
    //image(cv.getOutput(), 0,0);
    cv.updateBackground();
    //image(cv.getOutput(), 0, 0);

  PImage img = cv.getOutput();



    img.loadPixels();
    loadPixels();
    for (int i=0; i<img.pixels.length; i++) {


      float r = img.pixels[i] >> 16 & 0xFF;


      if (r < threshold) {
        pixels[i] =  pixelColor1;
      } else {
        //pixels[i] = pixelColor2;
      }
    }
    updatePixels();
  }
}

void keyPressed() {
  if (key=='r') {
    cv.startBackgroundSubtraction(100, 3, 1);
  }
}
