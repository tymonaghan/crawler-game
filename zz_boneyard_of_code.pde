/* i pulled this out of the battlemenu class. I had it as it's own function in that class. I'm going to try re-implementing it as a NEW battlemenu itself.
 void attackMenu() {
 
 textFont(battleMenuFont);
 stroke(textColor);
 fill(bgColor);
 strokeWeight(5);
 rectMode(CORNER);
 rect(menuX+20, menuY+20, menuWidth, menuHeight);
 fill(textColor);
 textMode(CORNER);
 textAlign(LEFT, TOP);
 text("Knife",menuX+40,menuY+30);
 noLoop();
 }
 // end attackMenu */

void crawlerText(int i) {
  textAlign(LEFT, BOTTOM);
  textFont(menuFont);
  fill(0, 227, 24, 85);
  text("Tyler's RPG game concept - work in progress", width-((i % width)%900), height-1);
} //end crawkerText()

void credits(){
  /*
  opening photo credit https://www.flickr.com/photos/giuseppemilo/
*/
}



/*



  

  void displayMainBattleMenu() {
    bgColor = colorScheme[3];
    textColor = colorScheme[4];
    textFont(battleMenuFont);
    stroke(textColor);
    fill(bgColor);
    strokeWeight(5);
    rectMode(CORNER);
    rect(menuX, menuY, menuWidth, menuHeight);
    fill(textColor);
    textMode(CORNER);
    textAlign(LEFT, CENTER);  
    for (int x = 0; x <2; x++) {
      for (int y = 0; y<3; y++) {
        text(mainBattleMenu[x][y], xCoordinate[x], yCoordinate[y]);
      }//end for loop-y
    } // end for loop -x
    ticker++;
  } // end display

  int drawCursor() { //draw cursor and respond with where it's pointing -- this is pretty hardcoded to the battleMenu right now - might be better to make a separate cursor for subMenus
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
      //drawTriangleCursor(menuX,menuY,0);
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

    if (battleMenu.getMenuLevel() == this.tier) {
      drawTriangleCursor(menuX, menuY, tier);

      //add left-right support here
      //} // end if less than 4 items
    } // end if battlemenu is current tier (to select active window and display cursor therein
    if (keyPressed == true && key == ' ' && ticker >10) {
      battleMenu.incMenuLevel();
      ticker = 0;
    } //end if spacebar is pressed
    ticker ++;
    return 0;
  } //end drawSubCursor

  int confirmAttack(int weaponID_) { //dialog to preview, then confirm or cancel attack
    String weaponID = weaponList.get(10);
    tier = 4;
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
    int accy = playerCharacter.getAccuracy();
    fill(abs(accy*2.5), -abs(accy*2), 70, 150);
    strokeWeight(3);
    ellipseMode(CENTER);
    ellipse(.45*width, battleGrid.getGridRowCenter(1), accy*2.5, accy*2.5); //initial size of circle, may want to play with multipliers for acc'y based on skill or enemy or cover
    if ((mousePressed == true && ticker > 10) || (accy > 99)) {  //complete attack if mousepressed OR accuracy-meter runs out.
      battleMenu.incMenuLevel();
      ticker = 0;
      return;
    } else {
      playerCharacter.changeAccuracy(3);
    } //end if triggers for completing the attack
  } //end aimGame

  void drawTriangleCursor(float xpos_, float ypos_, int tier_) { //feed this menuX, menuY, and menuTier
    int x = int(xpos_);
    int tier = tier_;
    int y = int(ypos_);
    int xOffset = int(tier*75);
    int yOffset = int(tier *15);
    noStroke();
    fill(colorScheme[4]);
    triangle(x+xOffset+30, y + yOffset + 20, x+xOffset+25, y + yOffset+ 25, x+xOffset+25, y + yOffset + 15);
  } //end draw triangle cursor
} //end BattleMenu class

*/
