import gifAnimation.*;

import processing.video.*;

boolean lastPressed = false;
String path = "C:/Users/N/Pictures/eyes/";
String[] filenames;
Gif eyes;

Capture cam;
int capturedFrames;
GifMaker gifExport;
GifMaker gifPlayer;

void setup(){
  //Screen size stuff
  size(displayWidth, displayHeight);
  imageMode(CENTER);
  
  //Camera stuff
  cam = new Capture(this, 320, 240);
  cam.start();
  
  //Gif stuff
  capturedFrames = 0;
  filenames = listFileNames(path);
  
  
  println(filenames);
}





void draw() {                                  
  if(keyPressed){
    gifExport.setDelay(100);
    gifExport.addFrame(cam);
    image(eyes, width/2, eyes.height/2); 
  }
}

void captureEvent(Capture c) {
  c.read();
}
                                          
void keyPressed() {
  if(!lastPressed){
    gifExport = new GifMaker(this, path + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + ".gif");
    newEyes();
    lastPressed = true;
  }
}

void keyReleased(){
  //gifExport.finish();
  lastPressed = false;
  println("gif saved");
}

void newEyes(){
  String[] eyesList = listFileNames(path);
  if(eyesList.length > 1){
    println(eyesList);
    int randIndex = (int)random(eyesList.length-1);
    String chosen = eyesList[randIndex];
    eyes = new Gif(this, path + chosen);
    eyes.play();
  } else{
    eyes = new Gif(this, "init.gif");
    eyes.play();
  }
}


// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}


