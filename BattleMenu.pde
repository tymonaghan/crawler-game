class BattleMenu {
  color bgColor, textColor;
  int xPos, yPos, cursorX, cursorY, ticker, cursorLocation, tier, rows, menuLevel, items, accuracy;
  float menuX, menuY, menuWidth, menuHeight;
  boolean alert;

  BattleMenu() {
    //RIP implementation of zones to determine colors. maybe in another spot. 
    //bgColor = getBgColor(zone);
    //textColor = getTextColor(zone);
    menuX = 0.1 * width;
    menuY = 0.7 * height;
    menuWidth = 0.4 * width;
    menuHeight = 0.2 * height;
    cursorX = 0;
    cursorY = 0;
    cursorLocation=0;
    ticker = 0;
    menuLevel = 0;
    accuracy = -100;      //change this to a variable based on playerCharacter level at some point
  } // end battlemenu constructor
  
  int getTicker(){
    return ticker;
  } 
  
  void setTicker(int ticksetter_){
    ticker = ticksetter_;
  } //end setTicker

  void resetMenuLevel() { //call this at the beginning of each battle to reset menuLevel
    menuLevel= 0;
  }

  void incMenuLevel() { //call this to change the menuLevel
    menuLevel++;
  }

  int getMenuLevel() {
    return menuLevel;
  } 

  void display(boolean playersTurn_) {
    
    bgColor = colorScheme[3];
    textColor = colorScheme[4];
    textFont(battleMenuFont);
    stroke(textColor);
    fill(bgColor);
    strokeWeight(5);
    rectMode(CORNER);
    rect(menuX, menuY, menuWidth, menuHeight);
    fill(textColor);
    textAlign(LEFT, CENTER);

    text("Attack", menuX+30, menuY+20);
    text("Support", menuX+30, menuY+50);
    text("Cover", menuX + 30, menuY + 80);

    text("Advance", menuX + 200, menuY + 20);
    text("Flank", menuX + 200, menuY + 50);
    text("Retreat", menuX +200, menuY + 80);
    //this.drawCursor();
    ticker++;
  } // end display

  int drawCursor() { //draw cursor and respond with where it's pointing -- this is pretty hardcoded to the battleMenu right now - might be better to make a separate cursor for subMenus
    //cursorX = 0;
    //cursorY = 0;
    if (keyPressed == true && key == CODED && ticker > 10) {
      if (keyCode == UP) {
        if (cursorY <= 0) {
          cursorY = 3;
        } 
        cursorY--;
        ticker = 0;
      } else if (keyCode == DOWN) {
        if (cursorY >= 2) {
          cursorY=-1;
        }
        cursorY++;
        ticker = 0;
      } else if (keyCode == RIGHT || keyCode == LEFT) {
        if (cursorX == 0) {
          cursorX++;
          ticker = 0;
        } else {
          cursorX=0;
          ticker = 0;
        }
      } // end left/right
    } //end if keypressed & coded
    if (battleMenu.getMenuLevel() == 0 ) {

      noStroke();
      fill(colorScheme[4]);
      triangle(menuX+25+cursorX*170, menuY+20+(cursorY*30), menuX+20+cursorX*170, menuY+25+(cursorY*30), menuX+20+cursorX*170, menuY+15+(cursorY*30));
      return cursorY * 2 + cursorX; // 0 attack, 1 advance, 2 support, 3 flank, 4 cover, 5 retreat
    } else {// end if menuLevel ==0
      return 0;
    }  //end else that returns 0 as fallback
  } // end draw cursor

  int interact() {
    cursorLocation = this.drawCursor();
    if (keyPressed == true && key == ' ' && ticker >10) {
      battleMenu.incMenuLevel();
      ticker = 0;
    } // end if space is pressed
    return cursorLocation;
  } // end interact

  void displaySubMenu(int tier_, int items_, boolean alert_) {
    tier = tier_;
    rows = int(items_/3)+1;
    alert = alert_;
    items = items_;
    bgColor = colorScheme[3];
    textColor = colorScheme[4];
    if (alert) { //if the action is "alert" it will make a red box around the rect
      textColor = colorScheme[2];
    } // end if alert 
    stroke(textColor);
    fill(bgColor);
    strokeWeight(5);
    rectMode(CORNER);
    rect(menuX + tier*75, menuY + tier*15, menuWidth/rows, menuHeight);
    fill(textColor);
    textAlign(LEFT, CENTER);
    text("Fire pistol (l. ammo)", menuX+tier*75+30, menuY + tier*15 +20);
    ticker++;
    if (battleMenu.getMenuLevel() == 1) {
      attackMenu.drawSubCursor(items, tier);
    } // end if menuLevel
  } //end displaySubMenu

  int drawSubCursor(int itemsCount_, int tier_) {
    items = itemsCount_;
    tier = tier_;
    cursorX = 0;
    cursorY = 0;
    int xOffset = tier*75;
    int yOffset = tier *15;
    if (battleMenu.getMenuLevel() == this.tier) {
      noStroke();
      fill(colorScheme[4]);
      triangle(menuX+xOffset+30, menuY + yOffset + 20, menuX+xOffset+25, menuY + yOffset+ 25, menuX+xOffset+25, menuY + yOffset + 15);
      if (items >4) { //if more than 4 items, need left-right support
        //add left-right support here
      } // end if less than 4 items
    } // end if battlemenu is current tier (to select active window and display cursor therein
    if (keyPressed == true && key == ' ' && ticker >10) {
      battleMenu.incMenuLevel();
      ticker = 0;
    } //end if spacebar is pressed
    ticker ++;
    return 0;
  } //end drawSubCursor

  int confirmAttack(int weaponID_) {
    String weaponID = weaponList.get(10);
    tier =4;
    fill(colorScheme[3]);
    stroke(colorScheme[4]); 
    if (playerCharacter.hitPoints <25) {
      stroke(colorScheme[2]);
    } //end if
    strokeWeight(5);
    rectMode(CORNER);
    rect(menuX + tier*75, menuY + tier*15, 200, menuHeight-20);
    int dmg = weaponDamage.get(weaponID);
    fill(colorScheme[4]);
    textAlign(LEFT, TOP);
    pushStyle();
    textSize(14);
    text("attack with "+weaponID+"\ndamage: "+dmg+"\npotential dmg: "+(dmg-2)+" - "+(dmg+1)+"\nclick mouse to attack\npress space to cancel", menuX+ tier*75+5, menuY + tier*15+5); 
    popStyle();
    if (keyPressed == true && ticker >10) {
      ticker = 0;
      battleMenu.resetMenuLevel();
      return 0;
    } else if (mousePressed == true && ticker > 10) {
      ticker = 0;
      battleMenu.incMenuLevel();
      return dmg;
    } // end if mouse pressed do aiming minigame
    ticker++;
    return 0;
  } // end confirmAttack

  void aimGame(int dmg_) {
    stroke(colorScheme[2]);
    fill(abs(accuracy*2.5), -abs(accuracy*2), 70, 150);
    strokeWeight(3);
    ellipseMode(CENTER);
    ellipse(.45*width, battleGrid.getGridRowCenter(1), accuracy*2.5, accuracy*2.5); //initial size of circle, may want to play with multipliers for acc'y based on skill or enemy or cover
    if ((mousePressed == true && ticker > 10) || (accuracy > 99)) {  //complete attack if mousepressed OR accuracy-meter runs out.
      //playerCharacter.setStatus(1);
      //playerCharacter.setAccuracy(accuracy);
      battleMenu.incMenuLevel();
      //playerCharacter.doAttack(accuracy);
      //battleMenu.resetMenuLevel();
      ticker = 0;
      return;
    } else {
      accuracy+=3;
    } //end if triggers for completing the attack
  } //end aimGame
} //end BattleMenu class
