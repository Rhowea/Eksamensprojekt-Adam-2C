Player player = new Player();
ArrayList<PlayerBullet> pbullets = new ArrayList<PlayerBullet>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Powerup> powerups = new ArrayList<Powerup>();
Boolean[] bulletDirection = new Boolean[4];
PVector ppos = new PVector(this.width/2, this.height/2);
PVector RSpeed = new PVector(player.speed, 0);
PVector LSpeed = new PVector(-player.speed, 0);
PVector USpeed = new PVector(0, -player.speed);
PVector DSpeed = new PVector(0, player.speed);
Boolean up = false;
Boolean down = false;
Boolean left = false;
Boolean right = false;
int score = 0;
int level = 1;
int lvlProgress = 0;
int combo = 0;
int comboColour = 255;
int scoreColour = 0;
boolean noComboLoss = false;

void setup() {
  player.p1 = loadImage("Player1.png");
  player.p1R = loadImage("Player1R.png");
  player.p1G = loadImage("Player1G.png");
  player.p1B = loadImage("Player1B.png");
  size(800, 800);
  smooth();
  for (int i = 0; i < 4; i++) {
    bulletDirection[i] = false;
  }
  makeNewEnemy();
  println("Setup has finished");
}

void draw() {
  clear();
  background(loadImage("BlurryStars.png"));
  for (Powerup powerup : powerups) {
    powerup.draw();
  }
  fill(255);
  for (int i = enemies.size() - 1; i >= 0; i--) {
    enemies.get(i).checkBulletCollisions();
    if (enemies.get(i).alive) {
      enemies.get(i).move();
      enemies.get(i).draw();
    } else {
      enemies.remove(i);
    }
  }
  for (int i = pbullets.size() - 1; i >= 0; i--) {
    pbullets.get(i).appear();
    if (pbullets.get(i).PBPos.x > width || pbullets.get(i).PBPos.x < 0 || pbullets.get(i).PBPos.y > height || pbullets.get(i).PBPos.y < 0) {
      pbullets.remove(i);
      println("Bullet has been removed");
      if (noComboLoss != true) {
        comboColour = 0;
        combo = 0;
      }
    }
  }
  playerMove();
  player.draw();
  checkCollision();
  player.checkPowerupCollision();
  if (enemies.size() < level) {
    makeNewEnemy();
  }
  if (lvlProgress == 5) {
    lvlProgress = 0;
    level++;
    makeNewPowerup();
  }
  textAlign(LEFT);
  fill(255);
  fill(255 - scoreColour * combo, 255, 255 - scoreColour * combo);
  scoreColour = scoreColour - 1;
  textSize(48);
  text("Score: " + score, 0, 50);
  fill(255);
  textSize(12);
  text("level " + level, 0, 65);
  if (comboColour == 255) {
    fill(comboColour);
  } else {
    comboColour = comboColour + 255/7;
    fill(255, comboColour, comboColour);
    if (comboColour > 255) comboColour = 255;
  } 
  text("combo " + combo, 0, 80);
  fill(255);
}

void checkCollision() {
  for (Enemy enemy : enemies) {
    boolean temp = longCalc(ppos.x, ppos.y, player.width, player.height, enemy.epos.x, enemy.epos.y, enemy.width, enemy.height);
    if (temp) { 
      textSize(80);
      textAlign(CENTER);
      fill(255, 0, 0);
      text("Game Over", 400, 400);
      stop();
    }
  }
}

void keyPressed() {
  redraw();
  if (key == 'w') {
    up = true;
  }
  if (key == 's') {
    down = true;
  }
  if (key == 'a') {
    left = true;
  }
  if (key == 'd') {
    right = true;
  }
  if (player.readyFire == true) {
    if (keyCode == UP) {
      bulletDirection[0] = true;
    }
    if (keyCode == DOWN) {
      bulletDirection[1] = true;
    }
    if (keyCode == LEFT) {
      bulletDirection[2] = true;
    }
    if (keyCode == RIGHT) {
      bulletDirection[3] = true;
    }
    int diagonalCounter = 0;
    for (int i = 0; i < 4; i++) {
      if (bulletDirection[i] == true) {
        diagonalCounter++;
      }
    }
    if (diagonalCounter <= 2) {
      if (bulletDirection[0] == true && bulletDirection[3] == true) {
        newPB(315);
      }
      if (bulletDirection[0] == true && bulletDirection[2] == true) {
        newPB(225);
      }
      if (bulletDirection[1] == true && bulletDirection[3] == true) {
        newPB(45);
      }
      if (bulletDirection[1] == true && bulletDirection[2] == true) {
        newPB(135);
      }
    }
    if (diagonalCounter <= 1) {
      if (bulletDirection[0] == true) {
        newPB(270);
      }
      if (bulletDirection[1] == true) {
        newPB(90);
      }
      if (bulletDirection[2] == true) {
        newPB(180);
      }
      if (bulletDirection[3] == true) {
        newPB(0);
      }
    }
  }
}

void newPB(int angle) {
  PlayerBullet pb = new PlayerBullet();
  pb.setRotation(angle*(PI/180));
  pb.setStart();
  pbullets.add(pb);
  player.setCooldown();
}

void keyReleased() {
  redraw();
  if (key == 'w') {
    up = false;
    println("release is being recognized");
  }
  if (key == 's') {
    down = false;
  }
  if (key == 'a') {
    left = false;
  }
  if (key == 'd') {
    right = false;
  }
  if (keyCode == UP) {
    bulletDirection[0] = false;
  }
  if (keyCode == DOWN) {
    bulletDirection[1] = false;
  }
  if (keyCode == LEFT) {
    bulletDirection[2] = false;
  }
  if (keyCode == RIGHT) {
    bulletDirection[3] = false;
  }
}

void playerMove() {
  if (up == true) {
    if (ppos.y > 0) {
      ppos.add(USpeed);
    }
  }
  if (down == true) {
    if (ppos.y < height - player.width) {
      ppos.add(DSpeed);
    }
  }
  if (left == true) {
    if (ppos.x > 0) {
      ppos.add(LSpeed);
    }
  }
  if (right == true) {
    if (ppos.x < width - player.width) {
      ppos.add(RSpeed);
    }
  }
}

void makeNewEnemy() {
  Enemy enemy = new Enemy();
  enemy.setRandomPosition();
  boolean temp = longCalc(ppos.x, ppos.y, player.width, player.height, enemy.epos.x, enemy.epos.y, enemy.width, enemy.height);
  if (temp) {
    println("enemy's position was changed");
    enemy.setRandomPosition();
  }
  enemies.add(enemy);
}

void makeNewPowerup() {
  Powerup powerup = new Powerup();
  powerup.setType();
  powerup.setRandomPosition();
  powerups.add(powerup);
}

boolean longCalc(float pposX, float pposY, int playerWidth, int playerHeight, float eposX, float eposY, int enemyWidth, int enemyHeight) {
  boolean temp = false;
  if (pposX + playerWidth > eposX && pposX < eposX + enemyWidth && pposY + playerHeight > eposY && ppos.y < eposY + enemyWidth && pposY + playerHeight > eposY && ppos.y < eposY + enemyHeight && pposX + playerWidth > eposX && pposX < eposX + enemyWidth) {
    temp = true;
  }
  return temp;
}

void reloadDirectionVectors() {
  RSpeed.set(player.speed, 0);
  LSpeed.set(-player.speed, 0);
  USpeed.set(0, -player.speed);
  DSpeed.set(0, player.speed);
}
