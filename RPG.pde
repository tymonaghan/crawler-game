//RPG GAME concept
Button playButton, exitButton;
BattleMenu battleMenu;
int mX, mY = 0;
int frames = 1;
color[] colorScheme  = new color[16];
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
