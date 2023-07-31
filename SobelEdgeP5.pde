// https://computergraphics.stackexchange.com/questions/3646/opengl-glsl-sobel-edge-detection-filter

boolean preview;
PShader shader_edge;
PGraphics buffer;

int bufferW = 1280;
int bufferH = 960;

void setup() {
  size(1280, 960, P2D);
   
  videoSetup();

  buffer = createGraphics(bufferW, bufferH, P2D);
  shader_edge = loadShader("sobel_edge.glsl");
  shader_edge.set("iResolution", float(buffer.width), float(buffer.height));
  shader_edge.set("tex0", buffer);
}

void draw() {
  background(0);
  
  buffer.beginDraw();
  if (liveCapture) {
    buffer.image(capture, 0, 0, buffer.width, buffer.height);
  } else {
    buffer.image(movie, 0, 0, buffer.width, buffer.height);
  }
  
  if (!preview) {
    buffer.filter(shader_edge);
  }
  
  buffer.endDraw();
  image(buffer, 0, 0, width, height);
  
  surface.setTitle("" + frameRate);
}
