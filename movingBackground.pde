void movingBackground(int zone) {
  if (zone == 0) {
    println(walkCounter);
    stroke(0);
    fill(100);
    rectMode(CORNERS);
    strokeWeight(12);
    rect(-50, height/2, width+50, height/1.1);
    stroke(150, 150, 0);
    strokeWeight(16);
    line(width-frames, .7*height, width-frames+200, .7*height);
  } // if zone 0
} //end movingBackground
