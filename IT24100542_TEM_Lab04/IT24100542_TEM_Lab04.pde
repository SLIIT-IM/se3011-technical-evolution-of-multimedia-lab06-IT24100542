
// ---------------- PLAYER ----------------
float px = 350;   // player x position
float py = 175;   // player y position
float pR = 20;    // player radius (size = 40)
float step = 6;   // movement speed

// ---------------- ENEMIES ----------------
int n = 6;  // number of enemies

float[] ex = new float[n];   // enemy x positions
float[] ey = new float[n];   // enemy y positions
float[] evx = new float[n];  // enemy x velocities
float[] evy = new float[n];  // enemy y velocities

float eR = 15;  // enemy radius (size = 30)

void setup() {
  size(700, 350);
  frameRate(144);

  // Initialize enemies with random positions and speeds
  for (int i = 0; i < n; i++) {

    ex[i] = random(eR, width - eR);
    ey[i] = random(eR, height - eR);

    evx[i] = random(-3, 3);
    evy[i] = random(-3, 3);

    // Prevent enemies from being too slow
    if (abs(evx[i]) < 1) evx[i] = 2;
    if (abs(evy[i]) < 1) evy[i] = -2;
  }
}

void draw() {
  background(240);

  // ---------------- PLAYER MOVEMENT ----------------
  // Move only if key is pressed
  if (keyPressed) {
    if (keyCode == RIGHT) px += step;
    if (keyCode == LEFT)  px -= step;
    if (keyCode == DOWN)  py += step;
    if (keyCode == UP)    py -= step;
  }

  // Keep player fully inside window
  px = constrain(px, pR, width - pR);
  py = constrain(py, pR, height - pR);

  // Draw player
  noStroke();
  fill(60, 120, 220);
  ellipse(px, py, pR*2, pR*2);

  // ---------------- ENEMIES LOOP ----------------
  for (int i = 0; i < n; i++) {

    // Move enemy
    ex[i] += evx[i];
    ey[i] += evy[i];

    // Bounce enemy off walls
    if (ex[i] > width - eR || ex[i] < eR) {
      evx[i] *= -1;
    }

    if (ey[i] > height - eR || ey[i] < eR) {
      evy[i] *= -1;
    }

    // Draw enemy
    fill(255, 90, 120);
    ellipse(ex[i], ey[i], eR*2, eR*2);

    // ---------------- COLLISION CHECK ----------------
    // Calculate distance between player and this enemy
    float d = dist(px, py, ex[i], ey[i]);

    // If distance is smaller than sum of radii → collision
    if (d < pR + eR) {
      println("HIT enemy " + i);
    }
  }

  // Instruction text
  fill(0);
  textSize(14);
  text("Move with arrow keys. Touch enemy to see HIT in Console.", 20, 25);
}
