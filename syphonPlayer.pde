import codeanticode.syphon.*;
import processing.video.*;

Movie vid;
SyphonServer server;

String filePath, fileName;
boolean resize = false;

void setup() {
  size(400, 10, P2D);
  surface.setResizable(true);
  fileName = getClass().getSimpleName();
  selectInput("Select a file to process:", "fileSelected");
}

void draw() {
  background(0);

  if (vid != null && resize) {
    surface.setSize(vid.width, vid.height);
    resize = false;
  }

  if (vid != null) {
    image(vid, 0, 0, width, height);
  }
if(server != null){
  server.sendScreen();
}
  String txt_fps = String.format(fileName+ "   [size %d/%d]   [frame %d]   [fps %6.2f]", width, height, frameCount, frameRate);
  surface.setTitle(txt_fps);
}

void movieEvent(Movie m) {
  m.read();
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    filePath = selection.getAbsolutePath();
    fileName = selection.getName();
    server = new SyphonServer(this, fileName);
  }
  vid = new Movie(this, filePath);
  vid.loop();
 // server = server(this, fileName);
  resize = true;
}

void mouseClicked() {
  server.stop();
  selectInput("Select a file to process:", "fileSelected");
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      resize = true;
    }
  }
}
