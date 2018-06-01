void battleDirector() { //use this to call players turn by turn and end the battle
  battle();
  determineBattleOrder();
  displayTurnPanel();
  //drawTurnCards();
  println(turnOrder);
  if (turnOrder.get(0) == 1) {
    playersTurn();
  } else {
    enemyTurn();
  } // end else
} //end battleDirector

void determineBattleOrder() {
  int playerSpeed = playerAttributes.get("speed");
  int enemySpeed = int(random(2, 4));
  boolean detected = playerCharacter.checkDetected(int(random(5))); //playerCharacter.checkDetected() takes the enemy's vigilance, as a random int, as parameter
  println("detected: "+detected);
  turnOrder.clear();
  if (!detected) {
    turnOrder.append(1);
    return;
  } else {
    for (int i = 0; i <100; i++) {
      if (i%(10-playerSpeed)==i) { //every time it hits the playerSpeed, add player's turn to the intList
        turnOrder.append(1);
      }  
      if (i%(10-enemySpeed)==i) {
        turnOrder.append(0);
      }//end for loop
    }
  }
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
    int num = turnOrder.get(i+sequence);
    rectMode(CORNER);
    noStroke();
    fill(colorScheme[2-num]);
    rect(xPos, yPos-((.1*height)*i), .14*width, .1*height);
  } //end for loop
} //end drawTurnCard

void battle() {
  background(colorScheme[0]); 
  int menuLevel = battleMenu.getMenuLevel(); //get the menu level of the battle (should reset at 0 beginning of each battle)
  battleGrid.drawGrid();
  battleGrid.drawEnemies();
  //battleMenu.drawCursor(); (now handled inside battleMenu.display)
  talkTest.quickDisplay("kill");
  talkTest.clickCheckTwo(5);
  playerCharacter.statusBar(playerInventory);
  //battleGrid.spawnEncounter();//this is looping , need to get it to just run once per encounter.
  int status = playerCharacter.getStatus();
  playerCharacter.characterInCombat(status);
}

void playersTurn() {
  battleMenu.display(playersTurn);   //display the main tier-0 menu always
  battleMenu.interact();

  if (battleMenu.getMenuLevel() > 0) {
    attackMenu.displaySubMenu(1, 1, false);
  }

  if (battleMenu.getMenuLevel() > 1) {
    battleMenu.confirmAttack(10); //pass the ID of the weapon used to attack...
  }

  if (battleMenu.getMenuLevel() ==3 ) {
    int dmg = battleMenu.confirmAttack(10); //hard-coded with pellet gun ID for now.
    battleMenu.aimGame(dmg);
  } 

  if (battleMenu.getMenuLevel() == 4) {
    int accuracy = playerCharacter.getAccuracy(); //lower is better
    //playerCharacter.doAttack(accuracy); //lower is better
    delay(550);

    int damage = playerCharacter.doAttack(accuracy);
    goon.setHitPoints(damage, 0);
  }//end ifs
}

void enemyTurn(){
  int enemyDamage = int(random(0,5));
  playerCharacter.hurtPlayer(enemyDamage);
  sequence++;
} //end enemysturn
