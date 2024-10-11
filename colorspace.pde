color mapColor(PImage map, float value) {
  // Use lerp to get the color map index based on value
  float x = lerp(0, map.width-1, value);
  
  // Lookup and return color in color map
  int loc = (int)(x + map.width);
  return map.pixels[loc];
}
