import processing.video.*;

Capture video;

int x = 0;

void setup() {
  size(1280, 340);

  video = new Capture(this, 640, 340, 30);
  video.start();
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  int w = video.width;
  int h = video.height;

  copy(video, w/2, 0, 1, h, x, 0, 1, h);

  x +=1;

  if (x > width) {
    x = 0;
  }
}
