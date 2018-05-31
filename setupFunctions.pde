void setupFunctions() {
  initializeListsAndArrays();
  initializeObjects();
  initializeImages();
  frameRate(25);
  

  battleMenuFont = createFont("c:/WINDOWS/FONTS/OCRAEXT.TTF", 18);
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
  loadout.set("knife", 0);
  loadout.set("pistol", 1);
  loadout.set("carbine", 2);
  loadout.set("heavy", 3);
  loadout.set("flash-grenade", 4);
  loadout.set("frag-grenade", 5);
  loadout.set("light-ammo", 6);
  loadout.set("heavy-ammo", 7);

  itemNotes = new StringList();
  itemNotes.set(0, "unlimited use");
  itemNotes.set(1, "uses light ammo");
  itemNotes.set(2, "uses light ammo");
  itemNotes.set(3, "uses heavy ammo");
  itemNotes.set(4, "stuns enemies");
  itemNotes.set(5, "does area damage");
  itemNotes.set(6, "for handgun and carbine");
  itemNotes.set(7, "for heavy weapon");

  itemPrices = new IntList();
  itemPrices.set(0, 0);
  itemPrices.set(1, 40);
  itemPrices.set(2, 70);
  itemPrices.set(3, 140);
  itemPrices.set(4, 40);
  itemPrices.set(5, 50);
  itemPrices.set(6, 10);
  itemPrices.set(7, 35);

  for (int i = 0; i < playerInventory.length; i++) {
    inventoryIcons[i] = loadImage("inv-icon"+i+".png");
  } //end for loop to initialize inventory images

  int whilst = 0;
  while (whilst < 4) {
    imageAssets[whilst] = loadImage("armed"+whilst+".png");
    whilst++;
  }

  //init color scheme
  colorScheme[0] = color(0, 0);
  colorScheme[1] = color(227, 208, 0); //burnt yellow
  colorScheme[2] = color(227, 64, 0); //red
  colorScheme[3] = color(70, 70, 70); //dark gray  
  colorScheme[4] = color(235); //white(ish)

  //init playerInventory array
  for (int i = 0; i < playerInventory.length; i++) {
    playerInventory[i] = 0;
  } // end for-loop initializing playerInventory
} //end initializeListsAndArrays



void initializeObjects() {
  playButton = new Button(.4*width, 0.75*height);
  loadoutButton = new Button(.6*width, 0.75*height);
  talkTest = new Button(400, height/4);
  gunshop = new Loadout();
  battleMenu = new BattleMenu(zone);
  battleGrid = new BattleGrid(zone, int(random(5)), int(random(5)));
  playerCharacter = new PlayerCharacter(100); //initialize player character (hit-points)
  dialog0 = new Dialog(0);
} //end initializeObjects

void initializeImages(){
  walkingCharacter1 = loadImage("sprite1-1.png");
  walkingCharacter2 = loadImage("sprite1-2.png");
  walkingCharacter3 = loadImage("sprite1-5.png");
  coveringCharacter = loadImage("sprite1-3.png");
  firingCharacter = loadImage("sprite1-4.png");
  imageAssets[4] = loadImage("ctu-icon.PNG");
} //end initializeImages
