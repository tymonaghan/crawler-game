class PlayerCharacter {
  int hitPoints, bestWeapon;
  int [] playerInventory;
  // boolean walkSwitcher = true;

  PlayerCharacter(int hp_) {
    hitPoints = hp_;
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

  void moveCharacter(int i) { //this gets fed the framecount so that it can switch walkStates
    if (i/10 %2 ==0) {
      image(walkingCharacter2, 50, height/1.75, 180, 200);
    } else {
      image(walkingCharacter3, 50, height/1.75, 180, 200);
      //walkSwitcher = !walkSwitcher;// end else
    }
    if (i % 10 == 0) {
    }
    /* unused third animation state
     if (i/5%3==0 && walkSwitcher) {
     image(walkingCharacter1, 50, height/1.75, 180, 200);
     } else
     */
  } //end moveCharacter

  void statusBar(int inv_[]) {
    playerInventory = inv_;
    float barX = 0.05*width;
    float barY = 0.1*height;
    float barWidth = 0.05*width;
    float barHeight = .5*height;
    float padding = 0.01*height;
    //draw the statusBar box:
    stroke(colorScheme[4]);
    fill(colorScheme[3]);
    strokeWeight(3);
    rectMode(CORNER);
    rect(barX, barY, barWidth, barHeight);

    //draw the life bar and list HP
    if (hitPoints > 0) { //draw the colored bar if HP is over 0
      strokeWeight(1);
      stroke(colorScheme[0]);
      fill(200-hitPoints, hitPoints*2, 0);
      rectMode(CORNERS);
      stroke(0);
      strokeWeight(1);
      rect(barX+padding, barY+padding+barHeight/2, barX+barWidth-padding, barY+padding+barHeight/2-hitPoints*1.5);
      textAlign(CENTER, TOP);
      text(hitPoints, barX+barWidth/2, barY+padding+barHeight/2);
    } else { //if HP reaches zero, just say DEAD
      fill(colorScheme[2]);
      textAlign(CENTER, TOP);
      text("DEAD", barX+barWidth/2, barY+padding+barHeight/2);
      gameState = 99; //gamestate99 is player death
    } // end else (for when you're dead

    //print tally of intelPoints:
    textAlign(CENTER, BOTTOM);
    textSize(10);
    fill(0);
    text("Intel: "+intelPoints, barX, barY);
    //println(loadout.keyArray());
    //other shit for status bar -- inventory icons:
    for (int ii = 0; ii < playerInventory.length; ii++) {
      fill(colorScheme[1]);
      rectMode(CORNER);
      rect(barX+padding, barY+padding*5+barHeight/2+20*ii, .02*width, .02*width);
      fill(colorScheme[2]);
      textAlign(LEFT, CENTER);
      textSize(16);
      text(playerInventory[ii], barX-padding, barY+padding*5+barHeight/2+20*ii);
      //push style to show labels for inventory
      pushStyle();
      textSize(10);
      fill(colorScheme[0]);
      String [] labels = loadout.keyArray();
      for (int i = 0; i < playerInventory.length; i++) {
        text(labels[i], barX-padding*3, barY+ padding*5 + barHeight/2+20*i);
      }//end for loop to print labels
      popStyle(); //pop style back to normal
    }//end for loop
  } // end status bar

  void hurtPlayer(int hp_) {
    int hurt = hp_;
    this.hitPoints -= hurt;
  } //end hurtPlayer

  /* so far this is being handled by the loadout class
   void addInventory(int[] items_){
   //find a way to add these items to the player's inventory?
   } // end addInventory
   */

  void loadoutScreen(int[] inv_) {
    playerInventory = inv_;
    int bestWeapon=0;
    if (playerInventory[3] > 0){
      bestWeapon = 3;
    } else if (playerInventory[2] !=0) {
      bestWeapon = 2;
    } else if (playerInventory[1] != 0) {
      bestWeapon = 1;
    } else {
      bestWeapon = 0;
    } // end if-els    

      rectMode(CENTER);
    image(imageAssets[bestWeapon], .45*width, 0.25*height, imageAssets[bestWeapon].width*3, imageAssets[bestWeapon].height*3);
  } //end loadoutScreen
}
