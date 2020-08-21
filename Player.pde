class Player extends Enemy {
  int cooldownTime = 10;
  int PUCooldown = 490;
  boolean readyFire = true;
  int lastFire;
  int speed = 6;
  PImage p1;
  PImage p1R;
  PImage p1G;
  PImage p1B;
  int PUType = 3;
  int lastPU;
  boolean poweredUp = false;
  void draw() {
    checkFireCooldown();
    checkPowerupCooldown();
    if (PUType != 3) {
      reloadDirectionVectors();
    }
    if (PUType == 0) {
      speed = 9;
      println("speed check");
      image(p1R, ppos.x, ppos.y);
    } else if (speed != 6) {
      speed = 6;
      reloadDirectionVectors();
    }
    if (PUType == 1) {
      combo = 10;
      comboColour = 255;
      image(p1G, ppos.x, ppos.y);
    }
    if (PUType == 2) {
      noComboLoss = true;
      image(p1B, ppos.x, ppos.y);
    }
    if (PUType == 3) {
      image(p1, ppos.x, ppos.y);
    }
  }

  void setCooldown() {
    readyFire = false;
    lastFire = frameCount;
  }

  void checkFireCooldown() {
    if (frameCount - lastFire > cooldownTime) {
      readyFire = true;
    }
  }
  void checkPowerupCollision() {
    if (poweredUp == false) {
      for (int i = powerups.size() - 1; i >= 0; i--) {
        if (longCalc(ppos.x, ppos.y, this.width, this.height, powerups.get(i).posX, powerups.get(i).posY, powerups.get(i).width, powerups.get(i).height)) {
          powerUp(powerups.get(i).type);
          poweredUp = true;
          powerups.remove(i);
        }
      }
    }
  }

  void powerUp(int type) {
    lastPU = frameCount;
    PUType = type;
  }

  void checkPowerupCooldown() {
    if (frameCount - lastPU > PUCooldown) {
      noComboLoss = false;
      poweredUp = false;
      PUType = 3;
    }
  }
}
