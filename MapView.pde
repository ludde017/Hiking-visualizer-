// ---------------------------------------------------------
// Draws the Map for height image.
// ---------------------------------------------------------

public class MapView extends View {
  private MapModel model;
  private float zoom = 1.0;
  public float translateX = 0.0;
  public float translateY = 0.0;
  private PanZoomPage panZoomPage;
  PImage img;
  float imgScale;
  float aspect;
  int nodes = 1;
  public MapView(MapModel model, int x, int y, int w, int h) {
    super(x, y, w, h);
    this.model = model;
    img = model.getMap().getColorImage();
    panZoomPage = new PanZoomPage(x, y, w, h);
    panZoomPage.fitPageOnScreen();
    
    if (img.width > img.height) {
      imgScale = 1.0/img.width;
    } else {
      imgScale = 1.0/img.height;
    }
  }
  
  public void drawView() {
    // Center the map
    float imageX = panZoomPage.pageXtoScreenX(0.5);
    float imageY = panZoomPage.pageYtoScreenY(0.5);
    
    // Draw the map using the panZoomPage
    pushMatrix();
    translate(imageX, imageY);
    scale(1.0*panZoomPage.pageLengthToScreenLength(1.0)*imgScale);
    translate(-img.width/2,-img.height/2);
    image(img, 0, 0);
    popMatrix();
    
    // Show the cross hairs for querying the image
    stroke(200,0,0);
    line(mouseX,0, mouseX,h);
    line(0,mouseY, w,mouseY);
    fill(255,255,255);
    textSize(20);
    int imgX = screenXtoImageX(mouseX);
    int imgY = screenYtoImageY(mouseY);
    if (imgX >= 0 && imgX < img.width && imgY >= 0 && imgY < img.height) {
      text("" + imgX + ", " + imgY , mouseX+50, mouseY+50);
      /*if (mousePressed == true) {
        print(mouseX,mouseY);
        model.getMap().path.add(nodes, new PVector(panZoomPage.screenXtoPageX(mouseX),panZoomPage.screenYtoPageY(mouseY)));
        nodes +=1;
      
      }*/
    }
    
    fill(0,0,0);
    stroke(255,255,0);
    for (int i = 0; i <model.getMap().path.size(); i++){
      PVector point = model.getMap().path.get(i);
      float pageCordsX = panZoomPage.pageXtoScreenX(point.x);
      float pageCordsY = panZoomPage.pageYtoScreenY(point.y);
      fill(255,255,0,255);
      circle(pageCordsX,pageCordsY,5);
      
     
    }
    
      beginShape();   
      for (int i = 0; i <model.getMap().path.size(); i++){
        PVector point = model.getMap().path.get(i);
        float pageCordsX = panZoomPage.pageXtoScreenX(point.x);
        float pageCordsY = panZoomPage.pageYtoScreenY(point.y);
        stroke(255,255,0,255);
        fill(255,255,0,0);
        //circle(pageCordsX,pageCordsY,5);
        if (i==0 || i == model.getMap().path.size()-1){vertex(pageCordsX,pageCordsY);}
        vertex(pageCordsX*.9998,pageCordsY);
        
      }
      endShape();
      
   
  }

  // Use the screen position to get the x value of the image
  public int screenXtoImageX(int screenX) {
    float x = panZoomPage.screenXtoPageX(screenX);
    return (int)((x-0.5 + img.width*imgScale/2)*img.width/(img.width*imgScale));
  }
  
  // Use the screen position to get the y value of the image
  public int screenYtoImageY(int screenY) {
    float y = panZoomPage.screenYtoPageY(screenY);
    return (int)((y-0.5 + img.height*imgScale/2)*img.height/(img.height*imgScale));
  }
};
