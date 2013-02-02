/*
Processing color picker

Shows a canvas filled with the average color seen by the video source (usually a webcam).

Version 1.0

--------------------------------------------

Copyright 2013 DraftFCB Chicago

Licensed under the Eclipse Public License, Version 1.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.eclipse.org/legal/epl-v10.html

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. 
*/   
   
import processing.video.*;
// Variable for capture device
Capture video;

int canvasWidth = 640;
int canvasHeight = 480;

void setup() {
  size(canvasWidth,canvasHeight);
  video = new Capture(this, width, height, 30);
  video.start();
  // Remove border from shapes drawn
  strokeWeight(0);
}

void draw() {
  
  // Capture video
  if (video.available()) {
    video.read();
  }
  
  loadPixels();
  video.loadPixels();
  
  //red, green and blue accumulators
  float rAcc = 0;
  float gAcc = 0;
  float bAcc = 0;
  
  //red, green and blue value averages
  float rAvg = 0;
  float gAvg = 0;
  float bAvg = 0;
  
  //total number of pixels for calculating average color
  int numPix = video.width * video.height;
      
  // Loop through the pixels
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      
      int loc = x + y*video.width;            
      color current = video.pixels[loc];      
      
      // Add the current red, green and blue values to the accumulators
      rAcc += red(current);
      gAcc += green(current);
      bAcc += blue(current);
      
    }
  }
  // Average red, green and blue values by dividing the accumulator by the number of pixels
  rAvg = rAcc / numPix;
  gAvg = gAcc / numPix;
  bAvg = bAcc / numPix;
  
  // Set fill color to average value
  fill(color(rAvg, gAvg, bAvg));
  // Fill canvas with a rectangle
  rect(0, 0, canvasWidth, canvasHeight);
}
