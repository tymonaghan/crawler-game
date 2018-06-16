class BattleMenu {
  color bgColor, textColor;
  int xPos, yPos, xLoc, yLoc, xL, yL, cursorX, cursorY, ticker, cursorLocation, tier, rows, menuLevel, items, accuracy, activeMenu, menuID;
  float menuX, menuY, menuWidth, menuHeight;
  boolean alert;
  String menuItems[][] = new String[2][3];


  BattleMenu(int menuID_, int tier_) {
    menuID = menuID_;
    tier = tier_;
    arrayCopy(menuArrays.get(menuID), menuItems); // this fills the menuItems array with the proper menu Items
    menuX = .1*width + tier*15;
    menuY = .7*height + tier*15;
    menuWidth = int(0.4 * width);
    menuHeight = int(0.2 * height);
    cursorX = 0;
    cursorY = 0;
    cursorLocation=0;
    ticker = 0;
    menuLevel = 0;
    xLoc = 0;
    yLoc = 0;
    xL=0;
    yL=0;
    activeMenu = 0;
    //accuracy = -100;      //change this to a variable based on playerCharacter level at some point
    //RIP implementation of zones to determine colors. maybe in another spot. 
    //bgColor = getBgColor(zone);
    //textColor = getTextColor(zone);
  } // end battlemenu constructor

  BattleMenu() { //this constructor is used for confirming actions
    menuX = .3*width;
    menuY = .75 * height;
    menuWidth = int (0.3*width);
    menuHeight = int(0.2*height);
  } //end confirm menu constructor

  void displayBattleMenu(int menuID_) {
    menuID = menuID_;
    bgColor = colorScheme[3]; //static colors
    textColor = colorScheme[4];
    textFont(battleMenuFont);
    stroke(textColor);
    fill(bgColor);
    strokeWeight(5);
    rectMode(CORNER);
    rect(menuX, menuY, menuWidth, menuHeight);
    fill(textColor);
    rectMode(CORNER);
    textAlign(LEFT, TOP);  
    for (int x = 0; x <2; x++) { // for x0 and x1
      for (int y = 0; y<3; y++) { //for y0, y1, and y2
        text(this.menuItems[x][y], xCoordinate[x+2*tier], yCoordinate[y+3*tier]); //take texts from 2d array to populate menu, place according to xcoordinate and ycoordinate arrays! (menuItems array is now declared in the battlemenu constructor)
      }//end for loop-y
    } // end for loop -x
  } // end display

  void clickCheck() {
    ticker = mainBattleMenu.getTicker();
    int selectionNumber = battleMenuCursor(tier);
    println(menuItems[this.xLoc][this.yLoc]);
    println("menu ID: "+mainBattleMenu.getActiveMenu());
    println("combatstate: "+combatState);

    if (mousePressed == true) {
      mainBattleMenu.setActiveMenu(0);
      combatState = 0;
      mainBattleMenu.resetTicker();
    } //end if mouse clicked... mouse cancels actions.

    if (keyPressed == true && key == ' ' && ticker >10) {
      if (tier == 0) {
        mainBattleMenu.setActiveMenu(selectionNumber*10);
        combatState =1;
        mainBattleMenu.resetTicker();
      } else if (tier == 1) {
        playerCharacter.setActiveWeaponSlot(selectionNumber-1); 
        mainBattleMenu.setActiveMenu(mainBattleMenu.getActiveMenu() + selectionNumber);
        combatState = 3;
        mainBattleMenu.resetTicker();
      }
      resetCursor();
    } //end if spacebar is pressed

    //} // end if menuID is less than 10
    // } else {
    //if (keyPressed == true && key == ' ' && ticker >10) {
    //  mainBattleMenu.setActiveMenu(99);
    //   combatState = 4;
    //   playerCharacter.doAttack(56);
    //   }
    mainBattleMenu.ticker++;
  } // end clickCheck


  int battleMenuCursor(int tier_) {
    tier = tier_;
    xLoc = getxLoc();
    yLoc = getyLoc();
    ticker = mainBattleMenu.getTicker();
    if (keyPressed == true&&ticker>5) {
      if (key == CODED) {
        if (keyCode == DOWN) {
          if (yLoc<2) {
            yLoc++;
          } else {
            yLoc=0;
          } //end else
        } // end if DOWN pressed
        else if (keyCode == UP) {
          if (yLoc==0) {
            yLoc=2;
          } else {
            yLoc--;
          } //end else
        } // end if DOWN pressed
        else if (keyCode == LEFT || keyCode == RIGHT) {
          if (xLoc ==1) {
            xLoc = 0;
          } else {
            xLoc=1;
          }// end else
        } // end if left or right key pressed
        delay(100);
        mainBattleMenu.resetTicker();
      }
    }
    drawTriangleCursor(xCoordinate[xLoc+2*tier], yCoordinate[yLoc+3*tier], tier);
    return (xLoc*3+yLoc)+1;
  }

  void displayConfirmDialog(int weaponID_, int enemyHP_) { //THIS is the CONFIRM dialog
    bgColor = colorScheme[3]; //static colors
    textColor = colorScheme[4];
    int weaponID = weaponID_;
    String weaponName = weaponList.get(weaponID); //
    int dmg = weaponDamage.get(weaponName);
    fill(colorScheme[3]);
    stroke(colorScheme[4]); 
    if (playerCharacter.hitPoints <25) {
      stroke(colorScheme[2]);
    } //end if
    strokeWeight(5);
    rectMode(CORNER);
    rect(menuX, menuY, menuWidth, menuHeight);
    fill(colorScheme[4]);
    textAlign(LEFT, TOP);
    pushStyle();
    textSize(14);
    text("attack with "+weaponName+"\ndamage: "+dmg+"\npotential dmg: "+(dmg-2)+" - "+(dmg+1)+"\npress space to attack\nclick mouse to cancel", menuX+ tier*75+5, menuY + tier*15+5); 
    popStyle();
    println();
    confirmationDialogListener();
  } // end display

  void confirmationDialogListener() {
    ticker = mainBattleMenu.getTicker();
    if (mousePressed == true) {
      mainBattleMenu.setActiveMenu(0);
      combatState = 0;
      mainBattleMenu.resetTicker();
    } //end if mouse clicked... mouse cancels actions.

    if (keyPressed == true && key == ' ' && ticker >10) {
      mainBattleMenu.resetTicker();
      combatState = 4;
      return;
    }
    mainBattleMenu.ticker++;
  } //end confirmationDialogListener

  void aimGame() {
    ticker = mainBattleMenu.getTicker();
    stroke(colorScheme[2]);
    int accy = playerCharacter.getAccuracy();
    fill(abs(accy*2.5), -abs(accy*2), 70, 150);
    strokeWeight(3);
    ellipseMode(CENTER);
    ellipse(.45*width, battleGrid.getGridRowCenter(1), accy*2.5, accy*2.5); //initial size of circle, may want to play with multipliers for acc'y based on skill or enemy or cover
    if ((keyPressed == true && key == ' ' && ticker > 10) || (accy > 99)) {  //complete attack if mousepressed OR accuracy-meter runs out.
      //battleMenu.incMenuLevel();
      //playerCharacter.doAttack(); //change this hardcoded 5 to dmg value
      ticker = 0;
      combatState = 5;
      //return;
    } else {
      playerCharacter.changeAccuracy(3);
    } //end if triggers for completing the attack
    
    mainBattleMenu.ticker++;
  } //end aimGame

  void drawTriangleCursor(float xpos_, float ypos_, int tier_) { //feed this menuX, menuY, and menuTier
    int x = int(xpos_);
    int y = int(ypos_);
    noStroke();
    fill(colorScheme[4]);
    triangle(x-5, y+10, x-10, y+15, x-10, y+5);
  } //end draw triangle cursor


  
  int getTicker() {
    return ticker;
  }  //end getTicker

  void resetTicker() {
    ticker = 0;
  } //end setTicker

  void resetMenuLevel() { //call this at the beginning of each battle and after each action to reset menuLevel
    menuLevel = 0;
    yLoc=0;
    xLoc = 0;
  }

  void incMenuLevel() { //call this to change the menuLevel
    menuLevel++;
    yLoc=0;
    xLoc = 0;
  }

  int getMenuLevel() {
    return menuLevel;
  } 

  int getxLoc() {
    return xLoc;
  }

  void incxLoc() {
    xLoc++;
  }

  void resetxLoc() {
    xLoc=0;
  }

  int getyLoc() {
    return yLoc;
  }

  void incyLoc() {
    yLoc++;
  }

  void resetyLoc() {
    yLoc=0;
  }

  void resetCursor() {
    xLoc=0;
    yLoc=0;
  } //end resetCursor

  int getActiveMenu() {
    return activeMenu;
  } 

  void setActiveMenu(int set_) {
    activeMenu = set_;
  }
} //end BattleMenu Class
