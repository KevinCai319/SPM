public class gameObject{
  int isSolid = 0;// 0 = false, 1 = true;
  Integer Orientation = 0; // 0 -> N (+Z) 1 -> E (+X) 2 -> S (-Z) 3 -> W (-X)
  //Integer[] images = new Integer[6];
  private int x;
  private int y;
  private int z;
  int ID = 0;//0 for default
  int editorX;
  int editorY;
  int editorZ;
  int isDamage = 0; // 0 = false, 1 = true;
  int damageDealt = 100;
  public gameObject(int editorX,int editorY,int editorZ,int ID,int Orientation,int isDamage,int damageDealt){
  }
  public gameObject(int editorX,int editorY,int editorZ,int ID,int Orientation){
    this.editorX = editorX;
    this.editorY = editorY;
    this.editorZ = editorZ;
    this.Orientation = Orientation;
  }
  private void calculateRealCoords(){
  }
  public void move(int x,int y,int z){
  }
  
}