import processing.video.*;

Movie movie;
Capture capture;
int captureIndex = 0;
int camW = 640;
int camH = 480;
int camFps = 30;
boolean liveCapture = false;
String movieUrl = "test.mp4";
boolean movieLoop = false;

void captureSetup() {
  capture = new Capture(this, camW, camH, Capture.list()[captureIndex], camFps);
  capture.start(); 
}

void movieSetup() {
  movie = new Movie(this, movieUrl);
  if (movieLoop) movie.loop();
  movie.play(); 
}

void videoSetup() {
  if (liveCapture) {
    captureSetup();
  } else {
    movieSetup();
  }
}

void captureEvent(Capture c) {
  c.read();
}

void movieEvent(Movie m) {
  m.read();
}
