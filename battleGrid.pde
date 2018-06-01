class BattleGrid {
  color gridLineColor;
  int xSize, ySize, zone, badGuyCount, badGuyLevel, eastCover, northCover, southCover, westCover;
  int[] encounterInfo = new int[7];

  BattleGrid(int zone_, int badGuyCount_, int badGuyLevel_) {
    gridLineColor = getTextColor(zone);
  } // end constructor

  int[] spawnEncounter() {
    encounterInfo[0] = zone;
    encounterInfo[1] = int(random(5));
    encounterInfo[2] = int(random(5));
    encounterInfo[3] = int(random(3));
    encounterInfo[4] = int(random(3));
    encounterInfo[5] = int(random(3));
    encounterInfo[6] = int(random(3));
    badGuyCount = encounterInfo[1];
    badGuyLevel = encounterInfo[2];
    westCover = encounterInfo[3];
    northCover = encounterInfo[4];
    eastCover = encounterInfo[5];
    southCover = encounterInfo[6];
    //println("zone: "+zone);
    //println("badguy qty: "+badGuyCount);
    //println("badguy lvl: "+badGuyLevel);
    return encounterInfo;
  }//end spawnEncounter
  
  void drawGrid(){
    strokeWeight(1);
    stroke(colorScheme[1]);
    line(.35*width, .12*height, .3*width, .6*height); //draw the lines of the grid
    line(.55*width, .12*height, .5*width, .6*height);
    line(.2*width, .25*height, .68*width, .25*height);
    line(.18*width, .45*height, .66*width, .45*height);
  } //end drawGrid
    
  int getGridRowCenter(int row_){
    int row = row_;
    int row0yCenter = int(.16*height);
    int row1yCenter = int(.35*height);
    int row2yCenter = int(.525*height);
    if (row == 0 ){
    return row0yCenter;
    } else if (row == 1) { 
      return row1yCenter;
    } else if (row == 2) {
      return row2yCenter;
    } //end ifs
    return 0;
  } //end getGridColCenter
  
  void drawEnemies(){ //calls the Enemy.display(enemyLevel) function to draw enemies on the grid
    imageMode(CENTER);
    goon.display(0);
  } //end drawEnemies
} //end battlegrid class
