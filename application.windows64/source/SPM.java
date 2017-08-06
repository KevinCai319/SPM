import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import ddf.minim.analysis.*; 
import ddf.minim.effects.*; 
import ddf.minim.signals.*; 
import ddf.minim.spi.*; 
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
ArrayList<ArrayList<Integer>>currentLevel = new ArrayList<ArrayList<Integer>>();
String[] Levelreader;
Minim minim;
AudioPlayer player;
public void setup(){

minim = new Minim(this);
GameAudio.play("pink floyd","A");
GameAudio.play("pink floyed","A");
}
public void draw(){
}
public AudioPlayer getSound(String m){
  player = minim.loadFile(m);
  return player;
}
public void lol (int levelID){
    String[]Levelreader = loadStrings(levelID +"LDATA"+".txt");
    for (int i = 0; i < Levelreader.length ; i++ ){
    
    }
  }
public class AmbientSound extends SoundManager{
private int SoundID;

public AmbientSound(int SoundID){
    this.SoundID = SoundID;
    print(SoundID+".mp3");
    player = getSound("/AMBsound/"+SoundID+".mp3");
    player.shiftGain(-10, 0.7f, 6000);
    player.loop();
}
public void fadeout(){
player.shiftGain(0.7f,-20, 6000);
}
public void end(){                                                                                                                       
  player.setGain(-100);
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
}
public void LoadTextures(){
PImage m = loadImage("/blocks"+"/"+ ID + ".jpg");
}
public void render(int x, int y, int z, int scale){
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


  vertex(-scale+x,  scale+y,  scale+z, 0, 0);
  vertex( scale+x,  scale+y, scale+z, 1, 0);
  vertex( scale+x,  scale+y, -scale+z, 1, 1);
  vertex(-scale+x,  scale+y, -scale+z, 0, 1);

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
public class DamageBlock extends cube{

public DamageBlock(int TextureID, int x, int y, int z){
super(TextureID,x,y,z);
super.LoadTextures();
}
public void DamagePlayer(int m){
}

}
public class Player{
public int health;
public int speed;
public float Xvel;
public float Yvel;
public float Zvel;
public float Damage;
public Player(int health,int speed, float Damage){
}


}
public class SolidBlock extends cube{

public SolidBlock(int TextureID,int x, int y, int z){
super(TextureID,x,y,z);
super.LoadTextures();
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
    player = getSound("/sfx/"+SoundID+".mp3");
    player.setGain(80);
    player.play();
    end();
}
public void end(){                                                                                                                       
  player.setGain(-100);
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
