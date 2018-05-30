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
  }//end display
} //end battlegrid class
