//RPG GAME concept
Button playButton, exitButton, loadoutButton, killPlayer;
BattleMenu battleMenu;
BattleGrid battleGrid;
PlayerCharacter playerCharacter;
Loadout gunshop;
int mX, mY, status, systemBusy = 0;
int frames = 1;
color[] colorScheme  = new color[16];
int[] playerInventory = new int[8];
PImage[] inventoryIcons = new PImage[8];
PImage[] imageAssets = new PImage[2]; // change this number to add images as i work
int gameState = 0;
int zone = 0;
int intelPoints = 100;
int difficulty = 0; // affects item allotment and cost
int walkCounter = 800;
PImage walkingCharacter1, walkingCharacter2, walkingCharacter3, coveringCharacter, firingCharacter, invIcon0, invIcon1, invIcon2, invIcon3, invIcon4, invIcon5, invIcon6, invIcon7, armed0, armed1;
boolean walkState = true;
PFont battleMenuFont, menuFont;
IntDict loadout;
StringList itemNotes;
IntList itemPrices;

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
  printInventory();
  frames++;

} //end draw
