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
public void setup(){
player = new Player(100,4,2);
IBlock.clear();

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
int BID;
int z;
int dist = scale*2;
public cube(int BlockID,int x, int y, int z){
ID = BlockID;
this.x = x;
this.y = y;
this.z = z;
m = loadImage("/Textures/"+ ID + ".PNG");
LoadedBlocks.add(new Integer[]{this.x,this.y,this.z});
BID = LoadedBlocks.size();
}
public void render(int scale){
  IsTint = false;
   IsRender = false;
    if (GetDistance(PApplet.parseFloat(x),PApplet.parseFloat(z),player.x,player.z,player.x+player.shiftX,player.z+player.shiftZ)< scale*dist &&GetDist(x,z,player.x,player.z)<scale*dist){
    IsRender = true;
    }else{
    if(IsRotating&& GetDist(x,z,player.x,player.z)<scale*50){
      IsRender = true;
      IsTint = true;
    }
    }
    
  if (IsRender){
  IsIntersecting();
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
  //bottom face. never show/*
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
  if(BID != 1){
  if(GetDistance(PApplet.parseFloat(x),PApplet.parseFloat(z),player.x,player.z,player.x+player.shiftX,player.z+player.shiftZ)< scale*dist &&GetDist(x,z,player.x,player.z)<scale*dist){//lies on the line of intersection
    crossSection();
  }
  }
}
public void crossSection(){
  PShape cubeobj;
  int k =0;
  Float[] tmp;
  ArrayList<Float[]> m = new ArrayList<Float[]>();
   ArrayList<Float> j = new ArrayList<Float>();
  PVector a = new PVector(-scale+x, -scale+z);
  PVector b = new PVector( scale+x, -scale+z);
  PVector c = new PVector( scale+x, scale+z);
  PVector d = new PVector(-scale+x, scale+z);
  PVector[] vectors = new PVector[] {a,b,c,d};
for(int i = 0; i <vectors.length-1 ; i++){
if(compareIntersection(vectors[i],vectors[i+1]).length > 2 && m.size() < 3) {
  if(compareIntersection(vectors[i],vectors[i+1]).length > 3){
    m.add(new Float[]{compareIntersection(vectors[i],vectors[i+1])[1],compareIntersection(vectors[i],vectors[i+1])[2]});
    m.add(new Float[]{compareIntersection(vectors[i],vectors[i+1])[3],compareIntersection(vectors[i],vectors[i+1])[4]});
  }else{
m.add(compareIntersection(vectors[i],vectors[i+1]));
  }
}
}
if(m.size() > 1){
cubeobj = createShape();
cubeobj.beginShape(); 
cubeobj.vertex(m.get(0)[1],y+scale,m.get(0)[2]);
cubeobj.vertex(m.get(1)[1],y+scale,m.get(1)[2]);
cubeobj.vertex(m.get(0)[1],y-scale,m.get(0)[2]);
cubeobj.vertex(m.get(1)[1],y-scale,m.get(1)[2]);
j.add(m.get(0)[1]);
j.add(m.get(1)[2]);
cubeobj.endShape();
println(j.get(0)+"/"+j.get(1)+"/"+BID+"/" +  player.x + "/" +player.z);
}
if( k > 1){
 /* println(player.shiftX + "/" +player.shiftZ + "/" + k);
  if(player.shiftZ == 0){
  C2Dplane.add(new flatObj((j.get(0)-player.x)/player.shiftX,float(-scale+y),(j.get(3)-player.x),scale+y,cubeobj));
  }else{
   if(player.shiftX == 0){
   C2Dplane.add(new flatObj((j.get(0)-player.x),float(-scale+y),(j.get(1)-player.z)/player.shiftZ,scale+y,cubeobj));
   }else{
     C2Dplane.add(new flatObj((j.get(0)-player.x)/player.shiftX,float(-scale+y),(j.get(1)-player.z)/player.shiftZ,scale+y,cubeobj));
   }
  }*/
}
}
public Float[] compareIntersection(PVector A, PVector B){
  float eq = 0;
  float jx=0;
  float jz=0;
  float px = 0;
  float pz=0;
  boolean IsIntersecting = false;
  Float[] res = new Float[] {0.0f};
  float IntersectionState = 0;
  if(A.y == B.y &&B.y == player.z){
    jx = A.y;
    jz = A.x;
    px = B.x;
    pz = B.y;
   IntersectionState =2;
   IsIntersecting = true;
  }else{
  if(A.x == B.x &&B.x == player.x){
    jx = A.x;
    jz = A.y;
    px = B.x;
    pz = B.y;
   IntersectionState =3;
   IsIntersecting = true;
  }else{
    if(player.shiftX == 0){
      IntersectionState = 4;
      if(player.x > min(A.x,B.x)&& player.x < max(A.x,B.x)){
        jx = player.x;
        jz = A.y;
        IsIntersecting = true;
      }
    }else{
        if(player.shiftZ == 0){
        if(player.z > min(A.y,B.y)&& player.z < max(A.y,B.y)){
          jx = A.x;
          jz = player.z;
          IsIntersecting = true;
        }
        }else{
           if(A.x == B.x){
             if(A.x*player.slope+player.intercept >min(A.y,B.y) &&A.x*player.slope+player.intercept <max(A.y,B.y) ){
               jx = A.x;
               jz = A.x*player.slope+player.intercept;
               IsIntersecting = true;
             }
           }else{
             if((A.y-player.intercept)/player.slope >min(A.x,B.x) &&(A.y-player.intercept)/player.slope <max(A.x,B.x) ){
               jx = (A.y-player.intercept)/player.slope;
               jz = A.y;
               IsIntersecting = true;
             }
           }
        }
    }
    
    }
  }
  
  if(IsIntersecting){
    if(IntersectionState ==  2 || IntersectionState == 3){
      res = new Float[] {IntersectionState,jx,jz,px,pz};
    }else{
    res = new Float[] {IntersectionState,jx,jz};
    }
  }
  return res;
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
public float GetDist(float x, float y, float x1,float y1){
  return sqrt((x-x1)*(x-x1)+(y-y1)*(y-y1));
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
//println(cx);
if(cz<= x || cx<=x){
  if (cz > 2){
IBlock.add(new cube(1,(width/2)+scale*2*cx,(height/2),scale*cz*2));
IBlock.add(new cube(1,(width/2)+scale*2*cx,(height/2)-scale*2,scale*cz*2));
IBlock.add(new cube(1,(width/2)+scale*2*cx,(height/2)-scale*4,scale*cz*2));
  }else{
    if (cx > 2){
  IBlock.add(new cube(2,(width/2)+scale*2*cx,(height/2),scale*cz*2));
  IBlock.add(new cube(2,(width/2)+scale*2*cx,(height/2)-scale*2,scale*cz*2));
    }else{
      IBlock.add(new cube(5,(width/2)+scale*2*cx,(height/2),scale*cz*2));
    }
  }
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
public float FXpos;
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
  if (KeyUp){
  }
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
  FXpos+=FXvel;
  mCube.x = PApplet.parseInt(x);
  mCube.y = PApplet.parseInt(y);
  mCube.z = PApplet.parseInt(z);
  }else{
  FXvel = 0;
  FXpos = 0;
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
public flatObj(float fx, float y, float fb, float yb,PShape m){
  println(fx+"/" + y + "/" + fb + "/" + yb);
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
