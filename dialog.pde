class Dialog {
  int scriptNum;
  int participants;
  int counter;
  int doubleClickBuffer;
  float textLocation;

  Dialog(int num_) {
    scriptNum = num_;
    counter = 0;
    doubleClickBuffer = 0;
  } // end constructor, feed this the scriptnumber

  void playScene() {
    String[] script1 = loadStrings("script1.txt"); //load text file into string array, note this text file is hardwired in right now
    background(0);
    stroke(250);
    fill(60);
    rectMode (CORNER);
    strokeWeight(5);
    //two boxes for each conversant's face
    rect(.1*width, .6*height, .3*width, .3*height);
    rect(.6*width, .6*height, .3*width, .3*height);
    
    //check who speaks the line by matching
    String[][] playerChecker = matchAll(script1[counter], "Player:"); //check each line of the text for Player:
    if (playerChecker == null) { // if the line isn't spoken by the player, it appears on the right
      textLocation = .5*width;
    } else { //lines spoken by the player are on the left.
      textLocation = .15* width;
    } //end else
    
    //write the lines of text on-screen
    textMode(CENTER);
    text(script1[counter], textLocation, .25*height, .35*width, .2*height);
    if (mousePressed == true && counter < script1.length-1 && doubleClickBuffer >10) {
      counter++;
      doubleClickBuffer = 0;
    } else if (mousePressed == true && counter >= script1.length-1 && doubleClickBuffer > 10) {
      gameState = 3;
    } // end if mousePressed loop
    doubleClickBuffer++;
  } //end playscene
} //end dialog class
