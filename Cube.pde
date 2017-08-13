public class cube{
PImage m;
int x;
int y;
float mx = 0;
float mz = 0;
float tx = 0;
float tz = 0;
int TintVal = 255;
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
public void Prender(int pheight,int pwidth){
  beginShape(QUADS);
  texture(m);
    vertex(player.x+player.shiftX*pwidth, player.y+player.pheight, player.z+player.shiftZ*20, 0, 1);
  vertex(player.x+player.shiftX*pwidth, player.y-player.pheight,  player.z+player.shiftZ*20, 0, 0);
  vertex(player.x-player.shiftX*pwidth,  player.y-player.pheight, player.z-player.shiftZ*20, 1, 0);
  vertex(player.x-player.shiftX*pwidth,  player.y+player.pheight,  player.z-player.shiftZ*20, 1, 1);
  endShape();
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
 if(IsTint){
 tint(50);
 }else{
   tint(255,255);
 }
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
  if(GetDistance(float(x),float(z),player.x,player.z,player.x+player.shiftX,player.z+player.shiftZ)< scale*dist &&GetDist(x,z,player.x,player.z)<scale*dist*2){//lies on the line of intersection
    crossSection();
  }
  }
}
public void crossSection(){
  PShape cubeobj;
  int k =0;
  ArrayList<Float[]> ml = new ArrayList<Float[]>();
   ArrayList<Float> j = new ArrayList<Float>();
  PVector a = new PVector(-scale+x, -scale+z);
  PVector b = new PVector( scale+x, -scale+z);
  PVector c = new PVector( scale+x, scale+z);
  PVector d = new PVector(-scale+x, scale+z);
  PVector[] vectors = new PVector[] {a,b,c,d};
for(int i = 0; i <vectors.length ; i++){
if(compareIntersection(vectors[i%vectors.length],vectors[(i+1)%vectors.length]).length > 1 && ml.size() < 2) {
  if(compareIntersection(vectors[i%vectors.length],vectors[(i+1)%vectors.length]).length > 3){
    ml.add(new Float[]{0.0,compareIntersection(vectors[i%vectors.length],vectors[(i+1)%vectors.length])[1],compareIntersection(vectors[i%vectors.length],vectors[(i+1)%vectors.length])[2]});
    ml.add(new Float[]{0.0,compareIntersection(vectors[i%vectors.length],vectors[(i+1)%vectors.length])[3],compareIntersection(vectors[i%vectors.length],vectors[(i+1)%vectors.length])[4]});
}else{
    ml.add(compareIntersection(vectors[i%vectors.length],vectors[(i+1)%vectors.length]));
  }
}
}
if(ml.size() > 1){
cubeobj = createShape();
cubeobj.beginShape(QUADS); 
texture(m);
cubeobj.vertex(ml.get(0)[1],y+scale,ml.get(0)[2],0,1);
cubeobj.vertex(ml.get(1)[1],y+scale,ml.get(1)[2],0,1);
cubeobj.vertex(ml.get(0)[1],y-scale,ml.get(0)[2],0,1);
cubeobj.vertex(ml.get(1)[1],y-scale,ml.get(1)[2],0,1);
j.add(ml.get(0)[1]);
j.add(ml.get(1)[2]);
mx = ml.get(0)[1];
mz = ml.get(0)[2];
tx = ml.get(1)[1];
tz = ml.get(1)[2];
cubeobj.endShape();
IsTint = false;
//println(m.get(0)[0]+"/"+player.shiftZ);
//println(j.get(0)+"/"+j.get(1)+"/"+BID+"/" +  player.slope);
beginShape(QUADS); 
texture(m);
vertex(ml.get(0)[1],y+scale,ml.get(0)[2],0,0);
vertex(ml.get(0)[1],y-scale,ml.get(0)[2],0,1);
vertex(ml.get(1)[1],y-scale,ml.get(1)[2],1,1);
vertex(ml.get(1)[1],y+scale,ml.get(1)[2],1,0);
endShape();
}else{
IsTint = true;
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
  float jx=0;
  float jz=0;
  float px = 0;
  float pz=0;
  boolean IsIntersecting = false;
  Float[] res = new Float[] {0.0};
  float IntersectionState = 0;
    if(player.shiftX == 0){
      IntersectionState = 4;
      if(player.x >= min(A.x,B.x)&& player.x <= max(A.x,B.x)){
        jx = player.x;
        jz = z+scale;
        px = player.x;
        pz = z-scale;
        IsIntersecting = true;
      }
    }else{
        if(player.shiftZ == 0){
          IntersectionState = 3;
          if(player.z >= min(A.y,B.y)&& player.z <= max(A.y,B.y)){
            jx = x+scale;
            jz = player.z;
            px = x-scale;
            pz = player.z;
            IsIntersecting = true;
          }
        }else{
           if(A.x == B.x){
             IntersectionState = 1;
              if((A.x*player.slope+player.intercept >min(A.y,B.y) )&&(A.x*player.slope+player.intercept <max(A.y,B.y)) ){
                 jx = A.x;
                 jz = A.x*player.slope+player.intercept;
                 IsIntersecting = true;
              }
           }else{
             IntersectionState = 2;
             if(((A.y-player.intercept)/player.slope >min(A.x,B.x)) &&((A.y-player.intercept)/player.slope <max(A.x,B.x) )){
               jx = (A.y-player.intercept)/player.slope;
               jz = A.y;
               IsIntersecting = true;
             }
           } 
      }
    }
    
  
  if(IsIntersecting){
    if(IntersectionState ==  4 || IntersectionState == 3){
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