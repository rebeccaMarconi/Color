import gab.opencv.*;
import processing.video.*;

Capture webcam;
OpenCV cv;


void setup() {
  size(1280,720);
  
  
  cv = new OpenCV(this, width,height);
  cv.startBackgroundSubtraction(100, 3, 1);
  
  
  String[] inputs = Capture.list();
  if (inputs.length == 0) {
    println("Couldn't detect any webcams connected!");
    exit();
  }
  webcam = new Capture(this, inputs[0]);
  webcam.start();
}


void draw() {
  if (webcam.available()) {
    
    
   background(120,60,random(255));
    
    
    webcam.read();
    
    cv.loadImage(webcam);
    
    cv.findCannyEdges(100,100);
   
    cv.updateBackground();
  
    
   
    webcam.mask(cv.getOutput());
    image(webcam, 0,0);
  }
}

  //void keyPressed() {
  //  if (key=='r') {
  //    cv.loadImage(webcam);

  //    webcam.start();
  //  cv.updateBackground();
  //  }
  //}
