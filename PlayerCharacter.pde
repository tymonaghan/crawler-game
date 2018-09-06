class PlayerCharacter {
  int hitPoints, bestWeapon, activeWeapon;
  int [] playerInventory;
  int status = 0;
  int accuracy;
  int intelPoints;
  int charactersTyped=0;
  int recruitProgress=0;
  String firstName;
  String lastName;
  char keyy ='a';
  boolean redrawCTUscreen = true;
  // boolean walkSwitcher = true;

  PlayerCharacter(int hp_) {
    hitPoints = hp_;
    accuracy = -100;
    intelPoints = 100;
    activeWeapon = 0;
  } //end playerCharacter constructor

  void setFirstName(String name) {
    firstName = name;
  } // end setFirstName

  void setLastName(String name) {
    lastName = name;
  } //end setLastName


  int getLightArmsSkill() { //should eventually make an array of skill levels
    return 5;
  }

  int getStatus() {
    return status;
  }

  int getActiveWeaponSlot() {
    return activeWeapon;
  } // getActiveWeaponSlot

  void setActiveWeaponSlot(int setter_) {
    activeWeapon = setter_;
  } // end setActiveWeaponSlot

  void modIntelPoints(int intelModBy_) {
    intelPoints = intelPoints + intelModBy_;
  } //modify intel points

  int getIntelPoints () {
    return intelPoints;
  } //end get intel points

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
    fill(6);
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
      rectMode(CORNER);
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
    playerCharacter.hitPoints -= hurt;
    //text("goon hit you for "+hurt+" in damage", width/2, height/2);
    //delay(200);
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

  void doAttack() { //feed accuracy offset to this - lower is better, 0 is perfect.
    // int accuracyOffset = abs(accy_);
    int damage = -5;
    int ticker = mainBattleMenu.getTicker();
    if (ticker > 0) { //if wrapper to try to stop double-calling this function --seems to work
      /*
      if (playerInventory[6] < 1) {
       fill(colorScheme[2]);
       text("No ammo, cancelling attack", width/2, height/2);
       delay(150);
       mainBattleMenu.setActiveMenu(0);
       combatState = 0;
       return 0;
       } else {
       */
      playerInventory[6] --;
      //mainBattleMenu.drawTurnReport();

      playerCharacter.setAccuracy(-99);
      mainBattleMenu.resetCursor();
      goon.setHitPoints(-3, 0); //(damage, damagetype)
      advanceToNextTurn();
      combatState = 7;
    }
    mainBattleMenu.resetTicker();
    //} // end if wrapper
    return;  //(trying this as a void, instead of int
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
    rectMode(CORNER);
    if (index < 4) { //for the first four items, show popup with item name, inv slot, and description?
      rect(mouseX+20, mouseY+10, .35*width, .2*height); //draw popup rectangle
      fill(0);
      //if (playerInventory[index] == 0) { //if the inventory slot is at 0...
      //  text("[empty]", mouseX+30, mouseY+30);  // say it;s EMPTY
      //} else {
      text(weaponList.get(playerInventory[index]+index*10), mouseX+30, mouseY+30);
      //}
      text("\nweapon type: "+names[index], mouseX+30, mouseY+30);
    } else {
      rect(mouseX+20, mouseY+10, .25*width, .12*height);
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
    rectMode(CORNER);
    rect(mouseX+20, mouseY, .4*width, .5*height);

    fill(0);
    textFont(menuFont);
    for (int i = 0; i < playerAttributes.size(); i++) {
      text(labels[i]+": "+playerLevels[i], mouseX+25, mouseY +30*i);
    } //end for loop
    text("effects: "+playerEffects, mouseX+25, mouseY + 30 * 8);
  } //end lifeBarPopup()

  void drawTurnReport() { //popup showing the results of the player's turn, disappears after delay
    println("you are reaching the playerCharacter.drawTurnReport function");
    int ticker = mainBattleMenu.getTicker();
    fill( colorScheme[3]); //static colors
    stroke (colorScheme[4]);
    if (playerCharacter.hitPoints <25) {
      stroke(colorScheme[2]);
    } //end if
    strokeWeight(5);
    rectMode(CENTER);
    rect(width/2, height/2, width/5, height/5);
    fill(colorScheme[4]);
    text("you attacked "+enemyTypes.get(0)+"\nand did ___ dmg", width/2, height/2);
    ticker++;
    setDelay();
  } //end drawTurnReport

  void incrementRecruitProgress(int increment_) {
    int increment = increment_;
    recruitProgress+=increment;
  } //end incrementRecruitProgress

  int getRecruitProgress() {
    return recruitProgress;
  } //end getRecruitProgress

  void redrawCTUscreen() {
    playerCharacter.redrawCTUscreen = true;
  } // end redrawCTUscreen

  void recruitMenu() {
    cursor(TEXT);
    println("**recruit progress:"+recruitProgress+"**");
    if (redrawCTUscreen) {
      imageMode(CENTER);
      image(CTUscreen, width/2, height/2, .75*width, .6*height);
      redrawCTUscreen=false;
    }
    //int recruitProgresss = getRecruitProgress(); //do i need to use getRecruitProgress here?
    if (playerCharacter.getRecruitProgress() ==0) {
      playerCharacter.firstNamePrompt();
      playerCharacter.listenForName(0);
    } else if (playerCharacter.getRecruitProgress() ==1) {
      playerCharacter.lastNamePrompt();
      playerCharacter.listenForName(1);
    } else if (playerCharacter.getRecruitProgress() ==2) {
    }
  } //end recruitMenu


  void firstNamePrompt() {
    //then the prompt
    stroke(colorScheme[0]);
    rectMode(CORNER);
    strokeWeight(3);
    textAlign(LEFT, TOP);
    rectMode(CENTER);
    fill(255);
    textFont(menuFont);
    rectMode(CORNER);
    text("FIRST NAME:", .35*width, .4*height, .3*width, .3*height);
    stroke(0);
    strokeWeight(2);
    stroke(colorScheme[0]);
    fill(255);
    rect(.4*width, .45*height, .2*width, .05*height);
  }//end firstNamePrompt

  void lastNamePrompt() {
    //show the CTUscreen background:
    imageMode(CENTER);
    image(CTUscreen, width/2, height/2, .75*width, .6*height);
    // then the prompt:
    stroke(colorScheme[0]);
    rectMode(CORNER);
    strokeWeight(3);
    textAlign(LEFT, TOP);
    rectMode(CENTER);
    fill(255);
    textFont(menuFont);
    rectMode(CORNER);
    text("LAST NAME:", .35*width, .4*height, .3*width, .3*height);
    stroke(0);
    strokeWeight(2);
    stroke(colorScheme[0]);
    fill(255);
    rect(.4*width, .45*height, .2*width, .05*height); //white text box
  }//end lastNamePrompt

  void listenForName(int whichName_) {
    fill(0);
 
    String tempName = new String(playerNameChars);

    if (keyPressed == true && globalTicker > 9 ) { //this globalTicker shit is so hacky - there has to be a smarter way to do this
      if (key == ENTER || key == RETURN) {
        //add a line to check that the char[] has contents
        globalTicker=1;
        if (whichName_ == 0) {
          playerCharacter.setFirstName(tempName.toUpperCase());
                  playerNameChars= new char[0];

        } else if (whichName_ == 1) {
          
          playerCharacter.setLastName(tempName.toUpperCase());
                  playerNameChars= new char[0];

        } // end if for assigning the name
        playerCharacter.incrementRecruitProgress(1);
        redrawCTUscreen();
        playerNameChars= new char[0];
        charactersTyped=0;
      } else if (key == BACKSPACE || key == DELETE) { //end if enter is pressed, begin if delete is pressed
        playerNameChars= new char[0];
        rectMode(CORNER);
        fill(255);
        charactersTyped=0;
        rect(.4*width, .45*height, .2*width, .05*height);
      }// end if delete is pressed
      // keyy = key;
      playerNameChars = expand(playerNameChars, playerNameChars.length+1);
      if (whichName_ ==0){
      playerNameChars[charactersTyped] = key;
      } else if (whichName_ == 1){
              playerNameChars[charactersTyped-1] = key;
      }
      //playerNameChars = append(playerNameChars, key);
      globalTicker = 5;
      charactersTyped++;
    } //end if key pressed
    if (playerNameChars.length >0){
    rectMode(CORNER);
    text(tempName, .42*width, .45*height);
          println(playerNameChars);
    } // end if playerNameChars length is not zero
  } //end listenForName
} // end playerCharacter
