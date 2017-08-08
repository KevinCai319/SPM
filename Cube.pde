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
  textureMode(NORMAL);
m = loadImage("/Textures/"+ ID + ".png");
LoadedBlocks.add(new Integer[]{this.x,this.y,this.z});
int ID = LoadedBlocks.size();
}
public void render(int scale){
 beginShape(QUADS);
  texture(m);
  if(((RotationState == 0)||(IsRotating == true &&((RotationState == 3)||(RotationState == 4))))){
  vertex(-scale+x, -scale+y,  scale+z, 0, 0);
  vertex( scale+x, -scale+y,  scale+z, 1, 0);
  vertex( scale+x,  scale+y,  scale+z, 1, 1);
  vertex(-scale+x,  scale+y,  scale+z, 0, 1);
  }
  if(((RotationState == 2)||(IsRotating == true &&RotationState == 1))){
  vertex( scale+x, -scale+y, -scale+z, 0, 0);
  vertex(-scale+x, -scale+y, -scale+z, 1, 0);
  vertex(-scale+x,  scale+y, -scale+z, 1, 1);
  vertex( scale+x,  scale+y, -scale+z, 0, 1);
  }
  //top face. always show
  /*vertex(-scale+x,  scale+y,  scale+z, 0, 0);
  vertex( scale+x,  scale+y, scale+z, 1, 0);
  vertex( scale+x,  scale+y, -scale+z, 1, 1);
  vertex(-scale+x,  scale+y, -scale+z, 0, 1);*/
  //bottom face. never show
  vertex(-scale+x, -scale+y, -scale+z, 0, 0);
  vertex( scale+x, -scale+y, -scale+z, 1, 0);
  vertex( scale+x, -scale+y,  scale+z, 1, 1);
  vertex(-scale+x, -scale+y,  scale+z, 0, 1);
  if(((RotationState == 3)||(IsRotating == true &&RotationState == 2))){
  vertex( scale+x, -scale+y,  scale+z, 0, 0);
  vertex( scale+x, -scale+y, -scale+z, 1, 0);
  vertex( scale+x,  scale+y, -scale+z, 1, 1);
  vertex( scale+x,  scale+y,  scale+z, 0, 1);
  }
  if(((RotationState == 1)||(IsRotating == true &&RotationState == 0))){
  vertex(-scale+x, -scale+y, -scale+z, 0, 0);
  vertex(-scale+x, -scale+y,  scale+z, 1, 0);
  vertex(-scale+x,  scale+y,  scale+z, 1, 1);
  vertex(-scale+x,  scale+y, -scale+z, 0, 1);
  }
  endShape();
}

}