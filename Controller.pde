// ---------------------------------------------------------
// In this application, the controller can update the model,
// query the view, and modify view display parameters
// ---------------------------------------------------------

public class Controller {
  // The model and view references
  private MapModel model;
  private MapView mapView;
  private Spatial3DView spatialView;
  private ElevationPathView elevationPathView;
  private HistogramView histogramView;
  
  // Pass in the model and view for use
  Controller(MapModel model, MapView mapView, Spatial3DView spatialView, ElevationPathView elevationPathView, HistogramView histogramView) {
    this.model = model;
    this.mapView = mapView;
    this.spatialView = spatialView;
    this.elevationPathView = elevationPathView;
    this.histogramView = histogramView;
    ElevationMap map = model.getMap();
    int MWidth = map.getWidth();
    int MHeight = map.getHeight();
    for (int i=0; i< MWidth; i++){
      for(int j=0; j < MHeight; j++){
        float val = blue(map.getColor(i,j))/255;
        color darkBlue = color(255,255,255,255);
        color lightBlue = color(0,0,148,255);
        color colorMap = lerpColorLab(lightBlue, darkBlue, val);
        map.setColor(i,j,colorMap);
      }
    }
  }
  
  // Controls the update loop of the simulation
  public void update(float dt) {
    spatialView.setRotation(frameCount/1000.0);
  }
  
  public void mousePressed() {
    if (mapView.isInside(mouseX, mouseY) && (mouseButton == CENTER || mouseButton == RIGHT)) {
      mapView.panZoomPage.mousePressed();
      //model.getMap().path.add(new PVector(mapView.panZoomPage.screenXtoPageX(mouseX),mapView.panZoomPage.screenYtoPageY(mouseY)));

      //print(mouseX, mouseY);
 
    }
    if (mapView.isInside(mouseX, mouseY) && (mouseButton == LEFT)) {
      //model.getMap().path.add(new PVector(mapView.panZoomPage.screenXtoPageX(mouseX),mapView.panZoomPage.screenYtoPageY(mouseY)));
    }
    if(mapView.isInside(mouseX, mouseY)){
       
       int imgX = mapView.screenXtoImageX(mouseX);
       int imgY = mapView.screenYtoImageY(mouseY);
       if (imgX >= 0 && imgX < 300 && imgY >= 0 && imgY < 300) {
         model.getMap().path.add(new PVector(mapView.panZoomPage.screenXtoPageX(mouseX),mapView.panZoomPage.screenYtoPageY(mouseY)));
         model.getMap().distances.add(abs(distance(model.getMap().path.get(model.getMap().path.size()-2),model.getMap().path.get(model.getMap().path.size()-1))));
       }
    }
  }
  
  public void mouseReleased() {
    //if (mapView.isInside(mouseX, mouseY) && (mouseButton == LEFT)) {
    //  model.getMap().path.add(new PVector(mapView.panZoomPage.screenXtoPageX(mouseX),mapView.panZoomPage.screenYtoPageY(mouseY)));
    //}
  }
  
  public void mouseDragged() {   
    if (mapView.isInside(mouseX, mouseY) && (mouseButton == CENTER || mouseButton == RIGHT)) {
      mapView.panZoomPage.mouseDragged();
    }

  }
  
  public void mouseMoved() {
    if (mapView.isInside(mouseX, mouseY)) {
      cursor(CROSS);
    }
    else {
      cursor(ARROW);
    }
  }
  
  public void mouseWheel(MouseEvent event) {
    if (mapView.isInside(mouseX, mouseY)) {
      mapView.panZoomPage.mouseWheel(event);
    }
    
    if (spatialView.isInside(mouseX, mouseY)) {
      spatialView.setZoom(spatialView.getZoom() + event.getCount()*0.1);
    }
  }
}
