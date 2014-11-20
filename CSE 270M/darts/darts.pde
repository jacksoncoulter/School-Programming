final float RAD = 57.2957795;
final int R = 500;
final int SMALL_R = 435;
final int SMALLER = 2;
final int TRIALS = 1;

Segment eleven, eight, sixteen, seven, nineteen, three, seventeen, two, fifteen, ten, fourteen, nine, twelve, five, twenty, one, eighteen, four, thirteen, six;
Segment[] segments;

void setup() {
  size(1000, 1000); 
  background(150, 150, 150);

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

  drawBoard();
  Segment[] temp = {
    eleven, eight, sixteen, seven, nineteen, three, seventeen, two, fifteen, ten, fourteen, nine, twelve, five, twenty, one, eighteen, four, thirteen, six
  };
  segments = temp;

  // Average for one hand
  println("The average for three darts: " + monteCarloDarts(TRIALS, true));
  //println("The probability of getting a bullseye: " + monteCarloBullseye(TRIALS, true));
}

float monteCarloDarts(int trials, boolean draw) {
  float average = 0;
  for (int i = 0; i < trials; i++) {
    average += throwDarts(3, draw);
  }
  average /= trials;
  return average;
}

float monteCarloBullseye(int trials, boolean draw) {
  float bullseyes = 0;
  for (int i = 0; i < trials; i++) {
    if (bullseyeCheck(draw))
      bullseyes++;
  }
  return bullseyes / trials;
}

boolean bullseyeCheck(boolean draw) {
  Point dart = throwDart();
  if (draw)
    drawPoint(dart);
  if (dist(dart.x, dart.y, 500, 500) < 14)
    return true;
  else
    return false;
}

void drawPoint(Point dart) {
  stroke(247, 130, 226);
  strokeWeight(3);
  point(dart.x, dart.y);
}

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

void drawBoard() {
  ellipse(500, 500, 1000, 1000);

  fill(0, 0, 0);
  ellipse(500, 500, 1000, 1000);

  fill(76, 0, 153);
  ellipse(500, 500, 754, 754);
  fill(24, 80, 9);
  ellipse(500, 500, 719, 719);

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

  fill(0, 255, 0);
  ellipse(500, 500, 71, 71);
  fill(255, 0, 0);
  ellipse(500, 500, 28, 28);
}

