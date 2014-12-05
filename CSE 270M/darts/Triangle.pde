class Triangle {

  // Array containing the verticies of the triangle
  private Point[] v;

  // Creates a triangle given two end points connected to the center of the window
  public Triangle(float xStart, float yStart, float xEnd, float yEnd, boolean draw) {
    if (draw) {
      strokeWeight(1);
      stroke(255, 255, 255);
      line(xStart, yStart, width/2, height/2);
      line(xEnd, yEnd, width/2, height/2);
    }
    v = new Point[3];
    v[0] = new Point(xStart, yStart);
    v[1] = new Point(xEnd, yEnd);
    v[2] = new Point(500, 500);
  }

  // Checks if a point is inside the triangle
  // Uses method found here: http://mathforum.org/library/drmath/view/54505.html
  // If the cross product the three calculated cross products are all either negative
  // or all positive then the point is within the trianlge
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
  
  // Computes the cross product of four points
  public float crossProduct(Point a, Point b, Point c, Point d) {
      return (b.x - a.x) * (d.y - c.y) - (d.x - c.x) * (b.y - a.y);
  }
  
}

