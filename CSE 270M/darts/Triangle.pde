class Triangle {

  private Point[] v;

  public Triangle(float xStart, float yStart, float xEnd, float yEnd, boolean draw) {
    if (draw) {
      strokeWeight(1);
      line(xStart, yStart, width/2, height/2);
      line(xEnd, yEnd, width/2, height/2);
    }
    v = new Point[3];
    v[0] = new Point(xStart, yStart);
    v[1] = new Point(xEnd, yEnd);
    v[2] = new Point(500, 500);
  }

  public boolean contains(float x, float y) {
     
    Point p = new Point(x, y);
    
    float one = crossProduct(v[0], p, v[0], v[1]);
    float two = crossProduct(v[1], p, v[1], v[2]);
    float three = crossProduct(v[2], p, v[2], v[0]);
    
    if (one > 0 && two > 0 && three >0)
      return true;
    else if (one < 0 && two < 0 && three < 0)
      return true;
    
    return false;
  }
  
  public float crossProduct(Point a, Point b, Point c, Point d) {
      return (b.x - a.x) * (d.y - c.y) - (d.x - c.x) * (b.y - a.y);
  }
  

  public float area(float x1, float y1, float x2, float y2, float x3, float y3) {
    float area = 0.0;
    area = Math.abs((((x1 * y2) - (y1 * x2)) + ((x2 * y3) - (y2 * x3)) + ((x3 * y1) - y3 * x1)) / 2);
    return area;
  }
}

