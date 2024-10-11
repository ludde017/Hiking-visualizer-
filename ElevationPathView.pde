// ---------------------------------------------------------
// Draws the elevation path
// ---------------------------------------------------------

public class ElevationPathView extends View {
  private MapModel model;
  
  public ElevationPathView(MapModel model, int x, int y, int w, int h) {
    super(x, y, w, h);
    this.model = model;
  }
  
  public void drawView() {
     fill(255);
     fill(255,255,0);
     text("Elevation Path View", x + 400, y + 30);
     fill(255);


     float total = 0;
     float lastPoint = 0;
     for (int i = 0; i < model.getMap().distances.size(); i++) {
      total += model.getMap().distances.get(i);
      
      
    }
     lastPoint = model.getMap().distances.get((model.getMap().distances.size()-1));
     text("Total Dis:"+nf(total, 0, 2),x + 650, y + 30);
     text("Last path Dis:"+nf(lastPoint,0,2),x + 850, y + 30);

    
     text("542m", x + 20, y + 30);
     text("141m", x + 20, y + 270);
     float totalDistance =0;

     for (int i = 0; i < model.getMap().path.size(); i++){
      PVector point = model.getMap().path.get(i);
      float elevation= model.getMap().getElevation((int)(point.x*model.getMap().getWidth()),(int)(point.y*model.getMap().getHeight()));
      fill(255,255,0,255);
      totalDistance += model.getMap().distances.get(i);
      circle((50 + (totalDistance * (2.5*w)) / model.getMap().distances.size()),y+h -elevation*h - 30,5);
     
     
    }


    beginShape();   
    float totalDis =0;
    for (int i = 0; i <model.getMap().path.size(); i++){
      fill(255,0,0,0);
      PVector point = model.getMap().path.get(i);    
      float elevation= model.getMap().getElevation((int)(point.x*model.getMap().getWidth()),(int)(point.y*model.getMap().getHeight()));

     
      //if (i==0 || i == model.getMap().path.size()){vertex(x+i*w/(model.getMap().path.size())+50,y+h -elevation*h-30);}      
      //print("distance:"+distance);
      //if(i+1 !=model.getMap().path.size()){
      //  float distance = distance(model.getMap().path.get(i),model.getMap().path.get(i+1)) * 100;

      //  vertex((x+i*w/(model.getMap().path.size()-1)-50)+distance,y+h -elevation*h-30);
      //}
      totalDis += model.getMap().distances.get(i);
  
      //print("Distances i:"+i +"is:",dis);
      stroke(255,255,0,255);
      //float xValue= (dis*50)+(x+i*w/(model.getMap().path.size())+50);
      //print("Value i:"+i +"is:",xValue);
      vertex((50 + (totalDis * (2.5*w)) / (model.getMap().distances.size())),y+h -elevation*h-30);
      vertex((50 + (totalDis * (2.5*w)) / (model.getMap().distances.size())),y+h -elevation*h-30);
      
      //vertex(((totalDis * (w - 50)) / model.getMap().distances.get(model.getMap().distances.size()-1)),y+h -elevation*h-30);

     
    }
    endShape();
    
    
  }

  
};
