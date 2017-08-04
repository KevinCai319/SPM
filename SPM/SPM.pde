
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
void setup(){
size(1200, 900, P3D);
minim = new Minim(this);
GameAudio.play("pink floyd","A");
GameAudio.play("pink floyed","A");
}
void draw(){
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