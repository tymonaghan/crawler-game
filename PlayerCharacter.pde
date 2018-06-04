class PlayerCharacter {
  int hitPoints, bestWeapon;
  int [] playerInventory;
  int status = 0;
  int accuracy;
  // boolean walkSwitcher = true;

  PlayerCharacter(int hp_) {
    hitPoints = hp_;
    accuracy = -100;
  } //end playerCharacter constructor

  int getLightArmsSkill() { //should eventually make an array of skill levels
    return 5;
  }

  int getStatus() {
    return status;
  }

  void setStatus(int num_) {
    status = num_;
  } //end setStatus

  void playerAction(int i) { //  0 attack, 1 advance, 2 support, 3 flank, 4 cover, 5 retreat
    if (i==0) { //code for attack
      //attackMenu.displaySubMenu(1, 1, false); // needs tier, rows, alert
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

  void drawInCombat() {
    int status = playerCharacter.getStatus();
    stroke(colorScheme[4]);
    strokeWeight(2);
    fill(colorScheme[3]);
    rectMode (CORNER);
    rect(.75*width, .75*height, .2*width, .2*height);
    noTint();
    if (status == 0) { 
      imageMode(CORNER);
      image(coveringCharacter, .8*width, .7*height, coveringCharacter.width*3, coveringCharacter.height*3);
    } else if (status == 1) {
      imageMode(CORNER);
      image(firingCharacter, .8*width, .7*height, firingCharacter.width*3.2, firingCharacter.height*3.2);
    } // end if
  } //end character in combat

  void moveCharacter(int i) { //this gets fed the framecount so that it can switch walkStates
    noTint();
    if (i/10 %2 ==0) {
      image(walkingCharacter2, 100, height/1.75, 180, 200);
    } else {
      image(walkingCharacter3, 100, height/1.75, 180, 200);
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
    float barY = 0.08*height;
    float barWidth = 0.05*width;
    float barHeight = .6*height;
    float padding = 0.01*height;
    //draw the statusBar box:
    stroke(colorScheme[4]);
    fill(colorScheme[3]);
    strokeWeight(3);
    rectMode(CORNER);
    rect(barX, barY, barWidth, barHeight); //draw the status bar itself

    //draw the life bar and list HP
    if (hitPoints > 0) { //draw the colored bar if HP is over 0
      strokeWeight(1);
      stroke(colorScheme[0]);
      fill(200-hitPoints, hitPoints*2, 0);
      rectMode(CORNERS);
      stroke(0);
      strokeWeight(1);
      rect(barX+padding, barY+padding+barHeight/2, barX+barWidth-padding, barY+padding+barHeight/2-hitPoints*1.75); //draw colored HP bar
      textAlign(CENTER, TOP);
      textSize(14);
      fill(colorScheme[4]);
      text(hitPoints, barX+barWidth/2, barY+barHeight/2-15);
      if (mouseX >barX+padding && mouseX < barX+barWidth-padding && mouseY > barY + padding && mouseY <  barY+barHeight/2) {
        this.lifeBarPopup();
      } //end if mouse hovers on lifebar
    } else { //if HP reaches zero, just say DEAD
      fill(colorScheme[2]);
      textAlign(CENTER, TOP);
      text("DEAD", barX+barWidth/2, barY+barHeight/2);
      gameState = 99; //gamestate99 is player death
    } // end else (for when you're dead

    //print tally of intelPoints:
    textAlign(CENTER, BOTTOM);
    textSize(12);
    fill(0);
    text("Intel: "+intelPoints, barX, barY);
    //println(loadout.keyArray());
    //other shit for status bar -- inventory icons:
    for (int ii = 0; ii < playerInventory.length; ii++) { //for each inventory item:
      fill(colorScheme[1]);
      rectMode(CORNER);
      //rect(barX+padding, barY+padding*2+barHeight/2+20*ii, .02*width, .02*width); //little yellow circles
      imageMode(CORNER);
      noTint();
      if (playerInventory[ii] == 0 && ii >0) { //if quantity is 0, tint the icon red
        tint(255-playerInventory[ii]*5, 0, 0);
      } //end if redtint
      image(inventoryIcons[ii], barX+padding, barY+padding*2+barHeight/2+20*ii, .02*width, .02*width); //inventory icons
      fill(colorScheme[2]);
      textMode(CORNER);
      textAlign(LEFT, CENTER);
      textSize(16);
      fill(255);
      text(playerInventory[ii], barX+padding*4.4, barY+padding*3+barHeight/2+20*ii);
      //push style to show labels for inventory
      pushStyle();
      textSize(10);
      fill(colorScheme[0]);
      String [] labels = loadout.keyArray();
      //  for (int i = 0; i < playerInventory.length; i++) {
      //   text(labels[i], barX-padding*3, barY+ padding*5 + barHeight/2+20*i);
      // }//end for loop to print labels
      popStyle(); //pop style back to normal
      if (mouseX > barX+padding*(0.002*width) && mouseX < barX+padding+(0.018*width) && mouseY > barY+padding*2+barHeight/2+20*ii && mouseY < barY+padding*2+barHeight/2+20*ii+(0.02*width)) {
        statusBarPopup(ii);
      } //end if to create popups
    }//end for loop
  } // end status bar

  void hurtPlayer(int hp_) {
    int hurt = hp_;
    this.hitPoints -= hurt;
    text("goon hit you for "+hurt+" in damage", width/2, height/2);
  } //end hurtPlayer

  /* so far this is being handled by the loadout class
   void addInventory(int[] items_){
   //find a way to add these items to the player's inventory?
   } // end addInventory
   */

  void loadoutScreen(int[] inv_) {
    playerInventory = inv_;
    int bestWeapon=0;
    if (playerInventory[3] > 0) {
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

  int doAttack(int accy_) { //feed accuracy offset to this - lower is better, 0 is perfect.
    int accuracyOffset = abs(accy_);
    int damage = -5;
    int ticker = battleMenu.getTicker();
    if (ticker > 0) { //if wrapper to try to stop double-calling this function --seems to work
      if (playerInventory[6] < 1) {
        fill(colorScheme[2]);
        text("No ammo, cancelling attack", width/2, height/2);
        delay(150);
        battleMenu.resetMenuLevel();
        return 0;
      } else {
        playerInventory[6] --;
        fill(colorScheme[2]);
        text("HIT", width/2, height/2);
        playerCharacter.setStatus(1);
        goon.setHitPoints(-3, 0); //(damage, damagetype)
        delay(100);
        sequence++;
        advanceToNextTurn();
      }
      battleMenu.resetTicker();
    } // end if wrapper
    return damage;
  } //end doAttack

  void setAccuracy(int accy_) {
    accuracy = accy_;
  } //end setAccuracy

  int getAccuracy() {
    return accuracy;
  } //end getAccuracy

  void changeAccuracy(int change_) {
    int x = change_;
    int y = this.getAccuracy();
    this.setAccuracy(y+x);
  } //end changeaccuracy

  boolean checkDetected(int enemyVigilance_) {
    int playerStealthRoll = playerAttributes.get("stealth");
    int enemyVigilance = enemyVigilance_;
    if (playerStealthRoll > enemyVigilance) {
      return false;
    } else {
      return true;
    } //end else
  }

  void statusBarPopup(int location_) {
    int index = location_; // int index is index location in playerInventory
    String names[] = loadout.keyArray(); //names[] stringArray from loadout, which is the CATEGORY names.
    stroke(colorScheme[0]);
    fill(200);
    rectMode(CORNER);
    strokeWeight(3);
    textAlign(BOTTOM, LEFT);
    textMode(CORNER);
    if (index < 4) { //for the first four items, show popup with item name, inv slot, and description?
      rect(mouseX+20, mouseY+10, .3*width, .2*height); //draw popup rectangle
      fill(0);
      //if (playerInventory[index] == 0) { //if the inventory slot is at 0...
      //  text("[empty]", mouseX+30, mouseY+30);  // say it;s EMPTY
      //} else {
      text(weaponList.get(playerInventory[index]+index*10), mouseX+30, mouseY+30);
      //}
      text("\nweapon type: "+names[index], mouseX+30, mouseY+30);
    } else {
      rect(mouseX+20, mouseY+10, .2*width, .12*height);
      fill(0);
      textAlign(TOP, LEFT);
      text(names[index]+"\n"+itemNotes.get(index), mouseX+30, mouseY+10, .2*width, .12*height);
    } //end else
  } //end statusBarPopup

  void lifeBarPopup() {
    String labels[] = playerAttributes.keyArray(); //labels gets the name of each attribute
    //playerLevels[] stores the attribute levels, keyed to the names in labels[]
    stroke(colorScheme[0]);
    fill(200);
    rectMode(CORNER);
    strokeWeight(3);
    textAlign(LEFT, TOP);
    textMode(CORNER);
    rect(mouseX+20, mouseY, .4*width, .5*height);

    fill(0);
    textFont(menuFont);
    for (int i = 0; i < playerAttributes.size(); i++) {
      text(labels[i]+": "+playerLevels[i], mouseX+25, mouseY +30*i);
    } //end for loop
    text("effects: "+playerEffects, mouseX+25, mouseY + 30 * 8);
  } //end lifeBarPopup()
}
