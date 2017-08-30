
private boolean isClicked = true;
public final int editorScale = 20;
public boolean keySpace = false;
public int modX;
public int modY;
public int editX;//0-39
public int editY = 0;//0-1000
public int editZ;//0-39
private int selectedBlockID = 0;
private int orientation = 0;
public ArrayList<gameObject>levelData = new ArrayList<gameObject>();
public ArrayList<Integer[]>levelIndex = new ArrayList<Integer[]>();//lists of lists that each contain data for 1 object
void setup(){
  size(1200,800, P2D);//editorScale*40 is side width of level area, which would be a maximum of 40 by 40 lbocks,plus the extra 200px of space on both sides for UI
  surface.setResizable(false);
}
void draw(){
  background(255,255,255);
  drawGrid();
  updateMouse();
  renderCursor();
  updateAction();
  drawBlocks();
}
void keyPressed(){
  if(key == ' '){
    keySpace = true; 
  }
}
void updateAction(){
  if(isClicked){
    addObject();
  }
}
void keyReleased(){
  if(key == ' '){
    keySpace = false; 
  }
}
void updateMouse(){
   isClicked = mousePressed;
   if(abs(mouseX-600) < 400){
     modX = roundTo(mouseX-editorScale/2, editorScale);
     modY = roundTo(mouseY-editorScale/2, editorScale);
   }else{
     modX = 600;
     modY = 400;
   }
   editX = round((modX-200)/editorScale);
   editZ = round((modY/editorScale));
}
void writeToFile(String data){

}
public void drawGrid(){
  strokeWeight(2);
  for(int x =0; x <= 40 ; x++){
    line(200+x*20,0,200+x*20,height);
  }
  for(int y =0; y <= 40 ; y++){
    line(200,y*20,1000,y*20);
  }
}
public void renderCursor(){
  fill(200,200,200);
  rect(modX, modY, editorScale, editorScale);
}
public int roundTo(int num, int to){
  float m = to/2;
  return round(num+m - (num+m)%to);
}
private void addObject(){
  if(levelIndex.contains(new Integer[] {editY,editX,editZ})){
  
  }else{
    levelIndex.add(new Integer[] {editY,editX,editZ});
    levelData.add(new gameObject(editX,editY,editZ,selectedBlockID,orientation));
  }
}
public void drawBlocks(){
  for(int i = 0; i < levelIndex.size(); i++){
    rect(200+levelIndex.get(i)[1]*editorScale, levelIndex.get(i)[2]*editorScale, editorScale, editorScale);
  }
}