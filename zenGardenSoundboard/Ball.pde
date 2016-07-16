
class Ball {
  float locX, locY, size;
  int bn;

  Ball(int ballNumber) {
    this.locX = width/2 + random(-250, 250);
    this.locY = height/2 + random(-250, 250);
    size = 50+ ballNumber * 2;
    bn = ballNumber;
  }

  void display() { 

    fill(200);
    ellipse(locX, locY, size, size);
    if (dist(mouseX, mouseY, this.locX, this.locY) < size) {

      switch(bn) {
      case 0:
        int no0 = int(random(0, arcades.length));
        if (arcades[no0].isPlaying() == false) {
          arcades[no0].rewind();
          arcades[no0].play();
        }
        break;
      case 1:
        int no1 = int(random(0, birds.length));
        if (birds[no1].isPlaying() == false) {
          birds[no1].rewind();
          birds[no1].play();
        }
        break;
      case 2:
        int no2 = int(random(0, chimes.length));
        if (chimes[no2].isPlaying() == false) {
          chimes[no2].setGain(-20);
          chimes[no2].rewind();
          chimes[no2].play();
        }
        break;

      case 3:
        int no3 = int(random(0, drips.length));
        if (drips[no3].isPlaying() == false) {
          drips[no3].rewind();
          drips[no3].play();
        }
        break;

      case 4:
        int no4 = int(random(0, fugle.length));
        if (fugle[no4].isPlaying() == false) {
          fugle[no4].rewind();
          fugle[no4].play();
        }
        break;

      case 5:
        int no5 = int(random(0, impacts.length));
        if (impacts[no5].isPlaying() == false) {
          impacts[no5].rewind();
          impacts[no5].play();
        }
        break;
      case 6:
        int no6 = int(random(0, kliks.length));
        if (kliks[no6].isPlaying() == false) {
          kliks[no6].rewind();
          kliks[no6].play();
        }
        break;
      case 7:
        int no7 = int(random(0, plings.length));
        if (plings[no7].isPlaying() == false) {
          plings[no7].setGain(-20);
          plings[no7].rewind();
          plings[no7].play();
          break;
        }
      }
    }
  }
}