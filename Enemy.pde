class Enemy {
  int posx = 0;
  int posy = 0;
  PVector epos = new PVector(posx, posy);
  PVector espeed = new PVector(2, 0);
  int width = 50;
  int height = 50;
  int moveDuration;
  boolean alive = true;
  
  void draw() {
    rect(epos.x, epos.y, width, height, 50);
  }
  void move() {
    if (moveDuration <= 0) {
      setMoveDuration();
    }
    if (this.epos.x + this.width < 0) {
      this.epos.x = 800;
    }
    if (this.epos.x > 800) {
      this.epos.x = 0 - this.width;
    }
    if (this.epos.y + this. height < 0) {
      this.epos.y = 800;
    }
    if (this.epos.y > 800) {
      this.epos.y = 0 - this.height;
    }
    moveDuration--;
    this.epos.add(this.espeed);
  }
  
  void setMoveDuration() {
    moveDuration = int(random(1 * 60, 5 * 60));
    espeed.rotate(random(0, 2*PI));
  }
  
  void checkBulletCollisions() {
    for (int i = pbullets.size() - 1; i >= 0; i--) {
      if (pbullets.get(i).PBPos.x < epos.x + this.width && pbullets.get(i).PBPos.x > epos.x && pbullets.get(i).PBPos.y < epos.y + this.width && pbullets.get(i).PBPos.y > epos.y) {
        println("Hit");
        alive = false;
        pbullets.remove(i);
        scoreColour = 20;
        combo++;
        score = score + combo;
        println("score: " + score);
        lvlProgress++;
      }
    }
  }
  
  void setRandomPosition() {
    epos.x = int(random(0, 800 - this.width));
    epos.y = int(random(0, 800 - this.width));
    if (abs(this.epos.x - ppos.x) < 150 || abs(this.epos.y - ppos.y) < 150) {
      this.setRandomPosition();
    }
  }
}
