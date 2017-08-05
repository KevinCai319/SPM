
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
    String Reader = "";
    Boolean IsSolid;//[
    Boolean IsDamage;//*
    Boolean IsWall;//~
    Boolean IsEnemy;//?
    Boolean IsMoving;//=
    Boolean hasTexture;//:
    int texture;
    Boolean HasProjectiles;//a
    int EnemyType;
    for (int i = 0; i < Levelreader.length ; i++ ){
      if(Levelreader[i] == "/"){
        if(Reader != ""){
        
        
        
        }else{
      
        }
      }else{
      
      
      
      }
    }
  }