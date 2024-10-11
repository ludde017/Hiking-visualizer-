// ---------------------------------------------------------
// Draws the histogram
// ---------------------------------------------------------

// View class draws the model
public class HistogramView extends View {
  private MapModel model;
  
  public HistogramView(MapModel model, int x, int y, int w, int h) {
    super(x, y, w, h);
    this.model = model;
  }
  
  public void drawView() {
   
    fill(255);
    text("Histogram View", x + 25, y + 40);
    ElevationMap map = model.getMap();
    int MWidth = 300;
    int MHeight = 300;
    float maxEl = 0;
    float minEl = 0;
    int[] buckets = new int[10];
    for(int i=0; i < buckets.length; i++){
      buckets[i] = 0;
    }
   
    for (int i=0; i< MWidth; i++){
      for(int j=0; j < MHeight; j++){
        float elevation = model.getMap().getElevation(i,j);
        if (elevation > maxEl){maxEl = elevation;}
        if (elevation < minEl){minEl = elevation;}
        int index = (int) (elevation*.999*buckets.length);
        buckets[index] += 1;
        
        //println(index);
        
      }  
    }
 
    color from = color(255,255,255,255);
    color to = color(0,0,148,255);
  
     for (int i = 0; i < buckets.length; i++){
      fill(255,0,0,255);
      noStroke();
      float amt = (float)i / (float)buckets.length;
      color interpCol = lerpColorLab(from, to, amt);
      fill(interpCol);
      rect((x+150)+30*i, y+60+h*0.005, 30, 30);
      rect(x+i*(w/buckets.length),(y+h-7.5)-buckets[i]*0.005,(w/buckets.length),buckets[i]*0.005);
      fill(255,255,255);
      text("542 m", x+150, y + 120);
      text("151 m", x+425, y + 120);
     
    }
    
  }

  
};
