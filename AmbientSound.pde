public class AmbientSound extends SoundManager{
private int SoundID;
Minim minim;
AudioPlayer player;

public AmbientSound(int SoundID){
    this.SoundID = SoundID;
    player = minim.loadFile("AMBsound/"+SoundID+".mp3");
    player.shiftGain(-50,0, 2000);
    player.loop();
}
public void stop(){                                                                                                                       
  player.shiftGain(0, -50, 2000); 
  player.pause();
}
}
                                                           