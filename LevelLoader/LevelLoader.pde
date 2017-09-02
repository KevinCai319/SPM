
private boolean isClicked = true;
public final int editorScale = 20;
public boolean keySpace = false;
public boolean inFrame = false;
public int wallHeight = 1;
public int modX;
public int modY;
public int editX;//0-39
public int editY = 0;//0-1000
public int editZ;//0-39
private int selectedBlockID = 0;
private int orientation = 0;
public ArrayList<gameObject>levelData = new ArrayList<gameObject>();
public ArrayList<int[]>levelIndex = new ArrayList<int[]>();//lists of lists that each contain data for 1 object
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
  imageMode(CENTER);
  drawBlocks();
  imageMode(CORNER);
  loadUI();
}
void keyPressed(){
  if(key == ' '){
    keySpace = true; 
  }
  if(key == 'd'){
    selectedBlockID++;
  }
  if(key == 'a'){ 
    selectedBlockID = (selectedBlockID > 0)?selectedBlockID-1:selectedBlockID; 
  }
  if(key == 'w'){
    editY++;
  }
  if(key == 's'){
    editY = (editY>0)? editY-1:editY;
  }
  if(key == 'q'){
    wallHeight = (wallHeight > 1)?wallHeight-1:wallHeight; 
  }
  if(key == 'e'){
    wallHeight = (wallHeight < 9)?wallHeight+1:wallHeight; 
  }
}
void updateAction(){
  if(isClicked && inFrame){
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
     inFrame = true;
   }else{
     modX = 600;
     modY = 400;
     inFrame = false;
   }
   editX = round((modX-200)/editorScale);
   editZ = round((modY/editorScale));
}
void writeToFile(String data){

}
public void drawGrid(){
  strokeWeight(2);
  stroke(0);
  for(int x =0; x <= 40 ; x++){
    line(200+x*20,0,200+x*20,height);
  }
  for(int y =0; y <= 40 ; y++){
    line(200,y*20,1000,y*20);
  }
}
public void renderCursor(){
  fill(200,200,200);
  if(inFrame){
    rect(modX, modY, editorScale, editorScale);
  }
}
public int roundTo(int num, int to){
  float m = to/2;
  return round(num+m - (num+m)%to);
}
private void loadUI(){
  shape(loadShape("blockHeight.svg"),12.5+1000,height/2-130,175,200);
  shape(loadShape("blockID.svg"),12.5,height/2-130,175,200);
  shape(loadShape("blockOri.svg"),12.5,height/8*5,175,75);
  shape(loadShape("wallSelect.svg"),1012.5,height/8*5,175,212);
  idPrint(selectedBlockID,0,(height/2)-50,1);
  idPrint(editY,1000,(height/2)-50,1);
  idPrint(wallHeight,1025,(height/8*5)+100,2);
  orientationUI(100,height/8*7,50);
}
private void idPrint(int i,int p,int y,int size){
  String m = Integer.toString(i);
  int start = (200/(m.length()+1));
  for (int j = 0; j< m.length();j++){
    if(m.charAt(j) == '1'){
      shape(loadShape(m.charAt(j) + ".svg"),start/8+p+(j+0.5)*start,y,start/(2*size),100/size);
    }else{
      shape(loadShape(m.charAt(j) + ".svg"),p+(j+0.5)*start,y,start/size,100/size);
    }
  }
  
}
private void loadImages(){
/*
loadShape("blockHeight.svg")
loadShape("blockID.svg")
loadShape("blockOri.svg")
loadShape("wallSelect.svg")
loadShape("USL.svg")
loadShape("USL.svg")
loadShape("RL.svg")
loadShape("RSL.svg")
loadShape("DL.svg")
loadShape("DSL.svg")
loadShape("LL.svg")
loadShape("LSL.svg")
loadShape("0.svg")
loadShape("1.svg")
loadShape("2.svg")
loadShape("3.svg")
loadShape("4.svg")
loadShape("5.svg")
loadShape("6.svg")
loadShape("7.svg")
loadShape("8.svg")
loadShape("9.svg")
loadShape("0ori.svg")
loadShape("1ori.svg")
loadShape("2ori.svg")
loadShape("3ori.svg")
*/
}
private void addObject(){
  if(findData(editY,editX,editZ)){
  }else{
    for(int i = 0; i< wallHeight;i++){
       if(!findData(editY+i,editX,editZ)){
          levelIndex.add(new int[] {editY+i,editX,editZ});
          levelData.add(new gameObject(editX,editY+i,editZ,selectedBlockID,orientation));
       }
    }
  }
}
public Boolean findData(int a,int b, int c){
  boolean result = false;
  for(int i =0; i < levelIndex.size(); i++){
    if(levelIndex.get(i)[0] == a &&levelIndex.get(i)[1] == b && levelIndex.get(i)[2] == c ){
      result = true;
    }
  }
  return result;
}
private void orientationUI(int x, int y,int scale){
  boolean[] k = {isTouching(x-scale,y-scale*2,x+scale,y-scale),isTouching(x+scale,y-scale,x+scale*2,y+scale),isTouching(x-scale,y+scale,x+scale,y+scale*2),isTouching(x-scale*2,y-scale,x-scale,y+scale)};//top,right,bottom, left
  if(k[0]){
    shape(loadShape("USL.svg"),x-scale,y-scale*2,2*scale,scale);
    checkOrientation(0);
  }else{
    shape(loadShape("UL.svg"),x-scale,y-scale*2,2*scale,scale);
  }
  if(k[1]){
    shape(loadShape("RSL.svg"),x+scale,y-scale,scale,2*scale);
    checkOrientation(1);
  }else{
    shape(loadShape("RL.svg"),x+scale,y-scale,scale,2*scale);
  }
  if(k[2]){
    shape(loadShape("DSL.svg"),x-scale,y+scale,2*scale,scale);
    checkOrientation(2);
  }else{
    shape(loadShape("DL.svg"),x-scale,y+scale,2*scale,scale);
  }
  if(k[3]){
    shape(loadShape("LSL.svg"),x-scale*2,y-scale,scale,2*scale);
    checkOrientation(3);
  }else{
    shape(loadShape("LL.svg"),x-scale*2,y-scale,scale,2*scale);
  }
  shape(loadShape(orientation+"ori.svg"),x-scale,y-scale,scale*2,scale*2);
}
private void checkOrientation(int i){
  if(isClicked == true){
    orientation = i;
  }
}
private int findBlock(int x, int y, int z){//finds the block at x,y,z
  int m = 0;
  if(levelData.size() > 0){
  while( m < levelData.size()-1){
    if(levelData.get(m).editorX == x && levelData.get(m).editorY == y && levelData.get(m).editorZ == z){
      break;
    }else{
      m++;
    }
  }
  }
  return m;
}
private boolean isTouching(int x,int y,int x1, int y1){
  boolean iTouch = false;
  if(mouseX>x && mouseX < x1 && mouseY > y && mouseY<y1){
    iTouch = true;
  }
  return iTouch;
}
public void drawBlocks(){
  int k;
  for(int i = 0; i < levelIndex.size(); i++){
    if(levelIndex.get(i)[0] == editY){
      k = findBlock(levelIndex.get(i)[1],levelIndex.get(i)[0],levelIndex.get(i)[2]);
      fill(0+levelData.get(k).Orientation*50);
      rect(200+levelIndex.get(i)[1]*editorScale, levelIndex.get(i)[2]*editorScale, editorScale, editorScale);
    }
    if(levelIndex.get(i)[0] == editY-1 && !findData(editY,editX,editZ)){
      //show semitransparent image
    }
  }
}