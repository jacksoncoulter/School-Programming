final float RAD = 57.2957795;
final int R = 500; // Radius of the entire dart board
final int SMALL_R = 435; // Radius of the smaller circle worth points
final int TRIALS = 100000; // Number of trials to run
String results; // The results of the trials

// Segments for each scoring section
Segment eleven, eight, sixteen, seven, nineteen, three, seventeen, two, fifteen, ten, fourteen, nine, twelve, five, twenty, one, eighteen, four, thirteen, six;
// Array of all the segments
Segment[] segments;

void setup() {
  size(1000, 1000); 
  background(150, 150, 150);
  results = "";

  // Setup segments assigning values
  eleven = new Segment(11);
  eight = new Segment(8);
  sixteen = new Segment(16);
  seven = new Segment(7);
  nineteen = new Segment(19);
  three = new Segment(3);
  seventeen = new Segment(17);
  two = new Segment(2);
  fifteen = new Segment(15);
  ten = new Segment(10);
  fourteen = new Segment(14);
  nine = new Segment(9);
  twelve = new Segment(12);
  five = new Segment(5);
  twenty = new Segment(20);
  one = new Segment(1);
  eighteen = new Segment(18);
  four = new Segment(4);
  thirteen = new Segment(13);
  six = new Segment(6);
  
  // Filling segments array with the segments
  Segment[] temp = {
    eleven, eight, sixteen, seven, nineteen, three, seventeen, two, fifteen, ten, fourteen, nine, twelve, five, twenty, one, eighteen, four, thirteen, six
  };
  segments = temp;
  
  // drawing the board
  drawBoard();
}

void draw() {
  drawButtons();
}

// Draws the buttons for interaction
void drawButtons() {
  fill(255, 255, 255);
  stroke(0, 0, 0);
  strokeWeight(1);
  rectMode(CORNER);

  // Clear
  rect(5, 5, 150, 20);

  // Average for 1 dart
  rect(5, 30, 150, 20);

  // Average for 3 darts
  rect(5, 55, 150, 20);

  // Bullseye odds
  rect(5, 80, 150, 20);

  // Output
  rect(width - 155, 5, 150, 20);

  fill(0, 0, 0);
  textSize(12);
  textAlign(LEFT, TOP);

  // Button labels
  text("Clear", 10, 7);
  text("Average for 1 dart", 10, 32);
  text("Average for 3 darts", 10, 57);
  text("Bullseye odds", 10, 82);
  text("Result: ", width - 145, 7);
  text(results, width - 102, 7);
}

// Handles button preses
void mousePressed() {
  float x = mouseX;
  float y = mouseY;

  if (x >= 5 && x <= 155) {

    // Clear
    if (y >= 5 && y <= 25) {
      drawBoard();
      results = "";
    }
    // Average for 1 dart
    else if (y >= 30 && y <= 50) {
      results = "" + monteCarloDartsX(TRIALS, 1, true);
      results += " points";
    }
    // Average for 3 darts
    else if (y >= 55 && y <= 75) {
      results = "" + monteCarloDartsX(TRIALS, 3, true);
      results += " points";
    }
    // Bullseye odds
    else if (y >= 80 && y <= 100) {
      results = "" + monteCarloBullseye(TRIALS, true);
      results += " odds";
    }
  }
}

// Gives the average number of darts to reach 501
float monteCarloDarts(int trials, boolean draw) {
  float average = 0;
  for (int i = 0; i < trials; i++) {
    int score = 0;
    int count = 0;
    while (score != 501) {
      Point dart = throwDart();
      if (draw)
        drawPoint(dart);
      int addition = getScore(dart);
      if ((score + addition) <= 501)
        score += addition;
      count++;
    }
    average += count;
  }
  average /= trials;
  return average;
}

// Gives the average points for a given number of darts
float monteCarloDartsX(int trials, int darts, boolean draw) {
  float average = 0;
  for (int i = 0; i < trials; i++) {
    average += throwDarts(darts, draw);
  }
  average /= trials;
  return average;
}

// Gives the odds of hitting the bullseye
float monteCarloBullseye(int trials, boolean draw) {
  float bullseyes = 0;
  for (int i = 0; i < trials; i++) {
    if (bullseyeCheck(draw))
      bullseyes++;
  }
  return bullseyes / trials;
}

// Throws a dart and checks if it got a bullseye
boolean bullseyeCheck(boolean draw) {
  Point dart = throwDart();
  if (draw)
    drawPoint(dart);
  if (dist(dart.x, dart.y, 500, 500) < 14)
    return true;
  else
    return false;
}

// Draws a dart throw
void drawPoint(Point dart) {
  stroke(247, 130, 226);
  strokeWeight(1);
  point(dart.x, dart.y);
  stroke(0, 0, 0);
  strokeWeight(1);
}

// Throws a given number of darts and returns the score
int throwDarts(int trials, boolean draw) {
  int score = 0;
  Point dart;
  for (int i = 0; i < trials; i++) {
    dart = throwDart();
    score += getScore(dart);

    if (draw)
      drawPoint(dart);
  }
  return score;
}

// Returns a random point on the dart board
Point throwDart() {
  float randX;
  float randY;
  do {
    randX = random(0, width);
    randY = random(0, height);
  } 
  while (dist (randX, randY, 500, 500) > 500);
  return new Point(randX, randY);
}

// Scores a dart throw
int getScore(Point p) {
  int score = 0;
  float distance = dist(p.x, p.y, 500, 500);

  // Off board
  if (distance > 377)
    score += 0;

  // Bullseye check
  else if (distance < 14)
    score += 50;
  else if (distance < 35.5)
    score += 25;

  // Check Segments
  else {
    for (Segment segment : segments) {
      if (segment.contains(p.x, p.y))
        score += segment.getValue();
    }
  }

  // Check double and triple
  if (distance >= 359.5 && distance <= 377)
    score *= 2;
  else if (distance >= 220 && distance <= 237.5)
    score *= 3;

  return score;
}

// Draws the dart board
void drawBoard() {

  for (Segment s : segments) {
    s.index = 0;
  }

  // Outer sircle
  fill(255, 255, 255);
  ellipse(500, 500, 1000, 1000);

  // Inner circle
  fill(0, 0, 0);
  ellipse(500, 500, 1000, 1000);
   
  // Double ring 
  fill(76, 0, 153);
  ellipse(500, 500, 754, 754);
  fill(24, 80, 9);
  ellipse(500, 500, 719, 719);

  // Triple ring
  fill(255, 255, 0);
  ellipse(500, 500, 475, 475);
  fill(24, 80, 9);
  ellipse(500, 500, 440, 440);

  float theta = 180;
  float xStart;
  float yStart;
  float xEnd = 0;
  float yEnd = 500;

  // Generate bottom half
  for (int i = 0; i < 10; i++) {
    theta -= 18;
    xStart = xEnd;
    yStart = yEnd;
    xEnd = (float)((Math.cos(theta / RAD) * R));
    yEnd = (float)(Math.sqrt((R * R) - (xEnd * xEnd)));
    xEnd += R;
    yEnd += R;
    Triangle t = new Triangle(xStart, yStart, xEnd, yEnd, true);
  }

  // Generate top half
  for (int i = 0; i < 10; i++) {
    theta -= 18;
    xStart = xEnd;
    yStart = yEnd;
    xEnd = (float)((Math.cos(theta / RAD) * R));
    yEnd = -(float)(Math.sqrt((R * R) - (xEnd * xEnd)));
    xEnd += R;
    yEnd += R;
    Triangle t = new Triangle(xStart, yStart, xEnd, yEnd, true);
  }

  theta = 180;
  xEnd = 0;
  yEnd = 500;

  // Generate bottom half for calculations
  for (int i = 0; i < 30; i++) {
    theta -= 6;
    xStart = xEnd;
    yStart = yEnd;
    xEnd = (float)((Math.cos(theta / RAD) * R));
    yEnd = (float)(Math.sqrt((R * R) - (xEnd * xEnd)));
    xEnd += R;
    yEnd += R;

    if (i >= 0 && i <= 2)
      eleven.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 3 && i <= 5)
      eight.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 6 && i <= 8)
      sixteen.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 9 && i <= 11)
      seven.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 12 && i <= 14)
      nineteen.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 15 && i <= 17)
      three.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 18 && i <= 20)
      seventeen.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 21 && i <= 23)
      two.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 24 && i <= 26)
      fifteen.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 27 && i <= 29)
      ten.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
  }

  // Generate top half for calculations
  for (int i = 0; i < 30; i++) {
    theta -= 6;
    xStart = xEnd;
    yStart = yEnd;
    xEnd = (float)((Math.cos(theta / RAD) * R));
    yEnd = -(float)(Math.sqrt((R * R) - (xEnd * xEnd)));
    xEnd += R;
    yEnd += R;

    if (i >= 0 && i <= 2)
      six.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 3 && i <= 5)
      thirteen.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 6 && i <= 8)
      four.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 9 && i <= 11)
      eighteen.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 12 && i <= 14)
      one.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 15 && i <= 17)
      twenty.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 18 && i <= 20)
      five.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 21 && i <= 23)
      twelve.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 24 && i <= 26)
      nine.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
    else if (i >= 27 && i <= 29)
      fourteen.add(new Triangle(xStart, yStart, xEnd, yEnd, false));
  }

  theta = 189;

  fill(255, 255, 255);
  // Generate bottom half numbers
  for (int i = 0; i < 10; i++) {
    theta -= 18;
    xStart = xEnd;
    yStart = yEnd;
    xEnd = (float)((Math.cos(theta / RAD) * SMALL_R));
    yEnd = (float)(Math.sqrt((SMALL_R * SMALL_R) - (xEnd * xEnd)));
    xEnd += R;
    yEnd += R;

    textSize(40);
    textAlign(CENTER, CENTER);
    String text = "";
    switch(i) {
    case 0:
      text = "11";
      break;
    case 1:
      text = "8";
      break;
    case 2:
      text = "16";
      break;
    case 3:
      text = "7";
      break;
    case 4:
      text = "19";
      break;
    case 5:
      text = "3";
      break;
    case 6:
      text = "17";
      break;
    case 7:
      text = "2";
      break;
    case 8:
      text = "15";
      break;
    case 9:
      text = "10";
      break;
    }

    text(text, xEnd, yEnd);
  }

  // Generate top half numbers
  for (int i = 0; i < 10; i++) {
    theta -= 18;
    xStart = xEnd;
    yStart = yEnd;
    xEnd = (float)((Math.cos(theta / RAD) * SMALL_R));
    yEnd = -(float)(Math.sqrt((SMALL_R * SMALL_R) - (xEnd * xEnd)));
    xEnd += R;
    yEnd += R;

    String text = "";
    switch(i) {
    case 0:
      text = "6";
      break;
    case 1:
      text = "13";
      break;
    case 2:
      text = "4";
      break;
    case 3:
      text = "18";
      break;
    case 4:
      text = "1";
      break;
    case 5:
      text = "20";
      break;
    case 6:
      text = "5";
      break;
    case 7:
      text = "12";
      break;
    case 8:
      text = "9";
      break;
    case 9:
      text = "14";
      break;
    }

    text(text, xEnd, yEnd);
  }

  // Inner and outer bullseye
  fill(0, 255, 0);
  ellipse(500, 500, 71, 71);
  fill(255, 0, 0);
  ellipse(500, 500, 28, 28);
}

