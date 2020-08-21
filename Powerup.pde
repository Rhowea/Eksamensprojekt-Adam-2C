class Powerup {
  int posX = 400;
  int posY = 400;
  int width = 10;
  int height = 10;
  int typeR = 0;
  int typeG = 0;
  int typeB = 0;
  int type;
  
  void setType() {
    type = int(random(0, 3)); //0, 1, 2
    if (type == 0) {
      typeR = 255;
    }
    if (type == 1) {
      typeG = 255;
    }
    if (type == 2) {
      typeB = 255;
    }
  }
  
  void draw() {
    fill(typeR, typeG, typeB);
    rect(posX, posY, width, height);
  }
  
  void setRandomPosition() {
    posX = int(random(0, 800));
    posY = int(random(0, 800));
  }
}
