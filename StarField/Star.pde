int MAX_Z = 1000;

class Star {
  float x;  
  float y;
  float z;

  Star() {
    x = random(-width / 2, width / 2);
    y = random(-height / 2, height / 2);
    z = random(MAX_Z);
  }

  void update() {
    z -= 5;
    
    if (z < 1) {
      x = random(-width / 2, width / 2);
      y = random(-height / 2, height / 2);
      z = MAX_Z;
    }
  }

  void show() {
    float size = ((MAX_Z - z) / MAX_Z) * 8.0;
    fill(size * 16 + 128);
    noStroke();   
    
    float sx = map(x / z, -width / MAX_Z / 2.0, width / MAX_Z / 2.0, -width / 2, width / 2);
    float sy = map(y / z, -height / MAX_Z / 2.0, height / MAX_Z / 2.0, -height / 2, height / 2);
   
    circle(sx, sy, size);
  }
}
