void battleDirector() { //use this to call players turn by turn and end the battle
  battle();
  if (goon.getHitPoints() > 0) {
    if (!battleOrderSet) {
      battleOrderSet = determineBattleOrder();
    }
    displayTurnPanel();
    if (turnOrder.get(0) == 1) {
      playersTurn();
    } else {
      enemyTurn();
    } // end else
  } //end if goon is alive
  else {
    debriefBattle();
  }
} //end battleDirector


boolean determineBattleOrder() { //run once at beginning of battle, or when needed(?)
  int playerSpeed = playerAttributes.get("speed"); //get playerSpeed attribute
  int enemySpeed = int(random(2,5)); //get enemy speed attribute -- right now just a random int between 2-5
  boolean detected = playerCharacter.checkDetected(int(random(5))); //playerCharacter.checkDetected() takes the enemy's vigilance, as a random int, as parameter
  //println("detected: "+detected); //print whether or not detected
  turnOrder.clear(); //clear the turn order out -- might want to not do this every time!
  //if (!detected) {
  // turnOrder.set(0,1);
  //    return true;
  //} else {
  for (int i = 0; i <1000; i++) {
    if (i%(10-playerSpeed)==0) { //every time it hits the playerSpeed, add player's turn to the intList
      turnOrder.append(1);
    }  
    if (i%(10-enemySpeed)==0) {
      turnOrder.append(0);
    }//end for loop
  }
  return true;
}//end determineBattleOrder

void displayTurnPanel() {
  strokeWeight(5);
  stroke(colorScheme[4]);
  fill(colorScheme[3]);
  rectMode(CORNER);
  rect(.8*width, .3*height, .14*width, .4*height);
  drawTurnCards();
  noFill();
  stroke(colorScheme[1]);
  strokeWeight(5);
  rect(.8*width, .6*height, .14*width, .1*height);
} //end displayTurnPanel

void drawTurnCards() { //draw the identity cards in the turn panel. in the future these could be done for each enemy and show their place on the grid per enemy.
  int xPos = int(.8*width);
  int yPos = int(.6*height);
  for (int i = 0; i <4; i++) {
    int num = turnOrder.get(i);
    rectMode(CORNER);
    noStroke();
    fill(colorScheme[2-num]);
    rect(xPos, yPos-((.1*height)*i), .14*width, .1*height);
    textMode(CORNER);
    fill(colorScheme[0]);
    textFont(menuFont);
    textSize(12);
    text(textsList.get(num), xPos+5, yPos-((.1*height)*i), .14*width, .1*height);
  } //end for loop
} //end drawTurnCard

void battle() { //stuff that should ALWAYS be happening in battle. 
  background(colorScheme[0]);
  battleGrid.drawGrid(); //draw battle grid
  battleGrid.drawEnemies(); //draw enemies
  playerCharacter.statusBar(playerInventory); // feed playerInventory array to the sstatusbar
  playerCharacter.drawInCombat();
  //int menuLevel = battleMenu.getMenuLevel(); //get the menu level of the battle (should reset at 0 beginning of each battle)
  //battleGrid.spawnEncounter();//this is looping , need to get it to just run once per encounter.
}

void playersTurn() {
  battleMenu.displayBattleMenu();   //display the main tier-0 menu always
  //battleMenu.interact();
  int menuLevel = battleMenu.getMenuLevel();
/*
  if (menuLevel > 0) {
    attackMenu.displaySubMenu(1, 1, false);
  }

  if (menuLevel > 1) {
    battleMenu.confirmAttack(10); //pass the ID of the weapon used to attack...
  }

  if (menuLevel ==3 ) {
    int dmg = battleMenu.confirmAttack(10); //hard-coded with pellet gun ID for now.
    battleMenu.aimGame(dmg);
  } 

  if (menuLevel == 4) { //if the menu gets here, the attack has taken place - but this is a dumb way to handle this.
    int accuracy = playerCharacter.getAccuracy(); //lower is better
    //playerCharacter.doAttack(accuracy); //lower is better
    int damage = playerCharacter.doAttack(accuracy);
    delay(550);
    goon.setHitPoints(damage, 0);
    advanceToNextTurn();
  }//end ifs
  */

  //for-loop to bump the turn order down
}

void enemyTurn() { // enemy's turn
  int enemyDamage = int(random(0, 5)); //randomize enemy damage
  playerCharacter.hurtPlayer(enemyDamage); //hurt the player by that amount
  delay(200);
  sequence++;  //tick sequence forward, which i don't think actually does anything right now 
  //for-loop to bump the turn order down
  advanceToNextTurn();
} //end enemysturn

void advanceToNextTurn() {  //move the turnOrder down by 1, advance to next turn!
  delay(100);

  for (int i = 0; i < turnOrder.size()-1; i++) {
    int x = turnOrder.get(i+1);
    turnOrder.set(i, x);
  } //end for loop to bump turns down
  playerCharacter.setAccuracy(-100);
  playerCharacter.setStatus(0);

  battleMenu.resetMenuLevel();
} // end advanceToNextTurn

void debriefBattle() { //screen to give XP and battle results. can assign each combat kill/action to a list/array, then reference that from this screen (wipe the array when done on this screen)
  textSize(50);
  text("battle over", width/2, height/2);
  delay(250);
  gameState=1;
} //end debriefBattle
