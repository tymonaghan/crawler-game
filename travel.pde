void travel(){
  background(255);
  fill(0);
  Button beginEncounter;
  beginEncounter = new Button(width-70,50);
  beginEncounter.display(100,50,0,1,"Battle init");
  beginEncounter.clickCheck(mouseX,mouseY,2);
  
  movingBackground(zone);
  moveCharacter(frames);
}
