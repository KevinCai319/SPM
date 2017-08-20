public class Cutscene{
  public int cutsceneID;
  public float timeLeft;
  private float Duration;
  private String[] k;
  private int Cframes = 0;
  private int Cimage = 0;
  private int StartingFrame = 0;
  private ArrayList<Integer> xcoords = new ArrayList<Integer>();
  private ArrayList<Integer> ycoords = new ArrayList<Integer>();
  private ArrayList<Integer> time = new ArrayList<Integer>();
  ArrayList<PImage> images = new ArrayList<PImage>();
  ArrayList<PImage> loadedImages = new ArrayList<PImage>();
  public Cutscene(int ID,float Duration){
      cutsceneID = ID;
    this.Duration = Duration;
    k = loadStrings("/Cutscenes/"+ ID + "/data.txt");
    loadData(k);
    StartingFrame = frames;
  }
  public void checkUpdate(){
    if(Cimage <= xcoords.size()){
      if(frames-Cframes >= time.get(Cimage)*Duration){
        Cframes = frames;
        Cimage++;
      }
      if(Cimage <= xcoords.size() && !loadedImages.contains(images.get(Cimage))){
      loadedImages.add(images.get(Cimage));
      }
      for(int i = 0 ; i <= loadedImages.size(); i++){
        RenderImg(xcoords.get(i), ycoords.get(i),((frames-Cframes)-SumBefore(i))/255,loadedImages.get(i));
      }
      
    }
      
  }
  public int SumBefore(int i){
    int sum = 0;
  for(int k = 0; k <= i; k++){
    sum += time.get(k);
  }
  return sum;
  }
  public void loadData(String[] m){
    int i = 0;
    for(i = 0; i< m.length;i++){
      switch(i%4){
        case 0:images.add(loadImage("/Cutscenes/"+ cutsceneID + "/"+k[i]+".png"));
        case 1:xcoords.add(Integer.parseInt(k[i]));
        case 2:ycoords.add(Integer.parseInt(k[i]));
        case 3:time.add(Integer.parseInt(k[i]));
        default:break;
      }
    }
  }
  public void RenderImg(float x, float y,float transparency,PImage image){
  
  }
}