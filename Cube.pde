public class cube{
PImage m;
int x;
int y;
boolean IsRender = true;
boolean IsTint = false;
int ID;
int z;
int dist = scale*2;
public cube(int BlockID,int x, int y, int z){
ID = BlockID;
this.x = x;
this.y = y;
this.z = z;
  textureMode(NORMAL);
m = loadImage("/Textures/"+ ID + ".PNG");
LoadedBlocks.add(new Integer[]{this.x,this.y,this.z});
int ID = LoadedBlocks.size();
}
public void render(int scale){
  IsTint = false;
   IsRender = false;
    if (GetDistance(float(x),float(z),player.x,player.z,player.x+player.shiftX,player.z+player.shiftZ)< scale*dist){
    IsRender = true;
    }else{
    if(IsRotating){
      IsRender = true;
      IsTint = true;
    }
    }
    
  if (IsRender){
    println(abs((player.slope*x)+z+player.intercept)/player.slope);
 beginShape(QUADS);
 if(IsTint){
 tint(50);
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
public void IsIntersecting(){
  float dist = GetDistance(float(x),float(z),player.x,player.z,player.x+player.shiftX,player.z+player.shiftZ);
  if(dist*dist < scale*scale*2){//lies on the line of intersection
    crossSection();
  }
}
public void crossSection(){
  PShape cubeobj;
  float[]dist = new float[6];
  ArrayList<Float[]> m = new ArrayList<Float[]>();
  PVector a = new PVector(-scale+x, -scale+z);
  PVector b = new PVector( scale+x, -scale+z);
  PVector c = new PVector( scale+x, scale+z);
  PVector d = new PVector(-scale+x, scale+z);
m.add(compareIntersection(a,b,new PVector(player.x+30000*player.shiftX,player.z+30000*player.shiftZ),new PVector(player.x-30000*player.shiftX,player.z-30000*player.shiftZ)));
m.add(compareIntersection(b,c,new PVector(player.x+30000*player.shiftX,player.z+30000*player.shiftZ),new PVector(player.x-30000*player.shiftX,player.z-30000*player.shiftZ)));
m.add(compareIntersection(c,d,new PVector(player.x+30000*player.shiftX,player.z+30000*player.shiftZ),new PVector(player.x-30000*player.shiftX,player.z-30000*player.shiftZ)));
m.add(compareIntersection(d,a,new PVector(player.x+30000*player.shiftX,player.z+30000*player.shiftZ),new PVector(player.x-30000*player.shiftX,player.z-30000*player.shiftZ)));
cubeobj = createShape();
cubeobj.beginShape(); 
for(int i = 0; i < m.size(); i++){
if(m.get(i).length > 1){
cubeobj.vertex(m.get(i)[1],m.get(i)[2]);
dist[i] = GetDistance(m.get(i)[1],m.get(i)[2],player.x,player.z,player.x+player.shiftX,player.z+player.shiftZ);
}
}
//flatObj k = new flatObj(dist[0],-scale+y,,scale+y,cubeobj);
}
public Float[] compareIntersection(PVector A, PVector B,PVector C,PVector D){
 int IntersectingState = 0; //no collison
PVector E = new PVector (B.x-A.x,B.y-A.y);
PVector F = new PVector (D.x-C.x, D.y-C.y);
PVector P  = new PVector( -E.y, E.x );
PVector M = new PVector(A.x-C.x,A.y-C.y);
if(F.x*P.x+F.y*P.y == 0){
IntersectingState = 1; //parralllel
return new Float[] {float(IntersectingState)};
}else{
float h = ( M.x*P.x+M.y*P.y ) / (F.x*P.x+F.y*P.y);
if(h >0.05 && h < 0.95){
 IntersectingState = 2;
}
return new Float[] {float(IntersectingState),C.x+F.x*h,C.y+F.y*h};
}
}
public float GetDistance(float x, float y, float x1, float y1, float x2, float y2) {
    float A = x - x1;
    float B = y - y1;
    float C = x2 - x1;
    float D = y2 - y1;
    float E = -D;
    float F = C;
    float dot = A * E + B * F;
    float len_sq = E * E + F * F;
    return dot* dot/ len_sq;
  }
}