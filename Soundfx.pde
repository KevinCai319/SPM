public class Soundfx extends SoundManager{
private int SoundID;
Minim minim;
AudioPlayer player;

public Soundfx(int SoundID){
    this.SoundID = SoundID;
    player = minim.loadFile("soundfx/"+SoundID+".mp3");
    player.play();
}
public void stop(){
  player.pause();
}
}