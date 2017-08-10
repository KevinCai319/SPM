import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import ddf.minim.analysis.*; 
import ddf.minim.effects.*; 
import ddf.minim.signals.*; 
import ddf.minim.spi.*; 
import javax.swing.ImageIcon; 
import ddf.minim.ugens.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class SPM extends PApplet {









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
float ang = 30;
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
public void setup(){
player = new Player(100,4,2);
IBlock.clear();

minim = new Minim(this);
GameAudio.play("pink floyd","A");
//GameAudio.play("pink floyed","A");
changeAppTitle("SPM//I like potatoes");
titlebaricon = new ImageIcon(loadBytes("favicon.ico"));
eyeX = width/2;

eyeY = height/2- scale*15;

eyeZ = d;
foucusX = player.x;
foucusY = player.y;
foucusZ = player.z;
postfoucusX = player.x;
postfoucusY = player.y;
postfoucusZ = player.z;
}
public void draw(){
frames++;
renderFrame();
rotationTransition();
player.updatePlayer();
}
public void renderFrame(){
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
if(IsLoaded ==false){
}
Renderscene();
endCamera();
player.calculateShift(ang);
}
}
public void load(){
  if(CurrentlyLoading == false){
  CurrentlyLoading = true;
  load.StartLoad(5,5,5);
  frame.setIconImage(titlebaricon.getImage());
  }else{
  load.LoadUpdate();
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
for (int i = 0; i < IBlock.size() ; i++){
IBlock.get(i).render(scale);
}
player.mCube.render(scale/2);
}
public AudioPlayer getSound(String m){
  audio = minim.loadFile(m);
  return audio;
}
public void lol (int levelID){
    String[]Levelreader = loadStrings(levelID +"LDATA"+".txt");
    for (int i = 0; i < Levelreader.length ; i++ ){
    
    }
  }
public void rotationTransition(){
if(IsRotating == true && Keyspace == true){
ang+=1;
}else{
IsRotating = false;
RotationState %= 4;
}
 UpdateAngle();
}
public void UpdateAngle() {
  if (ang>=360){
    ang=0;
  }
  eyeX = (foucusX)-d*(sin(radians(ang)));
  eyeZ = (foucusZ)+d*cos(radians(ang));
}
public void keyPressed(){
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
public void keyReleased(){
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
public void changeAppTitle(String title) {
  surface.setTitle(title);
}
public class AmbientSound extends SoundManager{
private int SoundID;

public AmbientSound(int SoundID){
    this.SoundID = SoundID;
    print(SoundID+".mp3");
    audio = getSound("/AMBsound/"+SoundID+".mp3");
    audio.shiftGain(-10, 0.7f, 6000);
    audio.loop();
}
public void fadeout(){
audio.shiftGain(0.7f,-20, 6000);
}
public void end(){                                                                                                                       
  audio.setGain(-100);
}
}


                                                           
public class cube{
PImage m;
int x;
int y;
boolean IsRender = true;
boolean IsTint = false;
int ID;
int z;
int dist = scale*2;
public cube(int BlockID,int x, int y, int z){
ID = BlockID;
this.x = x;
this.y = y;
this.z = z;
  textureMode(NORMAL);
m = loadImage("/Textures/"+ ID + ".png");
LoadedBlocks.add(new Integer[]{this.x,this.y,this.z});
int ID = LoadedBlocks.size();
}
public void render(int scale){
  IsTint = false;
   IsRender = false;
    if (GetDistance(PApplet.parseFloat(x),PApplet.parseFloat(z),player.x,player.z,player.x+player.shiftX,player.z+player.shiftZ)< scale*dist){
    IsRender = true;
    }else{
    if(IsRotating){
      IsRender = true;
      IsTint = true;
    }
    }
    
  if (IsRender){
    println(abs((player.slope*x)+z+player.intercept)/player.slope);
 beginShape(QUADS);
 if(IsTint){
 tint(50);
 }else{
   tint(255,255);
 }
  texture(m);
  vertex(-scale+x, -scale+y,  scale+z, 0, 0);
  vertex( scale+x, -scale+y,  scale+z, 1, 0);
  vertex( scale+x,  scale+y,  scale+z, 1, 1);
  vertex(-scale+x,  scale+y,  scale+z, 0, 1);
  vertex( scale+x, -scale+y, -scale+z, 0, 0);
  vertex(-scale+x, -scale+y, -scale+z, 1, 0);
  vertex(-scale+x,  scale+y, -scale+z, 1, 1);
  vertex( scale+x,  scale+y, -scale+z, 0, 1);
  //top face. always show
  /*vertex(-scale+x,  scale+y,  scale+z, 0, 0);
  vertex( scale+x,  scale+y, scale+z, 1, 0);
  vertex( scale+x,  scale+y, -scale+z, 1, 1);
  vertex(-scale+x,  scale+y, -scale+z, 0, 1);*/
  //bottom face. never show
  vertex(-scale+x, -scale+y, -scale+z, 0, 0);
  vertex( scale+x, -scale+y, -scale+z, 1, 0);
  vertex( scale+x, -scale+y,  scale+z, 1, 1);
  vertex(-scale+x, -scale+y,  scale+z, 0, 1);
  vertex( scale+x, -scale+y,  scale+z, 0, 0);
  vertex( scale+x, -scale+y, -scale+z, 1, 0);
  vertex( scale+x,  scale+y, -scale+z, 1, 1);
  vertex( scale+x,  scale+y,  scale+z, 0, 1);
  vertex(-scale+x, -scale+y, -scale+z, 0, 0);
  vertex(-scale+x, -scale+y,  scale+z, 1, 0);
  vertex(-scale+x,  scale+y,  scale+z, 1, 1);
  vertex(-scale+x,  scale+y, -scale+z, 0, 1);
  endShape();
  }
}
public void IsIntersecting(){
  float dist = GetDistance(PApplet.parseFloat(x),PApplet.parseFloat(z),player.x,player.z,player.x+player.shiftX,player.z+player.shiftZ);
  if(dist*dist < scale*scale*2){//lies on the line of intersection
    crossSection();
  }
}
public void crossSection(){
  PShape cubeobj; 
  ArrayList<Float[]> m = new ArrayList<Float[]>();
  PVector a = new PVector(-scale+x, -scale+z);
  PVector b = new PVector( scale+x, -scale+z);
  PVector c = new PVector( scale+x, scale+z);
  PVector d = new PVector(-scale+x, scale+z);
m.add(compareIntersection(a,b,new PVector(player.x+30000*player.shiftX,player.z+30000*player.shiftZ),new PVector(player.x-30000*player.shiftX,player.z-30000*player.shiftZ)));
m.add(compareIntersection(b,c,new PVector(player.x+30000*player.shiftX,player.z+30000*player.shiftZ),new PVector(player.x-30000*player.shiftX,player.z-30000*player.shiftZ)));
m.add(compareIntersection(c,d,new PVector(player.x+30000*player.shiftX,player.z+30000*player.shiftZ),new PVector(player.x-30000*player.shiftX,player.z-30000*player.shiftZ)));
m.add(compareIntersection(d,a,new PVector(player.x+30000*player.shiftX,player.z+30000*player.shiftZ),new PVector(player.x-30000*player.shiftX,player.z-30000*player.shiftZ)));
cubeobj = createShape();
cubeobj.beginShape(); 
for(int i = 0; i < m.size(); i++){
if(m.get(i).length > 1){
cubeobj.vertex(m.get(i)[1],m.get(i)[2]);
}
}
}
public Float[] compareIntersection(PVector A, PVector B,PVector C,PVector D){
 int IntersectingState = 0; //no collison
PVector E = new PVector (B.x-A.x,B.y-A.y);
PVector F = new PVector (D.x-C.x, D.y-C.y);
PVector P  = new PVector( -E.y, E.x );
PVector M = new PVector(A.x-C.x,A.y-C.y);
if(F.x*P.x+F.y*P.y == 0){
IntersectingState = 1; //parralllel
return new Float[] {PApplet.parseFloat(IntersectingState)};
}else{
float h = ( M.x*P.x+M.y*P.y ) / (F.x*P.x+F.y*P.y);
if(h >0.05f && h < 0.95f){
 IntersectingState = 2;
}
return new Float[] {PApplet.parseFloat(IntersectingState),C.x+F.x*h,C.y+F.y*h};
}
}
public float GetDistance(float x, float y, float x1, float y1, float x2, float y2) {
    float A = x - x1;
    float B = y - y1;
    float C = x2 - x1;
    float D = y2 - y1;
    float E = -D;
    float F = C;
    float dot = A * E + B * F;
    float len_sq = E * E + F * F;
    return dot* dot/ len_sq;
  }
}
public class DamageBlock extends cube{

public DamageBlock(int TextureID, int x, int y, int z){
super(TextureID,x,y,z);
}
public void DamagePlayer(int m){
}

}
public class levelLoader{
int x;
int y;
int z;
float progress;
int cx,cy,cz = 0;
public levelLoader(){

}
public void StartLoad(int x, int y, int z){
this.x = x;
this.y = y;
this.z = z;
cz = -x;
cx = -x;
}
public void LoadUpdate(){

if(cx>= x && cz <= x){
cz++;
cx = -x;
}else{
cx++;
}
println(cz);
if(cz<= x || cx<=x){
IBlock.add(new cube(0,(width/2)+scale*2*cx,(height/2),scale*cz*2));
}
if(cx> x && cz > x){
IsLoaded = true;
CurrentlyLoading =false;
}

}
public void RenderLoadBar(){
progress = (cx*cz)/(4*x*z);

}

}
public class Player{
public int health;
public int speed;
public float FXvel;
public float Yvel;
public float shiftZ;
public float shiftX;
private float x,y,z;
public boolean isJumping = false;
public float Damage;
private cube mCube;
boolean IsPerpendicular = false;
float slope;
float intercept;
public Player(int health,int speed, float Damage){
  this.health = health;
  this.speed = speed;
  this.Damage = Damage;
  isJumping = false;
  x = width/2;
  y = height/2- scale*3/2;
  z = 0;
  mCube = new cube(0,PApplet.parseInt(x),PApplet.parseInt(y),PApplet.parseInt(z));
  shiftX = 1;
}
public void RenderPlayer(){

}
public float getX(){
return x;
}
public float getY(){
return y;
}
public float getZ(){
return z;
}
public void calculateShift(float ang){
shiftZ = sin(radians(ang));
shiftX = cos(radians(ang));
 player.genEquation();
}
public void genEquation(){
if (abs(shiftX) > 0.001f){
  IsPerpendicular = false;
slope = shiftZ/shiftX;
}else{
IsPerpendicular = true;
slope = 0;
}
intercept = z-x*slope;
}
public void updatePlayer(){
  if(IsRotating == false){
  /*if(KeyUp && isJumping == false){           
    Yvel = -200;
    /*if(Yvel > 0){
      Yvel *= -0.8333333;
    }else{
      Yvel *= 1.2;
    }*/
  /*  isJumping = true;
  }
  Yvel *= 0.8;
  if (abs(Yvel) < 0.05){
    Yvel = 0;
  }
  if(abs(Yvel) > 8){
    if(Yvel > 7){
      Yvel = 8;
    }else{
      Yvel = -8;
    }
  }*/
  if(KeyLeft){
    FXvel -= 0.07f;
    if(FXvel > 0){
      FXvel *= -0.8f;
    }else{
      FXvel *= 1.2f;
    }
  }
  if(KeyRight){
    FXvel += 0.07f;
    if(FXvel > 0){
      FXvel *= 1.2f;
    }else{
      FXvel *= -0.8f;
    }
  }
  FXvel *= 0.95f;
  if (abs(FXvel) < 0.01f){
    FXvel = 0;
  }
  if(abs(FXvel) > 5){
    if(FXvel > 0){
      FXvel =5;
    }else{
      FXvel = -5;
    }
  }    
  y+=Yvel;
  
  x+=shiftX*FXvel;
  z+=shiftZ*FXvel;
  mCube.x = PApplet.parseInt(x);
  mCube.y = PApplet.parseInt(y);
  mCube.z = PApplet.parseInt(z);
  }else{
  FXvel = 0;
  }
}


}
public class SolidBlock extends cube{

public SolidBlock(int TextureID,int x, int y, int z){
super(TextureID,x,y,z);
}


}



public class SoundManager{
 ArrayList<String> AMBsounds = new ArrayList<String>();
 // etc....
 ArrayList<String> sfx = new ArrayList<String>();
 ArrayList<AmbientSound> ASounds = new ArrayList<AmbientSound>();
ArrayList<Soundfx> ESounds = new ArrayList<Soundfx>();
  public SoundManager(){
     AMBsounds.add("pink floyd");
     AMBsounds.add("pink floyed");
  }
  
  
public void play(String sound,String type){
  
  String readString = "";
  ArrayList<String> m;
  int i;
  int index = 0;
  m = (type == "A") ? AMBsounds : sfx ;

  for (i =0; i < m.size(); i++){ 
    if(m.get(i) == sound){
      readString = m.get(i);
      index = i;
    }
  }
  if(type == "A"){
    AmbientSound sounda = new AmbientSound(index);
    ASounds.add(sounda);
  }else{ 
    Soundfx soundeffect = new Soundfx(index);
    ESounds.add(soundeffect);
  }
}




}

public class Soundfx extends SoundManager{
private int SoundID;

public Soundfx(int SoundID){
    this.SoundID = SoundID;
    print(SoundID+".mp3");
    audio = getSound("/sfx/"+SoundID+".mp3");
    audio.setGain(80);
    audio.play();
    end();
}
public void end(){                                                                                                                       
  audio.setGain(-100);
}
}
public class flatObj{
PShape m;
float FxT;
float yT;
float FxB;
float yB;
public flatObj(float fx, float y, float fb, float yb){
  
}
}
  public void settings() { 
size(1200, 900, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "SPM" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
