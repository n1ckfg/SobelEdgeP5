// https://computergraphics.stackexchange.com/questions/3646/opengl-glsl-sobel-edge-detection-filter

import processing.video.*;

Capture video;
int captureIndex = 0;
boolean preview;
PShader shader_edge;
PGraphics buffer;
int camW = 640;
int camH = 480;
int camFps = 30;
int bufferW = 1280;
int bufferH = 960;

void setup() {
  size(1280, 960, P2D);
   
  video = new Capture(this, camW, camH, Capture.list()[captureIndex], camFps);
  video.start(); 

  buffer = createGraphics(bufferW, bufferH, P2D);
  shader_edge = loadShader("sobel_edge.glsl");
  shader_edge.set("iResolution", float(buffer.width), float(buffer.height));
  shader_edge.set("tex0", buffer);
}

void draw() {
  background(0);
  
  buffer.beginDraw();
  buffer.image(video, 0, 0, buffer.width, buffer.height);
  
  if (!preview) {
    buffer.filter(shader_edge);
  }
  
  buffer.endDraw();
  image(buffer, 0, 0, width, height);
  
  surface.setTitle("" + frameRate);
}

void captureEvent(Capture c) {
  c.read();
}
