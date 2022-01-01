import processing.svg.*;
import processing.sound.*;


PFont f;                           
int numPixels;  
int colorcounter = 0;
int correctCount = 0;
String[] quantumCorpusLoad;
String[] finalQuantumArray;
String letterToRender = "#";
String quantumDataSource = "path/to/quantum/data";
String desiredValue;
int scale = 10;
int coreWidth = 100;
int coreHeight = 70;
int foregroundIncrement = 0;

int animationIndex = 5000; //starting 5 rows down

int playingAudio = 0;
  
void setup() {
  size(1000,800); //need to be scaled witht he scale factor (at least the width does)
  f = createFont("IBMPlexSans-SemiBold",12,false);
  letterToBinaryString(letterToRender);
  background(255);
  drawStartingImage();
  numPixels = coreWidth*coreHeight;
  countPixels();
  fetchAudio();
  loadPixels();
  
}

void draw() {
  
  float threshold = 255;
  color a = pixels[animationIndex];
  if (!foregroundSound[playingAudio].isPlaying()) {
     
    if (red(a) < threshold) { // If the pixel is brighter than this
      replaceWithCircuitValue(animationIndex);
      colorcounter++;
    } 
    
    animationIndex ++;
    
    if ((animationIndex % 50) == 0) {
      animationIndex += 950; //animation index minus canvas width
    }
  
  }
  
}

void countPixels() {
  loadPixels();
  parseCorpus();
}

void replaceWithCircuitValue(int i) {
      double ycoordinate = Math.floor(i/(coreWidth * scale));
      double xcoordinate = i - (ycoordinate*width);
       //convert to 
      float x = (float) xcoordinate;
      float y = (float) ycoordinate;
      
      noFill();
      
      int binaryToInt = Integer.parseInt(finalQuantumArray[colorcounter], 2);
      
    if (finalQuantumArray[colorcounter].equals(desiredValue)){
       stroke(0);
       strokeWeight(2);
       rect(x*scale, y*scale, ceil(binaryToInt/10), ceil(binaryToInt/10)); //the 10 here is to scale down the value
       correctCount++;
       foregroundSound[foregroundIncrement].play();
       playingAudio = foregroundIncrement;
       //increment through the foreground files
       if (foregroundIncrement >= stringsFiles.length - 1) {
         foregroundIncrement = 0;
       } else {
         foregroundIncrement ++;
       }
    } else {
      if (binaryToInt >= fluteFiles.length) {
        binaryToInt = fluteFiles.length-1;
      }
      backgroundSound[binaryToInt].play();
      
      stroke(150);
      strokeWeight(0.5);
      
      color gray = #878D96;
      stroke(gray);
      
      //squares
      rect(x*scale, y*scale, ceil(binaryToInt/10), ceil(binaryToInt/10));

    }
}

void parseCorpus() {
  quantumCorpusLoad = loadStrings(quantumDataSource + ".txt");
  finalQuantumArray = quantumCorpusLoad[0].replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("\\s", "").replaceAll("'", "").split(",");
}

void drawStartingImage() {
  textFont(f,64);
  fill(0);
  text(letterToRender,10,50);
}

void coverStartingImage () {
  fill(255);
  stroke(255);
  rect(0, 0, coreWidth, coreHeight);
}

void letterToBinaryString(String letter) {
  char letterAsInt = letter.charAt(0);
  int num = letterAsInt;
  desiredValue = Integer.toBinaryString(num);
}
