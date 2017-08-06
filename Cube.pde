public class cube{
PImage m;
int x;
int y;
int ID;
int z;
public cube(int BlockID,int x, int y, int z){
ID = BlockID;
this.x = x;
this.y = y;
this.z = z;
}
public void LoadTextures(){
PImage m = loadImage("/blocks"+"/"+ ID + ".jpg");
}
public void render(int x, int y, int z, int scale){
 beginShape(QUADS);
  texture(m);
  vertex(-scale+x, -scale+y,  scale+z, 0, 0);
  vertex( scale+x, -scale+y,  scale+z, 1, 0);
  vertex( scale+x,  scale+y,  scale+z, 1, 1);
  vertex(-scale+x,  scale+y,  scale+z, 0, 1);


  vertex( scale+x, -scale+y, -scale+z, 0, 0);
  vertex(-scale+x, -scale+y, -scale+z, 1, 0);
  vertex(-scale+x,  scale+y, -scale+z, 1, 1);
  vertex( scale+x,  scale+y, -scale+z, 0, 1);


  vertex(-scale+x,  scale+y,  scale+z, 0, 0);
  vertex( scale+x,  scale+y, scale+z, 1, 0);
  vertex( scale+x,  scale+y, -scale+z, 1, 1);
  vertex(-scale+x,  scale+y, -scale+z, 0, 1);

  vertex(-scale+x, -scale+y, -scale+z, 0, 0);
  vertex( scale+x, -scale+y, -scale+z, 1, 0);
  vertex( scale+x, -scale+y,  scale+z, 1, 1);
  vertex(-scale+x, -scale+y,  scale+z, 0, 1);

  vertex( scale+x, -scale+y,  scale+z, 0, 0);
  vertex( scale+x, -scale+y, -scale+z, 1, 0);
  vertex( scale+x,  scale+y, -scale+z, 1, 1);
  vertex( scale+x,  scale+y,  scale+z, 0, 1);

  vertex(-scale+x, -scale+y, -scale+z, 0, 0);
  vertex(-scale+x, -scale+y,  scale+z, 1, 0);
  vertex(-scale+x,  scale+y,  scale+z, 1, 1);
  vertex(-scale+x,  scale+y, -scale+z, 0, 1);

  endShape();
}

}