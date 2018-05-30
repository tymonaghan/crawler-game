void setupFunctions(){
  //frameRate(50);
  //init color scheme
  colorScheme[0] = color(0,0);
  colorScheme[1] = color(227,208,0); //burnt yellow
  colorScheme[2] = color(227,64,0); //red
  colorScheme[3] = color(70,70,70); //dark gray  
  colorScheme[4] = color(235); //white(ish)
  
  playButton = new Button(width/2,height/2);
  loadoutButton = new Button(150,height/2);
  battleMenu = new BattleMenu(zone);
  battleGrid = new BattleGrid(zone,int(random(5)),int(random(5)));
  playerCharacter = new PlayerCharacter();
  
  walkingCharacter1 = loadImage("sprite1-1.png");
  walkingCharacter2 = loadImage("sprite1-2.png");
  coveringCharacter = loadImage("sprite1-3.png");
  firingCharacter = loadImage("sprite1-4.png");
  
  battleMenuFont = createFont("c:/WINDOWS/FONTS/OCRAEXT.TTF",18);
  menuFont = createFont("c:/WINDOWS/FONTS/BOOKOS.TTF",22);
  
  intDict = new IntDict();
  intDict.set("attack",0);
  intDict.set("support",1);
  intDict.set("cover",2);
  intDict.set("move",3);
}

color getBgColor(int zone) {
  if (zone == 0){
    return colorScheme[3];
  } else {
    return colorScheme[2];
  }
} //end get bg color

color getTextColor(int zone) {
  if (zone == 0) {
    return colorScheme[4];
  } else {
    return colorScheme[1];
  }
} // end get text color
