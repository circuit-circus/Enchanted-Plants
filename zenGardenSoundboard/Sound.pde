import ddf.minim.*;

class Sound {
  
  final AudioPlayer[] soundsX;

  Sound(String[] files) {
    
    print("Files: ");
    println(files);
    
    soundsX = new AudioPlayer[files.length - 1];
    print("Files length: " );
    println(files.length);

    for ( int idx = 0; idx < files.length; idx++) {
        print("idx: ");
        println(idx);
        
        print("sounds: ");
        println(soundsX);
        
        println(soundsX[idx]);
        soundsX[idx] = minim.loadFile( files[idx] + ".mp3");
    }

  }
  
  void playSound(int soundNo) {
    if( !soundsX[soundNo].isPlaying() ) {
      soundsX[soundNo].rewind();
      soundsX[soundNo].play();
    }
  }

  
}