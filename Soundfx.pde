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


                                                           