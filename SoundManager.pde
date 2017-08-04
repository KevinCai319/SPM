import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

StringList AMBsounds;
// etc....
StringList sfx;
public class SoundManager{
  public SoundManager(){
     AMBsounds = new StringList();
     sfx = new StringList();
     AMBsounds.append("water");
  }
public void play(String sound,String type){
String readString;
StringList m;
m = (type == "A") ? AMBsounds : sfx ;
for (int i =0; i < m.size(); i++){
  if(m.get(i) == sound){
    readString = m.get(i);
  }
}
}
}