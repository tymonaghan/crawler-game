class BattleMenu {
  color bgColor, textColor;
  int xPos, yPos, xLoc, yLoc, xL, yL, cursorX, cursorY, ticker, cursorLocation, tier, rows, menuLevel, items, accuracy, activeMenu;
  float menuX, menuY, menuWidth, menuHeight;
  boolean alert;

  BattleMenu() {
    //RIP implementation of zones to determine colors. maybe in another spot. 
    //bgColor = getBgColor(zone);
    //textColor = getTextColor(zone);
    menuX = .1*width;
    menuY = .7*height;
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
  } // end battlemenu constructor

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

  void displayBattleMenu() {
    tier = getActiveMenu();
    bgColor = colorScheme[3]; //static colors
    textColor = colorScheme[4];
    String menuItems[][] = new String[2][3];
    arrayCopy(menuArrays.get(tier), menuItems);

    textFont(battleMenuFont);
    stroke(textColor);
    fill(bgColor);
    strokeWeight(5);
    rectMode(CORNER);
    for (int i = 0; i <tier+1; i++) {
      rect(xCoordinate[i*2]-25, yCoordinate[i*3]-15, menuWidth, menuHeight); //draw the menu according to its tier
    } //end for loop to draw under-boxes

    fill(textColor);
    textMode(CORNER);
    textAlign(LEFT, TOP);  
    for (int x = 0; x <2; x++) { // for x0 and x1
      for (int y = 0; y<3; y++) { //for y0, y1, and y2
        text(menuItems[x][y], xCoordinate[x+2*tier], yCoordinate[y+3*tier]); //take texts from 2d array to populate menu, place according to xcoordinate and ycoordinate arrays!
      }//end for loop-y
    } // end for loop -x

    int selection = battleMenuCursor(tier);
    if (keyPressed == true && key == ' ' && ticker >10) {
      if (tier==0) {
        setActiveMenu(1);  //if you're on level 0, just go to level 1
        resetCursor();
      } else { //but if you're already on level 1
        //go to attack or support or whatever confirm

        confirmDialog(getActiveMenu(), selection);
      }
    } // end if keyPressed
    ticker++;
  } // end display

  int battleMenuCursor(int tier_) {
    tier = tier_;
    xLoc = getxLoc();
    yLoc = getyLoc();
    ticker = getTicker();
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
        resetTicker();
      }
    }
    drawTriangleCursor(xCoordinate[xLoc+2*tier], yCoordinate[yLoc+3*tier], tier);
    return xLoc*3+yLoc;
  }


  void confirmDialog(int activeMenu_, int selection_) { 
    //this whole block is just to read back the name of whatever i picked with the cursor
    String menuItemsX[][] = new String[2][3];
    arrayCopy(menuArrays.get(activeMenu_), menuItemsX);
    if (selection_ <3) {
      xL =0;
    } else {
      xL = 1;
    }
    if (selection_ ==0 || selection_ ==3) {
      yL =0;
    } else if (selection_ ==1 || selection_ ==4) {
      yL = 1;
    } else if (selection_ ==2 || selection_ == 6) {
      yL = 2;
    }
    String actionToConfirm = menuItemsX[xL][yL];

    String weaponID = weaponList.get(10); //need to compare action chosen -- this is becoming a mess, weapons probably need to be their own classes
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


    println(actionToConfirm);
  }// end confirmDialog


  void drawTriangleCursor(float xpos_, float ypos_, int tier_) { //feed this menuX, menuY, and menuTier
    int x = int(xpos_);
    int tier = tier_;
    int y = int(ypos_);
    noStroke();
    fill(colorScheme[4]);
    triangle(x-5, y+10, x-10, y+15, x-10, y+5);
  } //end draw triangle cursor
} //end BattleMenu Class
