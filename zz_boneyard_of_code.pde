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
  
  
