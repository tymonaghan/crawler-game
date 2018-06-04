void setupFunctions() {
  initializeListsAndArrays();
  initializeObjects();
  initializeImages();
  frameRate(25);

 
  battleMenuFont = createFont("c:/WINDOWS/FONTS/OCRAEXT.TTF", 18); //load fonts, use the processing tool to include these in sketch itself
  menuFont = createFont("c:/WINDOWS/FONTS/BOOKOS.TTF", 22);
} //end setupFunctions

color getBgColor(int zone) { //get background color based on current zone
  if (zone == 0) {
    return colorScheme[3];
  } else {
    return colorScheme[2];
  }
} //end get bg color

color getTextColor(int zone) { //get text color based on current zone
  if (zone == 0) {
    return colorScheme[4];
  } else {
    return colorScheme[1];
  }
} // end get text color


void printInventory() { //prints inventory to console until I code this into the game itself
  String [] labels = loadout.keyArray();
  println("\n\n\nyour inventory:");
  for (int i = 0; i < playerInventory.length; i++) {
    println(labels[i]+": "+playerInventory[i]);
  } // end for loop for printing inventory
} //end printInventory



void initializeListsAndArrays() {

  loadout = new IntDict();
  loadout.set("melee", 0);
  loadout.set("small weap.", 1);
  loadout.set("medium weap.", 2);
  loadout.set("heavy weap.", 3);
  loadout.set("flash-grenade", 4);
  loadout.set("frag-grenade", 5);
  loadout.set("light-ammo", 6);
  loadout.set("heavy-ammo", 7);

  weaponDamage = new IntDict();

  weaponDamage.set("none", 0);

  weaponDamage.set("fists", 1);
  weaponDamage.set("ball pt pen", 2);

  weaponDamage.set("pellet gun", 4);

  playerAttributes = new IntDict();
  playerAttributes.set ("stealth", 0);
  playerAttributes.set ("small arms", 1);
  playerAttributes.set ("heavy ordnance", 2);
  playerAttributes.set( "speed", 3);
  playerAttributes.set("toughness", 4);
  playerAttributes.set ("electronics", 5);
  playerAttributes.set("persuasion", 6);
  playerAttributes.set("instincts", 7);

  for (int i = 0; i <playerLevels.length-1; i++) {
    playerLevels[i] = 0;
  } //end assign all 0s to player level

  itemNotes = new StringList();
  itemNotes.set(0, "unlimited use");
  itemNotes.set(1, "uses light ammo");
  itemNotes.set(2, "uses light ammo");
  itemNotes.set(3, "uses heavy ammo");
  itemNotes.set(4, "stuns enemies");
  itemNotes.set(5, "does area damage");
  itemNotes.set(6, "for handgun and carbine");
  itemNotes.set(7, "for heavy weapon");

  commandList = new StringList();
  commandList.set(0, "attack");
  commandList.set(1, "action2");


  weaponList = new StringList();
  weaponList.set(0, "fists");
  weaponList.set(1, "ball pt pen");
  weaponList.set(2, "pocket knife");
  weaponList.set(3, "combat's knife");
  weaponList.set(4, "crowbar");
  weaponList.set(5, "tanto");
  weaponList.set(6, "cutlass");
  weaponList.set(7, "aluminum bat");
  weaponList.set(8, "claymore");
  weaponList.set(9, "katana");

  weaponList.set(10, "none");
  weaponList.set(11, "sat. night spec.");
  weaponList.set(12, "luger");
  weaponList.set(13, "9mm semi");
  weaponList.set(14, ".45 USP");
  weaponList.set(15, "glock");
  weaponList.set(16, "desert eagle");
  weaponList.set(17, "magnum revolver");
  weaponList.set(18, "flare gun");
  weaponList.set(19, "sawed shotgun");

  weaponList.set(20, "none");
  weaponList.set(21, "klobb");
  weaponList.set(22, "mp5");
  weaponList.set(23, "aks-74u");
  weaponList.set(24, "m1");
  weaponList.set(25, "g3a3");
  weaponList.set(26, "m4a1");
  weaponList.set(27, "g36c");
  weaponList.set(28, "scar-h");
  weaponList.set(29, "SUROS regime");

  weaponList.set(30, "none");
  weaponList.set(31, "javelin");
  weaponList.set(32, "steel brimmed bowler");
  weaponList.set(33, "jar of ball bearings");
  weaponList.set(34, "SPAS-12");
  weaponList.set(35, "harpoon gun");
  weaponList.set(36, "PSG-1");
  weaponList.set(37, "jar of spiders");
  weaponList.set(38, "curtain call");
  weaponList.set(39, "railgun");


  itemPrices = new IntList();
  itemPrices.set(0, 0);
  itemPrices.set(1, 40);
  itemPrices.set(2, 70);
  itemPrices.set(3, 140);
  itemPrices.set(4, 40);
  itemPrices.set(5, 50);
  itemPrices.set(6, 10);
  itemPrices.set(7, 35);

  turnOrder = new IntList();  //holder for turn order
  for (int i = 0; i < 50; i++) {
    turnOrder.set(i, int(random(2)));
  } // end put together fake turnlist

  textsList = new StringList();  //random texts for menus, etc
  textsList.set(0, "enemy's turn");
  textsList.set(1, "your turn");


  for (int i = 0; i < playerInventory.length; i++) {  //load inventory icon images
    inventoryIcons[i] = loadImage("inv-icon"+i+".png");
  } //end for loop to initialize inventory images

  int whilst = 0;      //the little images of the armed player-character for loadout screen
  while (whilst < 4) {
    imageAssets[whilst] = loadImage("armed"+whilst+".png");
    whilst++;
  }

  //init color scheme - can hold 16
  colorScheme[0] = color(0, 0);
  colorScheme[1] = color(227, 208, 0); //burnt yellow
  colorScheme[2] = color(227, 64, 0); //red
  colorScheme[3] = color(70, 70, 70); //dark gray  
  colorScheme[4] = color(235); //white(ish)
  colorScheme[5] = color(#75CB58); // pale green
  colorScheme[6] = color(#C4C4C4); // light gray

  //init playerInventory array
  for (int i = 0; i < playerInventory.length; i++) {
    playerInventory[i] = 1; //3 of all weapons
    if (i > 5) {
      playerInventory[i] = 50;
    } // end 50 for ammo
  } // end for-loop initializing playerInventory

  mainBattleMenu[0][0] = "attack";
  mainBattleMenu[0][1] = "support";
  mainBattleMenu[0][2] = "cover";
  mainBattleMenu[1][0] = "Advance";
  mainBattleMenu[1][1] = "flank";
  mainBattleMenu[1][2] = "retreat";

  attackSubMenu[0][0] = "melee";
  attackSubMenu[0][1] = "small weap.";
  attackSubMenu[0][2] = "medium weap.";

  xCoordinate[0] = 120;
  xCoordinate[1] = 230;
  xCoordinate[2] = 250;
  xCoordinate[3] = 360;

  yCoordinate[0] = 430;
  yCoordinate[1] = 470;
  yCoordinate[2] = 510;
} //end initializeListsAndArrays


void initializeObjects() {
  playButton = new Button(.4*width, 0.75*height);
  loadoutButton = new Button(.6*width, 0.75*height);
  talkTest = new Button(400, height/4);
  gunshop = new Loadout();
  battleMenu = new BattleMenu();
  attackMenu = new BattleMenu();
  battleGrid = new BattleGrid(zone, int(random(5)), int(random(5)));
  playerCharacter = new PlayerCharacter(100); //initialize player character (hit-points)
  dialog0 = new Dialog(0);
  goon = new Enemy(10, 10, 10);
} //end initializeObjects

void initializeImages() {
  walkingCharacter1 = loadImage("sprite1-1.png");
  walkingCharacter2 = loadImage("sprite1-2.png");
  walkingCharacter3 = loadImage("sprite1-5.png");
  coveringCharacter = loadImage("sprite1-3.png");
  firingCharacter = loadImage("sprite1-4.png");
  imageAssets[4] = loadImage("ctu-icon.PNG");
  imageAssets[5] = loadImage("robit.png");
} //end initializeImages
