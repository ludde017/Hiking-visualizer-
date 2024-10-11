// ---------------------------------------------------------
// The MapModel class holds all the information necessary
// for working with an elevation map.  This class is application
// independent and should be separate from graphics and interaction
// logic.
// ---------------------------------------------------------

// Model class for holding information
public class MapModel {
  private ElevationMap map;
  
  // Pass in a filepath to an image.  It will use the red channel for determining the elevation.
  public MapModel(String filePath) {
    PImage heightMap = loadImage(filePath);
    map = new ElevationMap(heightMap, 0.0, 1.0);
  }
  
  // Get's the elevation map
  public ElevationMap getMap() {
    
    return map;
  }
};


// Defines an elevation map for working with terrain
public class ElevationMap {
  private PImage heightMap;
  private PImage colorImage;
  private float low;
  private float high;
 
  ArrayList<PVector> path = new ArrayList<PVector>();
  ArrayList<Float> distances = new ArrayList<Float>();
  
  // The heightmap image defines the width and height and the low and high allows the user to specify the elevation range.
  // The elevation map also holds a color image that can be edited with getColor(x,y) and setColor(x,y,c)
  public ElevationMap(PImage heightMap, float low, float high) {
    this.heightMap = heightMap;
    this.low = low;
    this.high = high;
    colorImage = new PImage(heightMap.width, heightMap.height);
    colorImage.copy(heightMap, 0, 0, heightMap.width, heightMap.height, 0, 0, heightMap.width, heightMap.height);
    heightMap.loadPixels();
    colorImage.loadPixels();
    
    path.add(new PVector(0.5,0.5));
    distances.add(float(0));
    //path.add(new PVector(0.5,0.5));
    //path.add(new PVector(0.75,0.75));
  }
  
  // Get the map width
  public int getWidth() {
    return heightMap.width;
  }
  
  // Get the map height
  public int getHeight() {
    return heightMap.height;
  }
  
  // Get the elevation at a point in the map
  public float getElevation(int x, int y) {
    //println(x, y);
    float normalizedElevation = 1.0*red(heightMap.pixels[x + y*heightMap.width])/255.0;
    return lerp(low, high, normalizedElevation);
  }
  
  // Get the color image for drawing and editing purposes
  public PImage getColorImage() {
    return colorImage;
  }
  
  // Get the color at a point in the map
  public color getColor(int x, int y) {
    return colorImage.pixels[x + y*heightMap.width];
  }
  
  // Sets the color at a point in the map
  public void setColor(int x, int y, color c) {
    colorImage.pixels[x + y*heightMap.width] = c;
  }
}
