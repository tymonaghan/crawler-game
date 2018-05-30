class BattleMenu {
  color bgColor, textColor;
  int xPos, yPos;
  float menuX, menuY, menuWidth, menuHeight;

  BattleMenu(int zone) {
    bgColor = getBgColor(zone);
    textColor = getTextColor(zone);
    menuX = 0.1 * width;
    menuY = 0.7 * height;
    menuWidth = 0.4 * width;
    menuHeight = 0.2 * height;
  } // end battlemenu constructor

  void display() {
    textFont(battleMenuFont);
    stroke(textColor);
    fill(bgColor);
    strokeWeight(5);
    rectMode(CORNER);
    rect(menuX, menuY, menuWidth, menuHeight);
    fill(textColor);
    textAlign(LEFT, TOP);
    
    text("Attack", menuX+30, menuY+20);
    text("Support", menuX+30, menuY+50);
    text("Cover", menuX + 30, menuY + 80);
    
    text("Advance", menuX + 200, menuY + 20);
    text("Flank", menuX + 200, menuY + 50);
    text("Retreat", menuX +200, menuY + 80);
  } // end display

  void panel(int panelType) {
    if (panelType == 0) {
    } else if (panelType == 1) {
    }// end panelType
  }
  int interact() {
    return 0;
  }
} // end battlemenu
