void playGame(int state){
  if (state == 0) {
    mainMenu();
  } else if (state == 1) {
    travel();
  } else if (state == 2) {
    battle();
  }
} //end playGame
