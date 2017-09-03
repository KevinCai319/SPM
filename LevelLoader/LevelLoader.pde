
private boolean isClicked = true;
public final int editorScale = 20;
public boolean inFrame = false;
public int modX;
public int modY;
public int editX;//0-39
public int editY = 0;//0-1000
public int editZ;//0-39
private int selectedBlockID = 0;
private int orientation = 0;
private int wallHeight = 1;
private int snapGrid = 0;
private boolean eraseMode = false;
private ArrayList<PShape> Images = new ArrayList<PShape>();
public ArrayList<gameObject>levelData = new ArrayList<gameObject>();
public ArrayList<int[]>levelIndex = new ArrayList<int[]>();//lists of lists that each contain data for 1 object
PrintWriter output;
void setup(){
  size(1200,800, P2D);//editorScale*40 is side width of level area, which would be a maximum of 40 by 40 lbocks,plus the extra 200px of space on both sides for UI
  surface.setResizable(false);
  output = createWriter("data.txt");
  loadImages();
}
void draw(){
  background(255,255,255);
  drawGrid();
  updateMouse();
  updateAction();
  imageMode(CENTER);
  drawBlocks();
  imageMode(CORNER);
  loadUI();
  renderCursor();
}
void keyPressed(){
  if(key == ' '){
    eraseMode = !eraseMode;
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
  if(key == 'c'){
    snapGrid++;
    snapGrid %= 3;
  }
  if(key ==  'v'){
    if(snapGrid > 0){
      snapGrid--;
    }else{
      snapGrid = 2;
    }
    snapGrid %= 3;
  }
}
void updateAction(){
  if(isClicked && inFrame){
    addObject();
  }
}
void updateMouse(){
   isClicked = mousePressed;
   if(abs(mouseX-600) < 400){
     if(snapGrid!= 2){
       modX = roundTo(mouseX-editorScale/2, editorScale);
     }
     if(snapGrid!= 1){
       modY = roundTo(mouseY-editorScale/2, editorScale);
     }
     inFrame = true;
   }else{
     inFrame = false;
   }
   editX = round((modX-200)/editorScale);
   editZ = round((modY/editorScale));
}
void writeToFile(){
  output.flush();
  output.close();
  exit();
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
    rect(modX+editorScale/4, modY+editorScale/4, editorScale/2, editorScale/2);
  }
}
public int roundTo(int num, int to){
  float m = to/2;
  return round(num+m - (num+m)%to);
}
private void loadUI(){
  shape(Images.get(0),12.5+1000,height/2-130,175,200);
  shape(Images.get(1),12.5,height/2-130,175,200);
  shape(Images.get(2),12.5,height/8*5,175,75);
  shape(Images.get(3),1012.5,height/8*4.75,175,212);
  shape(Images.get(26),1012.5,height/10*8.75,175,100);
  if(snapGrid == 0){
    shape(Images.get(29),1077.5,height/10*8.75+50,45,45);
  }else{
    if(snapGrid == 1){
      shape(Images.get(27),1077.5,height/10*8.75+50,45,45);
    }else{
      shape(Images.get(28),1077.5,height/10*8.75+50,45,45);
    }
  }
  if(eraseMode){
     shape(Images.get(30),1012.5,height/10*1.75,175,100);
  }else{
     shape(Images.get(31),1012.5,height/10*1.75,175,100);
  }
  idPrint(selectedBlockID,0,(height/2)-50,1);
  idPrint(editY,1000,(height/2)-50,1);
  idPrint(wallHeight,1025,int(height/8*4.75)+100,2);
  
  orientationUI(100,height/8*7,50);
}
private void idPrint(int i,int p,int y,int size){
  String m = Integer.toString(i);
  int start = (200/(m.length()+1));
  for (int j = 0; j< m.length();j++){
    if(m.charAt(j) == '1'){
      shape(Images.get(13),start/8+p+(j+0.5)*start,y,start/(2*size),100/size);
    }else{
      shape(Images.get(12+(m.charAt(j)- '0')),p+(j+0.5)*start,y,start/size,100/size);
    }
  }
  
}
private void loadImages(){
//subtract 1
Images.add(loadShape("blockHeight.svg"));//1
Images.add(loadShape("blockID.svg"));//2
Images.add(loadShape("blockOri.svg"));//3
Images.add(loadShape("wallSelect.svg"));//4
Images.add(loadShape("USL.svg"));//5
Images.add(loadShape("UL.svg"));//6
Images.add(loadShape("RL.svg"));//7
Images.add(loadShape("RSL.svg"));//8
Images.add(loadShape("DL.svg"));//9
Images.add(loadShape("DSL.svg"));//10
Images.add(loadShape("LL.svg"));//11
Images.add(loadShape("LSL.svg"));//12
Images.add(loadShape("0.svg"));//13
Images.add(loadShape("1.svg"));//14
Images.add(loadShape("2.svg"));//15
Images.add(loadShape("3.svg"));//16
Images.add(loadShape("4.svg"));//17
Images.add(loadShape("5.svg"));//18
Images.add(loadShape("6.svg"));//19
Images.add(loadShape("7.svg"));//20
Images.add(loadShape("8.svg"));//21
Images.add(loadShape("9.svg"));//22
Images.add(loadShape("0ori.svg"));//23
Images.add(loadShape("1ori.svg"));//24
Images.add(loadShape("2ori.svg"));//25
Images.add(loadShape("3ori.svg"));//26
Images.add(loadShape("snapGridUI.svg"));//27
Images.add(loadShape("snapGridX.svg"));//28
Images.add(loadShape("snapGridY.svg"));//29
Images.add(loadShape("snapGridOFF.svg"));//30
Images.add(loadShape("eraseON.svg"));//31
Images.add(loadShape("eraseOFF.svg"));//32
}
private void addObject(){
  if(eraseMode){
    println("k");
      for(int i = 0; i< wallHeight;i++){
        if(findData(editY+i,editX,editZ)){
          levelData.remove(findBlock(editX,editY+i,editZ));
          levelIndex.remove(findDataIndex(editY+i,editX,editZ));
        }
          levelIndex.add(new int[] {editY+i,editX,editZ});
          levelData.add(new gameObject(editX,editY+i,editZ,selectedBlockID,orientation));
      }
  }else{
    println("t");
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
public int findDataIndex(int a,int b, int c){
  boolean result = false;
  int m =0;
  for(int i =0; i < levelIndex.size(); i++){
    if(levelIndex.get(i)[0] == a &&levelIndex.get(i)[1] == b && levelIndex.get(i)[2] == c ){
      m = i;
    }
  }
  return m;
}
private void orientationUI(int x, int y,int scale){
  boolean[] k = {isTouching(x-scale,y-scale*2,x+scale,y-scale),isTouching(x+scale,y-scale,x+scale*2,y+scale),isTouching(x-scale,y+scale,x+scale,y+scale*2),isTouching(x-scale*2,y-scale,x-scale,y+scale)};//top,right,bottom, left
  if(k[0]){
    shape(Images.get(4),x-scale,y-scale*2,2*scale,scale);
    checkOrientation(0);
  }else{
    shape(Images.get(5),x-scale,y-scale*2,2*scale,scale);
  }
  if(k[1]){
    shape(Images.get(7),x+scale,y-scale,scale,2*scale);
    checkOrientation(1);
  }else{
    shape(Images.get(6),x+scale,y-scale,scale,2*scale);
  }
  if(k[2]){
    shape(Images.get(9),x-scale,y+scale,2*scale,scale);
    checkOrientation(2);
  }else{
    shape(Images.get(8),x-scale,y+scale,2*scale,scale);
  }
  if(k[3]){
    shape(Images.get(11),x-scale*2,y-scale,scale,2*scale);
    checkOrientation(3);
  }else{
    shape(Images.get(10),x-scale*2,y-scale,scale,2*scale);
  }
  shape(Images.get(orientation+22),x-scale,y-scale,scale*2,scale*2);
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