void movingBackground(int zone){
  if (zone == 0){
    stroke(0);
    fill(100);
    rectMode(CORNERS);
    strokeWeight(12);
    rect(-50,height/2,width+50,height/1.1);
    stroke(150,150,0);
    strokeWeight(16);
    line(width-frames, height/1.75, width-frames+200,height/1.75);
  } // if zone 0
} //end movingBackground

void moveCharacter(int i){ //this gets fed the framecount so that it can switch walkStates
  if (walkState==true) {
    image(walkingCharacter1,50,height/1.75, 180, 200);
  } else {
    image(walkingCharacter2, 50, height/1.75, 180,200);
  } // end else
  if (i % 10 == 0) {
    walkState = !walkState; //switch the change between the two walking sprites
  }
} //end moveCharacter
