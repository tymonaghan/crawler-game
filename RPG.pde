//RPG GAME concept
Button playButton, exitButton, loadoutButton, talkTest;
BattleMenu battleMenu, attackMenu;
BattleGrid battleGrid;
PlayerCharacter playerCharacter;
Loadout gunshop;
Enemy goon;
Dialog dialog0;
int mX, mY, systemBusy, gameState,zone,difficulty,sequence = 0;
int frames = 1;
color[] colorScheme  = new color[16];
int[] playerInventory = new int[8];
int[] playerLevels = new int [8];
String[][] mainBattleMenu = new String[2][3];
String[] [] attackSubMenu = new String[2][3];
int[]xCoordinate = new int[4];
int[]yCoordinate = new int[3];
String[] playerEffects;
PImage[] inventoryIcons = new PImage[8];
PImage[] imageAssets = new PImage[6]; // change this number to add images as i work
int intelPoints = 100;
int walkCounter = 800;
PImage walkingCharacter1, walkingCharacter2, walkingCharacter3, coveringCharacter, firingCharacter, invIcon0, invIcon1, invIcon2, invIcon3, invIcon4, invIcon5, invIcon6, invIcon7, armed0, armed1;
boolean walkState = true;
boolean playersTurn, battleOrderSet = false;
PFont battleMenuFont, menuFont;
IntDict loadout,weaponDamage, playerAttributes;
StringList itemNotes,commandList,weaponList, textsList;
IntList itemPrices, turnOrder;
int menuX, menuY, menuWidth,menuHeight;

static class EGameState {
  static final int mainMenu = 0;
  static final int travel = 1;
  static final int battle = 2;
  static final int loadout = 3;
  static final int dialog = 4;
  static final int dead = 99;
}

static class Zone {
  static final int urban = 0;
  static final int desert = 1;
}

void setup() {
  size(800, 600);
  setupFunctions();
}

void draw() {
  playGame(gameState);
  crawlerText(frames);
  printInventory();
  talkTest.quickDisplay("radio");
  talkTest.clickCheck(mouseX,mouseY,4);
  //println(battleMenu.getTicker());
  //println(turnOrder);
  //println("goonHP"+goon.getHitPoints());


  frames++;
} //end draw
