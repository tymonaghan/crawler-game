class Button {
  color bgColor, textColor;
  float xPos, yPos;
  int buttonWidth, buttonHeight, stringNumber, buttonFunction;
  String buttonText;


  Button(float x_, float y_) { // button constructor (xposition, yposition)
    xPos = x_;
    yPos = y_;
  } // end button constructor

  void display(int bw_, int bh_, color bc_, color tc_, String tx_) { // display (buttonWidth, buttonHeight, backgroundColor, textColor, textString)

    strokeWeight(2);
    buttonWidth = bw_;
    buttonHeight = bh_;
    bgColor = colorScheme[bc_];
    textColor = colorScheme[tc_];
    String buttonText = tx_;
    rectMode(CENTER);
    fill(bgColor);
    rect(xPos, yPos, buttonWidth, buttonHeight);
    fill(textColor);
    textAlign(CENTER, CENTER);
    textFont(menuFont);
    text(buttonText, xPos, yPos);
  }

  void quickDisplay(String tx_) { //quickly display one single button for debugging
    String buttonText = tx_;
    buttonWidth = 50;
    buttonHeight = 50;
    xPos = width-100;
    yPos = 100;
    rectMode(CENTER);
    fill(colorScheme[0]);
    rect(xPos, yPos, buttonWidth, buttonHeight);
    fill(colorScheme[4]);
    textAlign(CENTER, CENTER);
    textFont(menuFont);
    text(buttonText, xPos, yPos);
  } // end quick display


  void clickCheck(int mX_, int mY_, int bfunct) { //clickcheck, pass mouseX, mouseY, and buttonFunction
    mX = mX_;
    mY = mY_;
    buttonFunction = bfunct;
    if (mousePressed == true) {
      if (mX > xPos-buttonWidth/2 && mouseX < xPos + buttonWidth/2 && mouseY <yPos+buttonHeight/2 && mouseY > yPos-buttonHeight/2) {
        gameState = buttonFunction;
        globalTicker=0;
      } //end if for checking if mouse cursor is inside button
    } //end if for checking if mousePressed
  } //end clickCheck function

  void clickCheckTwo(int variable) { //second clickcheck used for debugging
    if (mousePressed == true) {
      if (mouseX > xPos-buttonWidth/2 && mouseX < xPos + buttonWidth/2 && mouseY <yPos+buttonHeight/2 && mouseY > yPos-buttonHeight/2) {
        playerCharacter.hurtPlayer(variable);
      }
    } // end simple clickcheck
  }//end button class
}
