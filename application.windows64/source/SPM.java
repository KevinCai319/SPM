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
ArrayList<ArrayList<Integer>>currentLevel = new ArrayList<ArrayList<Integer>>();
ArrayList<cube>IBlock = new ArrayList<cube>();
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
 println(foucusX);
  postfoucusX = foucusX*fraction+eyeX*(1-fraction);
 postfoucusY = foucusY*fraction+eyeY*(1-fraction);
 postfoucusZ = foucusZ*fraction+eyeZ*(1-fraction);
 
}
public void Renderscene(){
for (int i = 0; i < IBlock.size() ; i++){
IBlock.get(i).render(scale);
}
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
if(IsRotating == true && (!(ang%90 == 0))){
ang+=2;
if (ang%90 == 0){
RotationState++;
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
  eyeZ = d*cos(radians(ang));
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
int ID;
int z;
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
 beginShape(QUADS);
  texture(m);
  if(((RotationState == 0)||(IsRotating == true &&((RotationState == 3)||(RotationState == 4))))){
  vertex(-scale+x, -scale+y,  scale+z, 0, 0);
  vertex( scale+x, -scale+y,  scale+z, 1, 0);
  vertex( scale+x,  scale+y,  scale+z, 1, 1);
  vertex(-scale+x,  scale+y,  scale+z, 0, 1);
  }
  if(((RotationState == 2)||(IsRotating == true &&RotationState == 1))){
  vertex( scale+x, -scale+y, -scale+z, 0, 0);
  vertex(-scale+x, -scale+y, -scale+z, 1, 0);
  vertex(-scale+x,  scale+y, -scale+z, 1, 1);
  vertex( scale+x,  scale+y, -scale+z, 0, 1);
  }
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
  if(((RotationState == 3)||(IsRotating == true &&RotationState == 2))){
  vertex( scale+x, -scale+y,  scale+z, 0, 0);
  vertex( scale+x, -scale+y, -scale+z, 1, 0);
  vertex( scale+x,  scale+y, -scale+z, 1, 1);
  vertex( scale+x,  scale+y,  scale+z, 0, 1);
  }
  if(((RotationState == 1)||(IsRotating == true &&RotationState == 0))){
  vertex(-scale+x, -scale+y, -scale+z, 0, 0);
  vertex(-scale+x, -scale+y,  scale+z, 1, 0);
  vertex(-scale+x,  scale+y,  scale+z, 1, 1);
  vertex(-scale+x,  scale+y, -scale+z, 0, 1);
  }
  endShape();
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
public Player(int health,int speed, float Damage){
  this.health = health;
  this.speed = speed;
  this.Damage = Damage;
  isJumping = false;
  x = width/2;
  y = height/2;
  z = 0;
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
public void calculateShift(int ang){

}
public void updatePlayer(){
  if(KeyUp && isJumping == false){           
    Yvel -= 0.1f;
    if(Yvel > 0){
      Yvel *= -0.8333333f;
    }else{
      Yvel *= 1.2f;
    }
    isJumping = true;
  }
  Yvel *= 0.8f;
  if (abs(Yvel) < 0.05f){
    Yvel = 0;
  }
  if(abs(Yvel) > 8){
    if(Yvel > 7){
      Yvel = 8;
    }else{
      Yvel = -8;
    }
  }
  if(KeyLeft){
    FXvel -= 0.1f;
    if(FXvel > 0){
      FXvel *= -0.8f;
    }else{
      FXvel *= 1.2f;
    }
  }
  if(KeyRight){
    FXvel += 0.1f;
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
  if(abs(FXvel) > 8){
    if(FXvel > 0){
      FXvel =8;
    }else{
      FXvel = -8;
    }
  }    
  y+=Yvel;
  
  x+=shiftX;
  z+=shiftZ;
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
