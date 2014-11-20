public class Segment {

  public Triangle[] triangles;
  private int value;
  private int index;

  public Segment(int value) {
    triangles = new Triangle[3];
    index = 0;
    this.value = value;
  }
  
  public void add(Triangle t) {
    triangles[index] = t;
    index++;
  }
  
  public boolean contains(float x, float y) {
    for (Triangle t : triangles) {
      if (t.contains(x, y))
        return true;
    }
    return false;
  }
  
  public int getValue() {
   return value;
  } 
}

