class Enemy {
  int enemyAttackLevel, enemyDefenseLevel, enemyHitPoints, enemyMaxHP, damage, damageType;

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
    rect(.45*width-35,battleGrid.getGridRowCenter(1)+15, 50, 10);
    fill(200-(enemyHitPoints*10), enemyHitPoints*20, 0);
    rect(.45*width-35, battleGrid.getGridRowCenter(1)+15, enemyHitPoints*5, 10);
  } //end showLifeBar
} //end enemy class
