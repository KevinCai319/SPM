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
void setup(){
size(1200, 900, P3D);
}
void draw(){
}
public void LoadLevel(int levelID){
  String[]Levelreader = loadStrings(levelID +"LDATA"+".txt");
  for (int i = 0; i < Levelreader.length ; i++ ){
  }
}