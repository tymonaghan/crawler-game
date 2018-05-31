void playGame(int state) {

  switch (gameState) {
  case EGameState.mainMenu:
    mainMenu();
    break;

  case EGameState.travel:
    travel();
    break;

  case EGameState.battle:
    battle();
    break;

  case EGameState.loadout:
    gunshop.display();
    break;

  case EGameState.dead:
    deadScreen();
    break;
    
  case EGameState.dialog:
  dialog0.playScene();
  } // end switch
} //end playGame



void mainMenu() {
  stroke(255);
  background(100);
  imageMode(CENTER);
  image(imageAssets[4], width/2, height/2);
  playButton.display(150, 50, 0, 1, "PLAY");
  playButton.clickCheck(mouseX, mouseY, 1);
  loadoutButton.display(150, 50, 0, 2, "Loadout");
  loadoutButton.clickCheck(mouseX, mouseY, 3);
}

void travel() {
  background(255);
  fill(0);
  Button beginEncounter;
  beginEncounter = new Button(width-70, 50);
  beginEncounter.display(100, 50, 0, 1, "Battle init");
  beginEncounter.clickCheck(mouseX, mouseY, 2);
  movingBackground(zone);
  playerCharacter.moveCharacter(frames);
  playerCharacter.statusBar(playerInventory);
}

void battle() {
  background(colorScheme[0]);
  battleMenu.display();
  battleMenu.drawCursor();
  battleMenu.interact();
  talkTest.quickDisplay("kill");
  talkTest.clickCheckTwo(5);
  playerCharacter.statusBar(playerInventory);
  battleGrid.spawnEncounter();//this is looping , need to get it to just run once per encounter.
  playerCharacter.characterInCombat(status);
}

void deadScreen() {
  background(0);
  fill(255);
  text("you have died", width/2, height/2);
} // end deadscreen
