class PlayerBullet {
  int speed = 9;
  float rotation;
  float startX;
  float startY;
  PVector PBPos = new PVector();
  PVector speedVector = new PVector(speed, 0);
  
  void setRotation(float r) {
    if (rotation != r) {
      rotation = r;
      speedVector.rotate(rotation);
    }
  }
  
  void setStart() {
    startX = ppos.x;
    startY = ppos.y;
    println(startX);
    PBPos.set(startX + player.width/2, startY + player.height/2);
  }
  
  void appear() {
    circle(PBPos.x, PBPos.y, 5);
    PBPos.add(speedVector);
  }
}
