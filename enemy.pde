class Enemy {
  int enemyType, enemyAttackLevel, enemyDefenseLevel, enemyHitPoints, enemyMaxHP, damage, damageType;

  Enemy(int atk_, int def_, int hp_) {
    enemyAttackLevel = atk_;
    enemyDefenseLevel = def_;
    enemyHitPoints = hp_;
    enemyMaxHP = hp_;
  } // end enemy constructor

  void display (int enemyType_) {
    noTint();
    imageMode(CENTER);
    image(imageAssets[5], .45*width, battleGrid.getGridRowCenter(1));
    this.showLifeBar();
    enemyType = enemyType_;
  } // end display

  void setHitPoints (int dmg_, int dmgType_) {
    damage = dmg_;
    damageType = dmgType_;

    enemyHitPoints = enemyHitPoints + damage;
  } //end setHitPoints

  int getHitPoints () {
    return enemyHitPoints;
  } //end getHitPoints

  void showLifeBar() {
    rectMode(CORNER);
    fill(0);
    noStroke();
    rect(.45*width-35, battleGrid.getGridRowCenter(1)+15, 50, 10);
    fill(200-(enemyHitPoints*10), enemyHitPoints*20, 0);
    rect(.45*width-35, battleGrid.getGridRowCenter(1)+15, enemyHitPoints*5, 10);
  } //end showLifeBar

  void takeTurn() {
    int enemyDamage = int(random(5, 12)); //randomize enemy damage
    playerCharacter.hurtPlayer(enemyDamage); //hurt the player by that amount
    enemyState = 2;
    return;
  }//end enemy.takeTurn

  void drawTurnReport() {
    println("you are reaching the goon.drawTurnReport function");
    int ticker = mainBattleMenu.getTicker();
    fill( colorScheme[3]); //static colors
    stroke (colorScheme[4]);
    if (playerCharacter.hitPoints <25) {
      stroke(colorScheme[2]);
    } //end if
    strokeWeight(5);
    rectMode(CENTER);
    rect(width/2, height/2, width/5, height/5);
    fill(colorScheme[4]);
    text("enemy "+enemyTypes.get(0)+" attacked ya \nclick to advance", width/2, height/2);
    if (keyPressed == true && key == ' ' && ticker >10) {
      advanceToNextTurn();
    }
    ticker++;
  } //end notifyPlayerofTurnResults
  
  
} //end enemy class
