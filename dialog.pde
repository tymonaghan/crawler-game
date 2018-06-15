class Dialog {
  int scriptNum, participants, counter, doubleClickBuffer;

  Dialog() {
    scriptNum = 0;
    counter = 0;
    doubleClickBuffer = 0;
  } // end constructor, feed this the scriptnumber

  void incScriptNumber() {
    scriptNum++;
  } //end incScriptNumber

  int getScriptNumber() {
    return scriptNum;
  } //end getScriptNumber

  void resetCounter() {
    counter = 0;
  } //end resetCounter

  void playCutscene() { //this would be more fun if it scrolled up like StarWars style!
    int script =getScriptNumber();
    String[] cutsceneStrings = loadStrings("script"+script+".txt");
    imageMode(CENTER);
    image(imageAssets[6], width/2, height/2, width, height);
    stroke(colorScheme[4]);
    fill(0, 100);
    rectMode(CORNER);
    rect(.2*width, .2*height, .6*width, .6*height);
    fill(colorScheme[4]);
    rectMode(CORNER);

    for (int i = 0; i < cutsceneStrings.length; i++) { //show the scrolling text. using map() or bound() might be necessary here.
      if (counter <150) {
        text(cutsceneStrings[0], .2*width, (.8*height)-counter*3, .55*width, counter*3);
      } else {
        text(cutsceneStrings[i], .2*width, .2*height+100*i, .55*width, .55*height);
      } //end else to hold text where it is
    } //end for loop to get each line of cutsceneStrings

    //if (mousePressed == true && counter < cutsceneStrings.length-1 && doubleClickBuffer >10) { //if player clicks, advance the conversation to the next line(counter++)
    counter++;
    //  doubleClickBuffer = 0;
    if (mousePressed == true && counter >= cutsceneStrings.length-1 && doubleClickBuffer > 10) { //if the conversation is over, return to state 3 (travel)
      resetCounter();
      incScriptNumber();
      doubleClickBuffer = 0;

      gameState = 4;
    } // end if mousePressed loop
    doubleClickBuffer++;
  } // end playCutscene

  void playConversation() {
    int script = getScriptNumber(); 
    String[] scriptStrings = loadStrings("script"+script+".txt"); //load text file into string array
    background(0);
    stroke(colorScheme[6]);
    fill(60);
    rectMode (CORNER);
    strokeWeight(5);
    //two boxes for each conversant's face
    String[][] playerChecker = matchAll(scriptStrings[counter], "Player:"); //check each line of the text for Player:

    if (playerChecker !=null) { //color the boxes according to who is speaking
      stroke(colorScheme[1]);
    } //end if 
    rect(.1*width, .6*height, .3*width, .3*height); //left hand player picture box
    stroke(colorScheme[4]);
    if (playerChecker == null) { // if the line isn't spoken by the player, it appears on the right
      stroke(colorScheme[1]);
    } //end if 
    rect(.6*width, .6*height, .3*width, .3*height);
    stroke(colorScheme[4]);
    //check who speaks the line by matching
    rectMode(CENTER); //center dialog box
    rect(.5*width, .25*height, .6*width, .3*height);

    //write the lines of text on-screen
    fill(colorScheme[4]);

    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    text(scriptStrings[counter], .5*width, .25*height, .55*width, .25*height);
    if (mousePressed == true && counter < scriptStrings.length-1 && doubleClickBuffer >10) { //if player clicks, advance the conversation to the next line(counter++)
      counter++;
      doubleClickBuffer = 0;
    } else if (mousePressed == true && counter >= scriptStrings.length-1 && doubleClickBuffer > 10) { //if the conversation is over, return to state 3 (travel)
      resetCounter();
      incScriptNumber();
      doubleClickBuffer = 0;

      gameState = 3;
    } // end if mousePressed loop
    doubleClickBuffer++;
  } //end playscene
} //end dialog class
