import ddf.minim.*;
import processing.serial.*;
import org.firmata.*;
import cc.arduino.*;
import java.util.*;


AudioPlayer backtrack;
Arduino arduino; 
Serial myPort;

float range;

// Communicate with arduino
String serialVal;
float serialNo;
int lf = 10;    // Linefeed in ASCII

int count = 0;

final static String[] arcadeFiles = {
  "a0", "a1", "a5"
};

final static String[] birdFiles = {
  "b0", "b1", "b2", "b3", "b4"
};

final static String[] chimesFiles = {
  "c0", "c1", "c2", "c3", "c4"
};

final static String[] dripFiles = {
  "d0", "d1", "d3"
};

final static String[] fugleFiles = {
  "f1", "f3"
};

final static String[] impactFiles = {
  "i1", "i2", "i3"
};


final static String[] klikFiles = {
  "k0", "k1", "k2", "k3", "k4", "k5", "k6", "k7", "k8", "k9", "k10", "k11"
};

final static String[] plingFiles = {
  "p0", "p1", "p3"
};

final static AudioPlayer[] arcades = new AudioPlayer[arcadeFiles.length-1];
final static AudioPlayer[] birds = new AudioPlayer[birdFiles.length-1];
final static AudioPlayer[] chimes = new AudioPlayer[chimesFiles.length-1];
final static AudioPlayer[] drips = new AudioPlayer[dripFiles.length-1];
final static AudioPlayer[] fugle = new AudioPlayer[fugleFiles.length-1];
final static AudioPlayer[] impacts = new AudioPlayer[impactFiles.length-1];
final static AudioPlayer[] kliks = new AudioPlayer[klikFiles.length-1];
final static AudioPlayer[] plings = new AudioPlayer[plingFiles.length-1];

ArrayList<AudioPlayer[]> soundList = new ArrayList<AudioPlayer[]>();


final Minim minim = new Minim(this);


void setup() {

  size(10, 10);
  smooth();
  noFill();
  background(255);

  // init Arduino 
  println(Serial.list());
  String portName = Serial.list()[7]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600); 
  myPort.clear();


  // Fill sounds
  for ( byte idx = 0; idx != arcadeFiles.length-1; 
  arcades[idx] = minim.loadFile( arcadeFiles[idx++] + ".mp3") );

  for ( byte idx = 0; idx != birdFiles.length-1; 
  birds[idx] = minim.loadFile( birdFiles[idx++] + ".mp3") );

  for ( byte idx = 0; idx != chimesFiles.length-1; 
  chimes[idx] = minim.loadFile( chimesFiles[idx++] + ".mp3") );

  for ( byte idx = 0; idx != dripFiles.length-1; 
  drips[idx] = minim.loadFile( dripFiles[idx++] + ".mp3") );

  for ( byte idx = 0; idx != fugleFiles.length-1; 
  fugle[idx] = minim.loadFile( fugleFiles[idx++] + ".mp3") );

  for ( byte idx = 0; idx !=impactFiles.length-1; 
  impacts[idx] = minim.loadFile( impactFiles[idx++] + ".mp3") );

  for ( byte idx = 0; idx != klikFiles.length-1; 
  kliks[idx] = minim.loadFile( klikFiles[idx++] + ".mp3") );

  for ( byte idx = 0; idx !=plingFiles.length-1; 
  plings[idx] = minim.loadFile( plingFiles[idx++] + ".mp3") );

  soundList.add(arcades);
  soundList.add(birds);
  soundList.add(chimes);
  soundList.add(drips);
  soundList.add(fugle);
  soundList.add(impacts);
  soundList.add(kliks);
  soundList.add(plings);

  // Start backtrack
  backtrack = minim.loadFile("backtrack.mp3", 2048);
  backtrack.loop();

  // Init serial prints from Arduino
  serialVal = myPort.readStringUntil(lf);
  serialVal = null;
}

void draw() {

  while (myPort.available () > 0) {  // If data is available,

    serialVal = myPort.readStringUntil(lf);
    if (serialVal != null) {
      print("Serial val from Arduino: ");
      println(serialVal);
      serialNo = float(serialVal);  // Converts and prints float
      if (!Float.isNaN(serialNo) && serialNo <= 23) {
        print("Serial no in float: ");
        println(serialNo);
  
        /*
        
         if (serialNo == ) {
         int serialNoInt = 0; // arcades
         } else if (serialNo == ) {
         int serialNoInt = 1; //birds
         } else if(serialNo == ) {
         int serialNoInt = 2; // chimes
         } else if(serialNo == ) {
         int serialNoInt = 3; // drips
         } else if(serialNo == ) {
         int serialNoInt = 4; // fugle
         } else if(serialNo == ) {
         int serialNoInt = 5; // impacts
         } else if(serialNo == ) {
         int serialNoInt = 6; // kliks
         } else if(serialNo == ) {
         int serialNoInt = 7; // plings
         } 
         
         */
  
        serialNo = map(serialNo, 0, 23, 0, 7); 
        int serialNoInt = int(serialNo);
  
        print("Mapped sound: ");
        println(serialNoInt);
  
        AudioPlayer[] currentSound = soundList.get(serialNoInt);
  
        int no = int(random(0, currentSound.length));
        if (currentSound[no].isPlaying() == false) {
          currentSound[no].rewind();
          currentSound[no].play();
        };
      } else {
        println("WRONG");
      }

      
    }
  } 

  myPort.clear();
}

