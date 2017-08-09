public class cube{
PImage m;
int x;
int y;
boolean IsRender = true;
boolean IsTint = false;
int ID;
int z;
int dist = 5;
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
  IsTint = false;
   IsRender = false;
  if(player.IsPerpendicular ==true){
    if(abs(player.x-x) < scale*dist){
    IsRender = true;
    }
  }else{
    if (((z-scale*dist <player.intercept+player.slope*x )&&(player.intercept+player.slope*x< z+scale*dist))){
    IsRender = true;
    }else{
    if(IsRotating){
      IsRender = true;
      IsTint = true;
    }
    }
    
  }
  if (IsRender){
    println(abs((player.slope*x)+z+player.intercept)/player.slope);
 beginShape(QUADS);
 if(IsTint){
 tint(255,150);
 }else{
   tint(255,255);
 }
  texture(m);
  vertex(-scale+x, -scale+y,  scale+z, 0, 0);
  vertex( scale+x, -scale+y,  scale+z, 1, 0);
  vertex( scale+x,  scale+y,  scale+z, 1, 1);
  vertex(-scale+x,  scale+y,  scale+z, 0, 1);
  vertex( scale+x, -scale+y, -scale+z, 0, 0);
  vertex(-scale+x, -scale+y, -scale+z, 1, 0);
  vertex(-scale+x,  scale+y, -scale+z, 1, 1);
  vertex( scale+x,  scale+y, -scale+z, 0, 1);
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

}