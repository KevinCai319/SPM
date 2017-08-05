<<<<<<< HEAD:Soundfx.pde
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


                                                           
=======
public class Soundfx extends SoundManager{
private int SoundID;

public Soundfx(int SoundID){
    this.SoundID = SoundID;
    //player = minim.loadFile("soundfx/"+SoundID+".mp3");
    //player.play();
}
public void stop(){
  //player.pause();
}
}
>>>>>>> cfa745c5e63e35dfc2673f1bfc30bdd0a364a7f0:SPM/Soundfx.pde
