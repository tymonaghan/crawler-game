class BattleMenu {
  color bgColor, textColor;
  int xPos, yPos, cursorX, cursorY, ticker, cursorLocation;
  float menuX, menuY, menuWidth, menuHeight;

  BattleMenu(int zone) {
    bgColor = getBgColor(zone);
    textColor = getTextColor(zone);
    menuX = 0.1 * width;
    menuY = 0.7 * height;
    menuWidth = 0.4 * width;
    menuHeight = 0.2 * height;
    cursorX = 0;
    cursorY = 0;
    cursorLocation=0;
    ticker = 0;
  } // end battlemenu constructor

  void display() {
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
    ticker++;
  } // end display


  int drawCursor() { //draw cursor and respond with where it's pointing 
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
   
    noStroke();
    fill(colorScheme[4]);
    triangle(menuX+25+cursorX*170, menuY+20+(cursorY*30), menuX+20+cursorX*170, menuY+25+(cursorY*30), menuX+20+cursorX*170, menuY+15+(cursorY*30));
    return cursorY * 2 + cursorX; // 0 attack, 1 advance, 2 support, 3 flank, 4 cover, 5 retreat
  } // end draw cursor

  int interact() {
    cursorLocation = this.drawCursor();
    if (keyPressed == true && key == ' ') {
      playerCharacter.playerAction(cursorLocation);
      ticker = 0;
    } // end if space is pressed
    return cursorLocation;
  } // end interact
  
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
} // end battlemenu
