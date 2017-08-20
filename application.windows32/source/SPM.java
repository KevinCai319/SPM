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
  boolean KeyQ = false;
  boolean KeyE = false;
  
boolean isCutscene = false;
ArrayList<ArrayList<Integer>>currentLevel = new ArrayList<ArrayList<Integer>>();
ArrayList<cube>IBlock = new ArrayList<cube>();
ArrayList<flatObj> C2Dplane = new ArrayList<flatObj>();
String[] Levelreader;
Minim minim;
AudioPlayer audio;
float ang = 0;
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
GameAudio.play("credits","A");
changeAppTitle("SPM");
titlebaricon = new ImageIcon(loadBytes("favicon.ico"));
eyeX = width/2;
textureMode(NORMAL);
eyeY = height/2- scale*15;
player.generateHitbox();
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
C2Dplane.clear();
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
  for(int i = 0; i < 100 && IsLoaded == false; i++){
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
for (int i = 0; i < IBlock.size() ; i++){
IBlock.get(i).render(scale);
}
//println(player.x);
player.mCube.Prender(player.pwidth);
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
if(IsRotating == true){
  if(KeyE){
ang++;
  }
    if(KeyQ){
ang--;
  }
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
    if (key == 'a')
    {
      KeyLeft = true;
    }
    if(key == 'd')
    {
      KeyRight = true; 
    }
    if (key == 'w')
    {
      KeyUp = true;
    }
    if(key == 's')
    {
      KeyDown = true;
    }
    
  if (keyCode == ' ' && IsRotating == false){
    Keyspace = true;
  }
    if (key == 'e'){
    KeyE = true;
    IsRotating = true;
  }
    if (key == 'q'){
    KeyQ = true;
    IsRotating = true;
  }
}
public void keyReleased(){
    if (key == 'a')
    {
      KeyLeft = false;
    }
    if(key == 'd')
    {
      KeyRight = false; 
    }
    if (key == 'w')
    {
      KeyUp = false;
    }
    if(key == 's')
    {
      KeyDown = false;
    }
    
  if (key == 'e'){
    KeyE = false;
    if(!KeyQ){
    IsRotating = false;
    }
  }
    if (key == 'q'){
    KeyQ = false;
    if(!KeyE){
    IsRotating = false;
    }
  }
 if (keyCode == ' ' && IsRotating == false){
    Keyspace = false;
  }
}
public void changeAppTitle(String title) {
  surface.setTitle(title);
}
public class AABBHitbox{
public PVector center;
public float halfY;
public float halfX;
public AABBHitbox(float HalfX,float HalfY,PVector center){
  this.center = center;
  this.halfX = HalfX;
  this.halfY = HalfY;
}
public boolean IsColliding(AABBHitbox tile){
  if ( abs(center.x - tile.center.x) > halfX + tile.halfX ){
    return false;
  }
  if ( abs(center.y - tile.center.y) > halfY + tile.halfY ){
    return false;
  }
  return true;
}

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
float mx = 0;
float mz = 0;
float tx = 0;
float tz = 0;
int TintVal = 255;
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
if(ID != 0){
m = loadImage("/Textures/"+ ID + ".PNG");
}else{
  m = loadImage("/Textures/"+ ID + ".png");
}
LoadedBlocks.add(new Integer[]{this.x,this.y,this.z});
BID = LoadedBlocks.size();
}
public void Prender(int pwidth){
  beginShape(QUADS);
  texture(m);
    vertex(player.x+player.shiftX*pwidth, player.y+player.pheight, player.z+player.shiftZ*20, 0, 1);
  vertex(player.x+player.shiftX*pwidth, player.y-player.pheight,  player.z+player.shiftZ*20, 0, 0);
  vertex(player.x-player.shiftX*pwidth,  player.y-player.pheight, player.z-player.shiftZ*20, 1, 0);
  vertex(player.x-player.shiftX*pwidth,  player.y+player.pheight,  player.z-player.shiftZ*20, 1, 1);
  endShape();
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
    IsRender = true;
  if (IsRender){
  IsIntersecting();
 if(IsTint){
 tint(50);
 }else{
   tint(255,255);
 }
 if(IsRotating || !IsRotating && !IsTint){ 
 beginShape(QUADS);
  texture(m);
  vertex(-scale+x, -scale+y,  scale+z, 0, 0);
  vertex( scale+x, -scale+y,  scale+z, 1, 0);
  vertex( scale+x,  scale+y,  scale+z, 1, 1);
  vertex(-scale+x,  scale+y,  scale+z, 0, 1);
  vertex( scale+x, -scale+y, -scale+z, 0, 0);
  vertex(-scale+x, -scale+y, -scale+z, 1, 0);
  vertex(-scale+x,  scale+y, -scale+z, 1, 1);
  vertex( scale+x,  scale+y, -scale+z, 0, 1);
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
}
public void IsIntersecting(){
  if(BID != 1){
  if(GetDistance(PApplet.parseFloat(x),PApplet.parseFloat(z),player.x,player.z,player.x+player.shiftX,player.z+player.shiftZ)< scale*dist &&GetDist(x,z,player.x,player.z)<scale*dist*2){//lies on the line of intersection
    crossSection();
  }
  }
}
public void crossSection(){
  ArrayList<Float[]> ml = new ArrayList<Float[]>();
   ArrayList<Float> j = new ArrayList<Float>();
  PVector a = new PVector(-scale+x, -scale+z);
  PVector b = new PVector( scale+x, -scale+z);
  PVector c = new PVector( scale+x, scale+z);
  PVector d = new PVector(-scale+x, scale+z);
  PVector[] vectors = new PVector[] {a,b,c,d};
for(int i = 0; i <vectors.length ; i++){
if(compareIntersection(vectors[i%vectors.length],vectors[(i+1)%vectors.length]).length > 1 && ml.size() < 2) {
  if(compareIntersection(vectors[i%vectors.length],vectors[(i+1)%vectors.length]).length > 3){
    ml.add(new Float[]{0.0f,compareIntersection(vectors[i%vectors.length],vectors[(i+1)%vectors.length])[1],compareIntersection(vectors[i%vectors.length],vectors[(i+1)%vectors.length])[2]});
    ml.add(new Float[]{0.0f,compareIntersection(vectors[i%vectors.length],vectors[(i+1)%vectors.length])[3],compareIntersection(vectors[i%vectors.length],vectors[(i+1)%vectors.length])[4]});
}else{
    ml.add(compareIntersection(vectors[i%vectors.length],vectors[(i+1)%vectors.length]));
  }
}
}
if(ml.size() > 1){
j.add(ml.get(0)[1]);
j.add(ml.get(1)[2]);
mx = ml.get(0)[1];
mz = ml.get(0)[2];
tx = ml.get(1)[1];
tz = ml.get(1)[2];
IsTint = false;
beginShape(QUADS); 
texture(m);
vertex(ml.get(0)[1],y+scale,ml.get(0)[2],0,0);
vertex(ml.get(0)[1],y-scale,ml.get(0)[2],0,1);
vertex(ml.get(1)[1],y-scale,ml.get(1)[2],1,1);
vertex(ml.get(1)[1],y+scale,ml.get(1)[2],1,0);
endShape();
    if( GetDist(mx,mz,player.x,player.z) < GetDist(mx,mz,player.x+player.shiftX,player.z+player.shiftZ)){
      mx = -GetDist(mx,mz,player.x,player.z);
    }else{
      mx = GetDist(mx,mz,player.x,player.z);
    }
    if( GetDist(tx,tz,player.x,player.z) < GetDist(tx,tz,player.x+player.shiftX,player.z+player.shiftZ)){
      tx = -GetDist(tx,tz,player.x,player.z);
    }else{
      tx = GetDist(tx,tz,player.x,player.z);
    }
    C2Dplane.add( new flatObj(mx, y-scale, tx, y+scale,BID));
}else{
//IsTint = true;
}
}
public Float[] compareIntersection(PVector A, PVector B){
  float jx=0;
  float jz=0;
  float px = 0;
  float pz=0;
  boolean IsIntersecting = false;
  Float[] res = new Float[] {0.0f};
  float IntersectionState = 0;
    if(player.shiftX == 0){
      IntersectionState = 4;
      if(player.x >= min(A.x,B.x)&& player.x <= max(A.x,B.x)){
        jx = player.x;
        jz = z+scale;
        px = player.x;
        pz = z-scale;
        IsIntersecting = true;
      }
    }else{
        if(player.shiftZ == 0){
          IntersectionState = 3;
          if(player.z >= min(A.y,B.y)&& player.z <= max(A.y,B.y)){
            jx = x+scale;
            jz = player.z;
            px = x-scale;
            pz = player.z;
            IsIntersecting = true;
          }
        }else{
           if(A.x == B.x){
             IntersectionState = 1;
              if((A.x*player.slope+player.intercept >min(A.y,B.y) )&&(A.x*player.slope+player.intercept <max(A.y,B.y)) ){
                 jx = A.x;
                 jz = A.x*player.slope+player.intercept;
                 IsIntersecting = true;
              }
           }else{
             IntersectionState = 2;
             if(((A.y-player.intercept)/player.slope >min(A.x,B.x)) &&((A.y-player.intercept)/player.slope <max(A.x,B.x) )){
               jx = (A.y-player.intercept)/player.slope;
               jz = A.y;
               IsIntersecting = true;
             }
           } 
      }
    }
    
  
  if(IsIntersecting){
    if(IntersectionState ==  4 || IntersectionState == 3){
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
public class Cutscene{
  public int cutsceneID;
  public float timeLeft;
  private float Duration;
  private int frames;
  ArrayList<PImage> images = new ArrayList<PImage>();
  public Cutscene(int ID,float Duration){
    
  }
  public void OpenData(int ID){
  }
  public void RenderImg(int index){
  
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
      IBlock.add(new cube(5,(width/2)+scale*2*cx,(height/2)-scale*10,scale*cz*2));
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
public int pwidth = scale;
public int pheight = PApplet.parseInt(scale*1.618f);
public float shiftX;
private float x,y,z;
private boolean isColliding = false;
public boolean isJumping = false;
public ArrayList<AABBHitbox> Intersecting = new ArrayList<AABBHitbox>();
public float Damage;
private cube mCube;
AABBHitbox HitBox;
AABBHitbox Rbox;
AABBHitbox Lbox;
boolean Rint = false;
boolean Lint = false;
boolean IsPerpendicular = false;
float slope;
float intercept;
float ly;
float lx;
public Player(int health,int speed, float Damage){
  this.health = health;
  this.speed = speed;
  this.Damage = Damage;
  isJumping = false;
  x = width/2;
  y = height/2- pheight*1.618f;
  z = 0;
  pwidth = scale;
  height = PApplet.parseInt(scale*1.618f);
  mCube = new cube(0,PApplet.parseInt(x),PApplet.parseInt(y),PApplet.parseInt(z));
  shiftX = 1;
}
public void generateHitbox(){
  HitBox = new AABBHitbox(PApplet.parseFloat(pwidth),PApplet.parseFloat(pheight),new PVector(0,player.y));
  Lbox = new AABBHitbox(2,pheight-7,new PVector(-pwidth,player.y));
  Rbox = new AABBHitbox(2,pheight-7,new PVector(pwidth,player.y));
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
if (abs(shiftX) > 0.0000001f){
  IsPerpendicular = false;
slope = shiftZ/shiftX;
}else{
IsPerpendicular = true;
slope = 0;
}
intercept = z-x*slope;
}
public void CheckCollision(AABBHitbox HitBox){
  Intersecting.clear();
  isColliding = false;
  Rint = false;
  Lint = false;
  for(int i = 0; i < C2Dplane.size();i++){
    if(HitBox.IsColliding(C2Dplane.get(i).k)){
      Intersecting.add(C2Dplane.get(i).k);
      isColliding = true;
    }
    if(Rbox.IsColliding(C2Dplane.get(i).k)){
        Rint = true;
    }
    if(Lbox.IsColliding(C2Dplane.get(i).k)){
        Lint = true;
    }
  }

}
public void respawn(){
    isJumping = false;
  x = width/2;
  y = height/2- pheight*1.618f;
  z = 0;
  Yvel = 0;
}
public void subFX(float l){
    FXpos+=l;
  x +=shiftX*l;
  z +=shiftZ*l;
}
public void updatePlayer(){
  if(abs(shiftX) < 0.0000001f){
shiftX = 0;
}
if(abs(shiftZ) < 0.0000001f){
  shiftZ = 0;
}
  if(IsRotating == false){
    UpdateInputs();
    CheckCollision(HitBox);
  if(Rint&!Lint){
    int i = 0;
    println("k");
    if (FXvel > 0){
    FXvel =0;
    subFX(-5);
    }
  /*while(Rint){
    CheckCollision(HitBox);
    Rbox.center.x--;
    i++;
  }
  FXvel = 0;
   subFX(-i);*/
  }
  if(Lint&!Rint){
    int i = 0;
    println("l");
    if (FXvel < 0){
    FXvel =0;
    subFX(5);
    }
  /*while(Rint){
    CheckCollision(HitBox);
    Rbox.center.x--;
    i++;
  }
  FXvel = 0;
   subFX(-i);*/
  }
  if(isJumping){
    if(Yvel > -5 && Yvel< 0){
      Yvel = 0.2f;
    }
    if (Yvel < 0){
      Yvel*= 0.9f;
     
    }else{
       Yvel*=1.111f;
    }
    CheckCollision(HitBox);
    //println(C2Dplane.size());
    if(isColliding){
      if(Yvel >= 0.3f){
    isJumping = false;
    int i =0;
    while(isColliding){
      CheckCollision(new AABBHitbox(pwidth,pheight,new PVector(0,HitBox.center.y+i)));
      i--;
    }
    y += i+1;
    Yvel = 0;
      }else{
        if(!( Yvel< -15) ){
        println(Yvel);
      int i = 0;
          while(isColliding){
            CheckCollision(new AABBHitbox(pwidth,pheight,new PVector(0,HitBox.center.y+i)));
            i++;
          }
          if(y+i < ly){
          y = y+i;
          }
      //Yvel =  -0.2;
      }
    }

    }
  }else{
   if(!isColliding){
     if(Yvel <= 0){
      Yvel = 1;
     }else{
       Yvel *= 1.05f;
     }
    }else{
      Yvel = 0;
    }
  }
  }else{
  FXvel = 0;
  FXpos = 0;
  }
}
public void UpdateInputs(){
  if (KeyUp&&isJumping == false && isColliding){
    isJumping = true;
    ly = y;
    lx = FXpos;
    Yvel = -scale;
  }
  if(KeyLeft&&!Lint){
    FXvel -= 0.07f;
    if(FXvel > 0){
      FXvel *= -0.8f;
    }else{
      FXvel *= 1.2f;
    }
  }
  if(KeyRight && !Rint){
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
  Lbox.center.y = y;
  Rbox.center.y = y;
  HitBox.center.y = y;
  if(y > 1000){
  respawn();
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
     AMBsounds.add("credits");
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
float FxT;
float yT;
float FxB;
int Id;
float yB;
AABBHitbox k;
public flatObj(float fx, float y, float fb, float yb,int BID){
  Id = BID;
  k = new AABBHitbox(abs(fx-fb)/2,abs(y-yb)/2,new PVector((fx+fb)/2,(y+yb)/2));
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
