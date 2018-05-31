void playGame(int state) {
  if (state == 0) {
    mainMenu();
  } else if (state == 1) {
    travel();
  } else if (state == 2) {
    battle();
  } else if (state == 3) {
    gunshop.display();
  } else if (state == 99) {
    deadScreen();
  }// end ifs
} //end playGame



void mainMenu() {
  stroke(255);
  background(100);
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
  killPlayer.quickDisplay("kill");
  killPlayer.clickCheckTwo(5);
  playerCharacter.statusBar(playerInventory);
  battleGrid.spawnEncounter();//this is looping , need to get it to just run once per encounter.
  playerCharacter.characterInCombat(status);
}

void deadScreen() {
  background(0);
  fill(255);
  text("you have died", width/2, height/2);
} // end deadscreen
