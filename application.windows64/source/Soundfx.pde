
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