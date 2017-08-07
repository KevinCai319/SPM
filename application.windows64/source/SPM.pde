
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
SoundManager GameAudio = new SoundManager();
public int CameraState;
ArrayList<ArrayList<Integer>>currentLevel = new ArrayList<ArrayList<Integer>>();
String[] Levelreader;
Minim minim;
AudioPlayer player;
float ang = 0;
int frames;
float eyeX,eyeY,eyeZ;
float d = 400;
int RotationState = 0;
int scale = 40;
boolean IsRotating = false;
void setup(){
size(1200, 900, P3D);
minim = new Minim(this);
//GameAudio.play("pink floyd","A");
//GameAudio.play("pink floyed","A");
eyeX = width/2;

eyeY = height/2; /*- scale*5;*/

eyeZ = d;
}
void draw(){
frames++;
renderFrame();
rotationTransition();

}
void renderFrame(){
beginCamera();
background(0);
lights();
camera(eyeX,eyeY,eyeZ,width/2,height/2,0,0,1,0);
ortho(-width/2, width/2, -height/2, height/2);
cube a = new cube(0,(width/2),(height/2),0);
a.LoadTextures();
a.render(scale);
cube b = new cube(0,(width/2),(height/2)-scale*2,0);
b.LoadTextures();
b.render(scale);
cube c = new cube(0,(width/2)-scale*2,(height/2),0);
c.LoadTextures();
c.render(scale);
cube d = new cube(0,(width/2),(height/2),scale*2);
d.LoadTextures();
d.render(scale);
endCamera();
}
public AudioPlayer getSound(String m){
  player = minim.loadFile(m);
  return player;
}
void lol (int levelID){
    String[]Levelreader = loadStrings(levelID +"LDATA"+".txt");
    for (int i = 0; i < Levelreader.length ; i++ ){
    
    }
  }
void rotationTransition(){
if(IsRotating == true && (!(ang%90 == 0))){
ang+=5;
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
  eyeX = (width/2)-d*(sin(radians(ang)));
  eyeZ = d*cos(radians(ang));
  //println("Angle "+ang+": "+eyeX+" / "+eyeY+" / "+eyeZ);
}
void keyPressed(){
  if (keyCode == UP && IsRotating == false){
    IsRotating = true;
    RotationState++;
    RotationState %= 4;
    ang+=5;
  }
}