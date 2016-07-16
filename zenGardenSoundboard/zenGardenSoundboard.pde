import ddf.minim.*;
AudioPlayer backtrack;



final static String[] chimesFiles = {
  "c0", "c1", "c2", "c3", "c4", "c5", "c6", "c7", "c8", "c9"
};

final static String[] klikFiles = {
  "k0", "k1", "k2", "k3", "k4", "k5", "k6"
};

final static int numSongsC = chimesFiles.length-1;
final static AudioPlayer[] chimes = new AudioPlayer[numSongsC];

final static int numSongsK = chimesFiles.length-1;
final static AudioPlayer[] kliks = new AudioPlayer[numSongsK];

final Minim minim = new Minim(this);

int num = 1;

void setup() {

  size(600, 600);
  smooth();
  noFill();
 

  for ( byte idx = 0; idx != numSongsC; 
    chimes[idx] = minim.loadFile( chimesFiles[idx++] + ".mp3") );

  for ( byte idx = 0; idx != numSongsK; 
    kliks[idx] = minim.loadFile( klikFiles[idx++] + ".mp3") );



  backtrack = minim.loadFile("backtrack.mp3", 2048);
  
  backtrack.loop();
  
}

void draw() {
//Volume control
//backtrack.setGain(-20);
  if (mousePressed) {
    num = key-48;
    if (mouseX > width/2) {
      chimes[num].rewind();
      chimes[num].play();
      
    } else {
      kliks[num].rewind();
      kliks[num].play();
      
    }
  } else {
    num = 0;
  }

  /*if (chimes[num].isPlaying()==false) {
    println(chimes[num].isPlaying());
    chimes[num].rewind();
  }

  if (kliks[num].isPlaying()==false) {
    kliks[num].rewind();
  }*/
  kliks[num].setGain(map(mouseY,0,width,-20,20));
  chimes[num].setGain(map(mouseY,0,width,-40,20));
}