public class AmbientSound extends SoundManager{
private int SoundID;

public AmbientSound(int SoundID){
    this.SoundID = SoundID;
    print(SoundID+".mp3");
    player = getSound("/AMBsound/"+SoundID+".mp3");
    player.shiftGain(-10, 0.7, 6000);
    player.loop();
}
public void fadeout(){
player.shiftGain(0.7,-20, 6000);
}
public void end(){                                                                                                                       
  player.setGain(-100);
}
}


                                                           