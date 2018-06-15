//RPG GAME concept
PFont battleMenuFont, menuFont;

Button playButton, exitButton, loadoutButton, talkTest, beginEncounter;
BattleMenu mainBattleMenu, attackMenu, supportMenu, confirmAttack, confirmSupport;
BattleGrid battleGrid;
PlayerCharacter playerCharacter;
Loadout gunshop;
Enemy goon;
Dialog dialog;
Weapon[] weapons = new Weapon[40];

boolean walkState = true;
boolean playersTurn, battleOrderSet = false;

int mX, mY, systemBusy, gameState,combatState,zone,difficulty,enemyState = 0;
int frames = 1;
//int intelPoints = 100; (now part of playerCharacter object)
int[] playerInventory = new int[8];
int[] playerLevels = new int [8];
int[]xCoordinate = new int[5];
int[]yCoordinate = new int[6];
IntList itemPrices, turnOrder;
IntDict loadout,weaponDamage, playerAttributes;

color[] colorScheme  = new color[16];

String[] playerEffects;
String[][] mainBattleMenuItems = new String[2][3];
String[][] attackMenuItems = new String[2][3];
String[][] supportMenuItems = new String[2][3];
StringList itemNotes,commandList,weaponList, textsList, enemyTypes;

PImage[] inventoryIcons = new PImage[8];
PImage[] imageAssets = new PImage[7]; // change this number to add images as i work
PImage walkingCharacter1, walkingCharacter2, walkingCharacter3, coveringCharacter, firingCharacter, invIcon0, invIcon1, invIcon2, invIcon3, invIcon4, invIcon5, invIcon6, invIcon7, armed0, armed1;
ArrayList menuArrays;


static class EGameState {
  static final int mainMenu = 0;
  static final int travel = 1;
  static final int battle = 2;
  static final int loadout = 3;
  static final int dialog = 4;
  static final int cutscene = 5;
  static final int dead = 99;
}

static class CombatState {
  static final int tier0 = 0;
  static final int tier1 = 1;
  static final int tier2 = 2;
  static final int confirmAction = 3;
  static final int aiming = 4;
  static final int attacking = 5;
  static final int debrief = 6;
  static final int waitingForEnemy = 7;
}

static class EnemyState {
  static final int waiting = 0;
  static final int takingTurn = 1;
  static final int turnReport = 2;
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
  playGame();
  crawlerText(frames);
  printInventory();
  talkTest.quickDisplay("radio");
  talkTest.clickCheck(mouseX,mouseY,4);
  //println(battleMenu.getTicker());
  //println(turnOrder);
  //println("goonHP"+goon.getHitPoints());


  frames++;
} //end draw
