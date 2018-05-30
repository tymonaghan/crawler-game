//RPG GAME concept
Button playButton, exitButton, loadoutButton;
BattleMenu battleMenu;
BattleGrid battleGrid;
PlayerCharacter playerCharacter;
int mX, mY, status, systemBusy = 0;
int frames = 1;
color[] colorScheme  = new color[16];
int[] playerInventory = new int[10];
int gameState = 0;
int zone = 0;
PImage walkingCharacter1, walkingCharacter2, coveringCharacter, firingCharacter;
boolean walkState = true;
PFont battleMenuFont, menuFont;
IntDict intDict;

static class GameState {
  static final int mainMenu = 0;
  static final int travel = 1;
  static final int battle = 2;
  static final int loadout = 3;
}

static class Zone {
  static final int urban = 0;
  static final int desert = 1;
}

void setup(){
  size(800,600);
  setupFunctions();
}

void draw(){
  playGame(gameState);
  crawlerText(frames);
  frames++;

} //end draw
