import processing.video.*;

Capture video;

void setup() {
  size(640, 480, P3D);
  video = new Capture(this, 640, 480, 30);
  video.start();
  
  printArray(Capture.list());
}

void draw() {
  if (video.available()) {
    video.read();
  }
  background(0);
  image(video,0,0);
}
