public class cube{
PImage m;
int x;
int y;
boolean IsRender = true;
boolean IsTint = false;
int ID;
int BID;
int z;
int dist = scale*2;
public cube(int BlockID,int x, int y, int z){
ID = BlockID;
this.x = x;
this.y = y;
this.z = z;
m = loadImage("/Textures/"+ ID + ".PNG");
LoadedBlocks.add(new Integer[]{this.x,this.y,this.z});
BID = LoadedBlocks.size();
}
public void render(int scale){
  IsTint = false;
   IsRender = false;
    if (GetDistance(float(x),float(z),player.x,player.z,player.x+player.shiftX,player.z+player.shiftZ)< scale*dist &&GetDist(x,z,player.x,player.z)<scale*dist){
    IsRender = true;
    }else{
    if(IsRotating&& GetDist(x,z,player.x,player.z)<scale*50){
      IsRender = true;
      IsTint = true;
    }
    }
    
  if (IsRender){
  IsIntersecting();
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
  //bottom face. never show/*
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
  if(BID != 1){
  if(GetDistance(float(x),float(z),player.x,player.z,player.x+player.shiftX,player.z+player.shiftZ)< scale*dist &&GetDist(x,z,player.x,player.z)<scale*dist){//lies on the line of intersection
    crossSection();
  }
  }
}
public void crossSection(){
  PShape cubeobj;
  int k =0;
  Float[] tmp;
  ArrayList<Float[]> m = new ArrayList<Float[]>();
   ArrayList<Float> j = new ArrayList<Float>();
  PVector a = new PVector(-scale+x, -scale+z);
  PVector b = new PVector( scale+x, -scale+z);
  PVector c = new PVector( scale+x, scale+z);
  PVector d = new PVector(-scale+x, scale+z);
  PVector[] vectors = new PVector[] {a,b,c,d};
for(int i = 0; i <vectors.length-1 ; i++){
if(compareIntersection(vectors[i],vectors[i+1]).length > 2 && m.size() < 3) {
  if(compareIntersection(vectors[i],vectors[i+1]).length > 3){
    m.add(new Float[]{compareIntersection(vectors[i],vectors[i+1])[1],compareIntersection(vectors[i],vectors[i+1])[2]});
    m.add(new Float[]{compareIntersection(vectors[i],vectors[i+1])[3],compareIntersection(vectors[i],vectors[i+1])[4]});
  }else{
m.add(compareIntersection(vectors[i],vectors[i+1]));
  }
}
}
if(m.size() > 1){
cubeobj = createShape();
cubeobj.beginShape(); 
cubeobj.vertex(m.get(0)[1],y+scale,m.get(0)[2]);
cubeobj.vertex(m.get(1)[1],y+scale,m.get(1)[2]);
cubeobj.vertex(m.get(0)[1],y-scale,m.get(0)[2]);
cubeobj.vertex(m.get(1)[1],y-scale,m.get(1)[2]);
j.add(m.get(0)[1]);
j.add(m.get(1)[2]);
cubeobj.endShape();
println(j.get(0)+"/"+j.get(1)+"/"+BID+"/" +  player.x + "/" +player.z);
}
if( k > 1){
 /* println(player.shiftX + "/" +player.shiftZ + "/" + k);
  if(player.shiftZ == 0){
  C2Dplane.add(new flatObj((j.get(0)-player.x)/player.shiftX,float(-scale+y),(j.get(3)-player.x),scale+y,cubeobj));
  }else{
   if(player.shiftX == 0){
   C2Dplane.add(new flatObj((j.get(0)-player.x),float(-scale+y),(j.get(1)-player.z)/player.shiftZ,scale+y,cubeobj));
   }else{
     C2Dplane.add(new flatObj((j.get(0)-player.x)/player.shiftX,float(-scale+y),(j.get(1)-player.z)/player.shiftZ,scale+y,cubeobj));
   }
  }*/
}
}
public Float[] compareIntersection(PVector A, PVector B){
  float eq = 0;
  float jx=0;
  float jz=0;
  float px = 0;
  float pz=0;
  boolean IsIntersecting = false;
  Float[] res = new Float[] {0.0};
  float IntersectionState = 0;
  if(A.y == B.y &&B.y == player.z){
    jx = A.y;
    jz = A.x;
    px = B.x;
    pz = B.y;
   IntersectionState =2;
   IsIntersecting = true;
  }else{
  if(A.x == B.x &&B.x == player.x){
    jx = A.x;
    jz = A.y;
    px = B.x;
    pz = B.y;
   IntersectionState =3;
   IsIntersecting = true;
  }else{
    if(player.shiftX == 0){
      IntersectionState = 4;
      if(player.x > min(A.x,B.x)&& player.x < max(A.x,B.x)){
        jx = player.x;
        jz = A.y;
        IsIntersecting = true;
      }
    }else{
        if(player.shiftZ == 0){
        if(player.z > min(A.y,B.y)&& player.z < max(A.y,B.y)){
          jx = A.x;
          jz = player.z;
          IsIntersecting = true;
        }
        }else{
           if(A.x == B.x){
             if(A.x*player.slope+player.intercept >min(A.y,B.y) &&A.x*player.slope+player.intercept <max(A.y,B.y) ){
               jx = A.x;
               jz = A.x*player.slope+player.intercept;
               IsIntersecting = true;
             }
           }else{
             if((A.y-player.intercept)/player.slope >min(A.x,B.x) &&(A.y-player.intercept)/player.slope <max(A.x,B.x) ){
               jx = (A.y-player.intercept)/player.slope;
               jz = A.y;
               IsIntersecting = true;
             }
           }
        }
    }
    
    }
  }
  
  if(IsIntersecting){
    if(IntersectionState ==  2 || IntersectionState == 3){
      res = new Float[] {IntersectionState,jx,jz,px,pz};
    }else{
    res = new Float[] {IntersectionState,jx,jz};
    }
  }
  return res;
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
public float GetDist(float x, float y, float x1,float y1){
  return sqrt((x-x1)*(x-x1)+(y-y1)*(y-y1));
}
}