public class AmbientSound extends SoundManager{
private int SoundID;

public AmbientSound(int SoundID){
    this.SoundID = SoundID;
    print(SoundID+".mp3");
    audio = getSound("/AMBsound/"+SoundID+".mp3");
    audio.shiftGain(-10, 0.7, 6000);
    audio.loop();
}
public void fadeout(){
audio.shiftGain(0.7,-20, 6000);
}
public void end(){                                                                                                                       
  audio.setGain(-100);
}
}


                                                           