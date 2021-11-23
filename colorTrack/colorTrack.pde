import processing.video.*;

//Variable for capture device
Capture video;

//Variable for the color we are searching for
color trackColour;

int worldRecord = 500;
int x;
int closestX;
int closestY;

float threshold = 25;

void setup() {
  size(640, 360);

  video = new Capture(this, 640, 360, 30);
  video.start();

  //Start off tracking for red
  trackColour = color(255, 0, 0);
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  video.loadPixels(); //because we're dealing with pixels

  image(video, 0, 0);

  //threshold is map(mouseX, 0, width, 0, 100)
  threshold = 80;

  float avgX = 0;
  float avgY = 0;

  int count = 0;

  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      int loc = x + y*video.width;

      //What is current colour
      color currentColour = video.pixels[loc];

      float r1 = red(currentColour);
      float g1 = green(currentColour);
      float b1 = blue(currentColour);
      float r2 = red(trackColour);
      float g2 = red(trackColour);
      float b2 = red(trackColour);

      //Using Euclidian distance to compare colours
      float d = distSq(r1, g1, b1, r2, g2, b2); // dist^2 is better for optimisation, so no square root is taken

      //If current colour is more similar to the tracked colour
      //save current location and current worldRecord
      if (d < threshold*threshold) {
        stroke(255);
        strokeWeight(1);
        point(x, y);
        
        avgX += x;
        avgY += y;

        count++;
      }
    }
  }
  
  //We only consider the colour found if its colour distance is less than 10
  //This threshold of 10 is arbitrary and you can adjust this number depending on how aaccurate you require the tracking to be
  if (count > 0) {
    avgX = avgX / count;
    avgY = avgY / count;
    
    //Draw a circle at the tracked pixel
    fill(255);
    strokeWeight(4.0);
    stroke(0);
    ellipse(avgX, avgY, 24, 24);
  }
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)+(z2-z1)*(z2-z1);
  return d;
}

void mousePressed() {
  //Save colour where the mouse is clicked in trackColour variable;
  int loc = mouseX + mouseY*video.width;
  trackColour = video.pixels[loc];
}
