void battleDirector() { //use this to call players turn by turn and end the battle
  background(colorScheme[0]);

  if (goon.getHitPoints() > 0) { // if the goon is still alive
    if (!battleOrderSet) { //if the battle order isn't set, set it (turn order based on speed and detection status)
      battleOrderSet = determineBattleOrder();
    }
    displayTurnPanel(); //if goon is alive, display the turn panel
    battle(); // always call battle() (draw grid, enemies, statusbar, and character)
    int[] turnOrderArray = turnOrder.array();
    if (turnOrderArray[0] == 1) { //if its the player's turn, call playersTurn()
            

      playersTurn();
      
      
    } else if (turnOrderArray[0] == 0){ //if it's not the player's turn, call enemyTurn()
            
      enemyTurn();
      
      
    } // end else
    playerCharacter.statusBar(playerInventory); // feed playerInventory array to the sstatusbar
      println(turnOrderArray[0]);

  } //end if goon is alive
  else { //but if goon is dead, debrief the battle
    debriefBattle();
  }
} //end battleDirector


boolean determineBattleOrder() { //run once at beginning of battle, or when needed(?)
  int playerSpeed = playerAttributes.get("speed"); //get playerSpeed attribute
  int enemySpeed = int(random(2, 5)); //get enemy speed attribute -- right now just a random int between 2-5
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
  return true; //true means battleOrderSet == true, so it won't keep re-running the turn order
}//end determineBattleOrder

void displayTurnPanel() {
  strokeWeight(5);
  stroke(colorScheme[4]);
  fill(colorScheme[3]);
  rectMode(CORNER);
  rect(.8*width, .3*height, .14*width, .4*height);
  drawTurnCards();
} //end displayTurnPanel

void drawTurnCards() { //draw the identity cards in the turn panel. in the future these could be done for each enemy and show their place on the grid per enemy.
  int xPos = int(.8*width);
  int yPos = int(.6*height);
  for (int i = 0; i <4; i++) {
    int num = turnOrder.get(i);
    rectMode(CORNER);
    strokeWeight(1);
    stroke(colorScheme[0]);
    fill(colorScheme[2-num]);
    rect(xPos, yPos-((.1*height)*i), .14*width, .1*height);
    rectMode(CORNER);
    fill(colorScheme[0]);
    textFont(menuFont);
    textSize(12);
    textAlign(CENTER, CENTER);
    text(textsList.get(num), xPos+5, yPos-((.1*height)*i), .14*width, .1*height);
  } //end for loop
  noFill();
  stroke(50, (frames*5)%200, 50);
  strokeWeight(5);
  rect(.8*width, .6*height, .14*width, .1*height);
} //end drawTurnCard

void battle() { //stuff that should ALWAYS be happening in battle. 
  battleGrid.drawGrid(); //draw battle grid
  battleGrid.drawEnemies(); //draw enemies
  playerCharacter.drawInCombat();
  //int menuLevel = mainBattleMenu.getMenuLevel(); //get the menu level of the battle (should reset at 0 beginning of each battle)
  //battleGrid.spawnEncounter();//this is looping , need to get it to just run once per encounter. <---now replaced by determineBattleOrder, but may need to bring this back for multiple-enemy encounters.
}

void playersTurn() {
  mainBattleMenu.displayBattleMenu(0);   //display the main tier-0 menu always
  int activeMenu = mainBattleMenu.getActiveMenu();

  switch (combatState) {
  case CombatState.tier0: //tier 0 - mainBattleMenu is active
    mainBattleMenu.clickCheck();
    break;

  case CombatState.tier1: //tier 1 - attackMenu is active (or supportMenu?)
    if (activeMenu ==10) {
      attackMenu.displayBattleMenu(1);
      attackMenu.clickCheck();
    } else if (activeMenu ==20) {
      supportMenu.displayBattleMenu(2);
      supportMenu.clickCheck();
    } 
    break;

  case CombatState.tier2:
    //not currently used
    break;

  case CombatState.confirmAction: //action 3: in confirmation dialogs
    if (activeMenu > 10 && activeMenu <20) {
      attackMenu.displayBattleMenu(1);
      int weaponID = playerCharacter.getActiveWeaponSlot();
      int enemyHP = goon.getHitPoints();
      confirmAttack.displayConfirmDialog(weaponID, enemyHP);
    } else if (activeMenu >20 && activeMenu < 30 ) {
      supportMenu.displayBattleMenu(2);
      int enemyHP = goon.getHitPoints();
      confirmSupport.displayConfirmDialog(37, enemyHP);
    } 
    break;

  case CombatState.aiming:
    if (activeMenu > 10 && activeMenu <20) {
      confirmAttack.aimGame();
    } else if (activeMenu > 20 && activeMenu < 30) {
      text("support used", width/2, height/2);
      delay(400);
    } // end 
    break;

  case CombatState.attacking: //action 5: attacking
    playerCharacter.doAttack();
playerCharacter.drawTurnReport();
    break;

  case CombatState.debrief: //action 5 debrief
    break;

  case CombatState.waitingForEnemy: //action 6 wait for enemy
    break;
  } // end switch
} //end playersTurn


void enemyTurn() { // enemy's turn
  switch (enemyState) {
  case EnemyState.waiting: //0 state
  break;

  case EnemyState.takingTurn: //1 state 
    goon.takeTurn();
    break;
  case EnemyState.turnReport: //2 state
    goon.drawTurnReport();
    setDelay();
    break;
  } //end enemyState switch
} //end enemyTurn



void advanceToNextTurn() {  //move the turnOrder down by 1, advance to next turn!
  combatState = 7; //set player to "waiting"
  enemyState = 0; // set enemy to "waiting"
  for (int i = 0; i < turnOrder.size()-1; i++) { //bump the turnOrder array down by 1
    int x = turnOrder.get(i+1);
    turnOrder.set(i, x);
  } //end for loop to bump turns down
    
  playerCharacter.setAccuracy(-100);
  mainBattleMenu.resetMenuLevel();
  mainBattleMenu.resetTicker();
    if (turnOrder.get(0) == 1){
combatState = 0;
    } else if (turnOrder.get(0) == 0) {
      enemyState=1;
    }
} // end advanceToNextTurn

void debriefBattle() { //screen to give XP and battle results. can assign each combat kill/action to a list/array, then reference that from this screen (wipe the array when done on this screen)
  textSize(50);
  text("battle over", width/2, height/2);
  delay(250);
  battleOrderSet = true;
  gameState=1;
} //end debriefBattle
