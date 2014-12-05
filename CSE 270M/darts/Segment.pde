public class Segment {

  // Array of triangles
  public Triangle[] triangles;
  // Value of the segment
  private int value;
  // Index for adding in the triangles
  private int index;

  public Segment(int value) {
    triangles = new Triangle[3];
    index = 0;
    this.value = value;
  }
  
  // Adds a triangle to the segment and increments the index
  public void add(Triangle t) {
    triangles[index] = t;
    index++;
  }
  
  // Checks every triangle in the segment if it contains a point
  public boolean contains(float x, float y) {
    for (Triangle t : triangles) {
      if (t.contains(x, y))
        return true;
    }
    return false;
  }
  
  // Returns the value of the segment
  public int getValue() {
   return value;
  } 
}

