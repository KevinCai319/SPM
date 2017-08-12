
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import javax.swing.ImageIcon;
import ddf.minim.ugens.*;
SoundManager GameAudio = new SoundManager();
public int CameraState;
  boolean KeyUp = false;
  boolean KeyRight = false;       
  boolean KeyLeft = false;
  boolean KeyDown = false;
  boolean Keyspace = false;
ArrayList<ArrayList<Integer>>currentLevel = new ArrayList<ArrayList<Integer>>();
ArrayList<cube>IBlock = new ArrayList<cube>();
ArrayList<flatObj> C2Dplane = new ArrayList<flatObj>();
String[] Levelreader;
Minim minim;
AudioPlayer audio;
float ang = 90;
int frames;
boolean IsLoaded = false;
float eyeX,eyeY,eyeZ;
int RotationState = 0;
int scale = 20;
boolean CurrentlyLoading = false;
float d = 400;
ImageIcon titlebaricon;
boolean IsRotating = false;
ArrayList<Integer[]> LoadedBlocks = new ArrayList<Integer[]>();
float foucusX,foucusY,foucusZ,postfoucusX,postfoucusY,postfoucusZ;
levelLoader load = new levelLoader();
/*PImage icon = loadImage("icon.PNG");
surface.setIcon(icon);*/
Player player;
void setup(){
player = new Player(100,4,2);
IBlock.clear();
size(1200, 900, P3D);
surface.setResizable(true);
minim = new Minim(this);
//GameAudio.play("pink floyd","A");
//GameAudio.play("pink floyed","A");
changeAppTitle("SPM");
titlebaricon = new ImageIcon(loadBytes("favicon.ico"));
eyeX = width/2;
textureMode(NORMAL);
eyeY = height/2- scale*15;

eyeZ = d;
foucusX = player.x;
foucusY = player.y;
foucusZ = player.z;
postfoucusX = player.x;
postfoucusY = player.y;
postfoucusZ = player.z;
}
void draw(){
frames++;
renderFrame();
rotationTransition();
player.updatePlayer();
}
void renderFrame(){
if(IsLoaded == false){
  load();
}else{
beginCamera();
background(0);
noStroke();
lights();
editCam(0);
camera(postfoucusX,postfoucusY,postfoucusZ,foucusX,foucusY,foucusZ,0,1,0);
ortho(-width/4, width/4, -height/4, height/4);
Renderscene();
endCamera();
player.calculateShift(ang);
}
}
public void load(){
  if(CurrentlyLoading == false){
  CurrentlyLoading = true;
  C2Dplane.clear();
  IBlock.clear();
  load.StartLoad(10,10,10);
  frame.setIconImage(titlebaricon.getImage());
  }else{
  for(int i = 0; i < 200 && IsLoaded == false; i++){
    if(!(load.cx > load.x && load.cz > load.x)){
        load.LoadUpdate();
    }
  }
  //println(load.z);
  }
}
public void editCam(float fraction){
 UpdateAngle();
 foucusX = player.getX();
 foucusY = player.getY();
 foucusZ = player.getZ();
 directionalLight(255,255,255,foucusX,foucusY,foucusZ);
  postfoucusX = foucusX*fraction+eyeX*(1-fraction);
 postfoucusY = foucusY*fraction+eyeY*(1-fraction);
 postfoucusZ = foucusZ*fraction+eyeZ*(1-fraction);
 
}
public void Renderscene(){
  C2Dplane.clear();
for (int i = 0; i < IBlock.size() ; i++){
IBlock.get(i).render(scale);
}
//println(player.x);
player.mCube.Prender(player.pheight/2,player.pwidth);
}
public AudioPlayer getSound(String m){
  audio = minim.loadFile(m);
  return audio;
}
void lol (int levelID){
    String[]Levelreader = loadStrings(levelID +"LDATA"+".txt");
    for (int i = 0; i < Levelreader.length ; i++ ){
    
    }
  }
void rotationTransition(){
if(IsRotating == true && Keyspace == true){
ang+=1;
}else{
IsRotating = false;
RotationState %= 4;
}
 UpdateAngle();
}
void UpdateAngle() {
  if (ang>=360){
    ang=0;
  }
  eyeX = (foucusX)-d*(sin(radians(ang)));
  eyeZ = (foucusZ)+d*cos(radians(ang));
}
void keyPressed(){
   if(key == CODED)
  {
    if (keyCode == LEFT)
    {
      KeyLeft = true;
    }
    if(keyCode == RIGHT)
    {
      KeyRight = true; 
    }
    if (keyCode == UP)
    {
      KeyUp = true;
    }
    if(keyCode == DOWN)
    {
      KeyDown = true;
    }
    
  }
  if (keyCode == ' ' && IsRotating == false){
    Keyspace = true;
    IsRotating = true;
    ang+=2;
  }
}
void keyReleased(){
   if(key == CODED)
  {
    if (keyCode == LEFT)
    {
      KeyLeft = false;
    }
    if(keyCode == RIGHT)
    {
      KeyRight = false; 
    }
    if (keyCode == UP)
    {
      KeyUp = false;
    }
    if(keyCode == DOWN)
    {
      KeyDown = false;
    }
    
  }
  if (keyCode == ' '){
    Keyspace = false;
    IsRotating = false;
  }
}
void changeAppTitle(String title) {
  surface.setTitle(title);
}