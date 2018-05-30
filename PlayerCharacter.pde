class PlayerCharacter {
  int hitPoints;
  int [] playerInventory;

  PlayerCharacter() {
  } //end playerCharacter constructor

  void playerAction(int i) { //  0 attack, 1 advance, 2 support, 3 flank, 4 cover, 5 retreat
    if (i==0) {
      int n = 0;
      while (n <10) {
        status=1;
        n++;
      }
      status=0;
      println("attack");
      return;
    } else if (i ==1) {
      println("advance");
    } else if (i == 2) {
      println("support");
    } else if (i == 3) {
      println("flank");
    } else if (i == 4) {
      println("cover");
    } else if (i == 5) {
      println("retreat");
    }
  } //end playerAction

  void characterInCombat(int status) {
    stroke(colorScheme[4]);
    strokeWeight(2);
    fill(colorScheme[3]);
    rectMode (CORNER);
    rect(.75*width, .75*height, .2*width, .2*height);
    if (status == 0) { 
      imageMode(CORNER);
      image(coveringCharacter, .8*width, .7*height, coveringCharacter.width*3, coveringCharacter.height*3);
    } else if (status == 1) {
      imageMode(CORNER);
      image(firingCharacter, .8*width, .7*height, firingCharacter.width*3.2, firingCharacter.height*3.2);
    } // end if
  } //end character in combat
}
