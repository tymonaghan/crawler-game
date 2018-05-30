class Button {
  color bgColor, textColor;
  int xPos, yPos, buttonWidth, buttonHeight, stringNumber, buttonFunction;
  String buttonText;


  Button(int x_, int y_) { // button constructor:
    xPos = x_;
    yPos = y_;
  } // end button constructor

  void display(int bw_, int bh_, color bc_, color tc_, String tx_) {

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

  void clickCheck(int mX_, int mY_, int bfunct) { //clickcheck, pass mouseX, mouseY, and buttonFunction
    mX = mX_;
    mY = mY_;
    buttonFunction = bfunct;
    if (mousePressed == true) {
      if (mX > xPos-buttonWidth/2 && mouseX < xPos + buttonWidth/2 && mouseY <yPos+buttonHeight/2 && mouseY > yPos-buttonHeight/2) {
        gameState = buttonFunction;
      } //end if for checking if mouse cursor is inside button
    } //end if for checking if mousePressed
  } //end clickCheck function
}//end button class
