class Loadout {
  int ticker, itemNumber;
  float buttonX, buttonY;
  String itemName;

  Loadout() {
    ticker = 0;
  }

  void display() { //draw the main loadout window
    background(255);
    fill(colorScheme[3]);
    stroke(colorScheme[1]);
    strokeWeight(5);
    rectMode(CORNER);
    rect(0.1*width, 0.1*height, 0.8*width, 0.8*height);
    fill(colorScheme[1]);
    text("Intel Points: "+intelPoints, width/2, 0.2*height);
    tint(250, 190, 190);
    for (int i = 0; i < playerInventory.length; i++) { //draw the first set of icons in one row
      imageMode(CORNER);
      image(inventoryIcons[i], 0.15*width, 0.15*height+55*i);
    } //end for loop to display image icons

    for (int i = 0; i < playerInventory.length; i++) { // this is the best for-loop ever. it sets variables to each button and allows each to pass a unique param when clicked
      buttonX=0.15*width;
      buttonY=0.15*height+55*i;
      if (mouseX > buttonX+5 && mouseX < buttonX+45 && mouseY > buttonY+5 && mouseY < buttonY+45) { //this is the best method for checking mouse clicks I've found so far
        loadoutPopup(i); // this is all within the for-loop, so the popup appears specific to the item being hovered on
      } // end if for loadoutpopup mouse detection
    } //end for loop creating the bounds for the buttons
    playerCharacter.loadoutScreen(playerInventory);
    playButton.display(int(.15*width), int(.075 *height), 5, 4, "Deploy");
    playButton.clickCheck(mouseX,mouseY,1);
  } //end display

  void loadoutPopup(int i_) { // a popup with info about each item type
    itemNumber = i_;
    String [] labels = loadout.keyArray(); // create "labels" array with inventory slot names
    stroke(0);
    fill(200);
    strokeWeight(2);
    rectMode(CORNER);
    rect(mouseX, mouseY, 250, 100);
    fill(0);
    textAlign(LEFT, TOP);
    textFont(battleMenuFont);
    text("click to buy "+labels[itemNumber]+"\nitem cost: "+itemPrices.get(itemNumber)+"\n"+itemNotes.get(itemNumber), mouseX+5, mouseY+5);
    if (mousePressed == true && ticker > 9) { // if you press the mouse, add item to inventory
      if (intelPoints >= itemPrices.get(itemNumber)) { //check if the player can afford the item
        playerInventory[itemNumber] = playerInventory[itemNumber]+1;
        intelPoints -=itemPrices.get(itemNumber); //deduct cost of item
        ticker = 0; //reset ticker to prevent multi-clicks
      } // end if you can afford it (right now there's no else if you can't afford it but this should prevent negative numbers
    }  //end if mousePressed
    ticker++;
  } //end loadoutPopup

  void addItem(int i_) {
    itemNumber = i_;
    String [] labels = loadout.keyArray();
    playerInventory[itemNumber] = playerInventory[itemNumber]+1;
    text("acquired "+labels[itemNumber], width/2, height/2);
  } // end addItem
} //end Loadout class
