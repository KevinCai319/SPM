public class Cutscene{
  public int cutsceneID;
  public float timeLeft;
  private float Duration;
  private int frames;
  ArrayList<PImage> images = new ArrayList<PImage>();
  public Cutscene(int ID,float Duration){
    images.add(loadImage("/Cutscenes/"+ ID + "/.PNG"));
  }
  public void RenderImg(int index){
  
  }
}