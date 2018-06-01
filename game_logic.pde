void playGame(int state) {

  switch (gameState) {
  case EGameState.mainMenu:
    mainMenu();
    break;

  case EGameState.travel:
    travel();
    break;

  case EGameState.battle:
    //battleMenu.resetMenuLevel();
    battleDirector();
    break;

  case EGameState.loadout:
    gunshop.display();
    break;

  case EGameState.dead:
    deadScreen();
    break;

  case EGameState.dialog:
    dialog0.playScene();
    break;

  case EGameState.playerAttack:
    int accy = playerCharacter.getAccuracy();
    playerCharacter.doAttack(accy);
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

void deadScreen() {
  background(0);
  fill(255);
  text("you have died", width/2, height/2);
} // end deadscreen
