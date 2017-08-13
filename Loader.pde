public class levelLoader{
int x;
int y;
int z;
float progress;
int cx,cy,cz = 0;
public levelLoader(){

}
public void StartLoad(int x, int y, int z){
this.x = x;
this.y = y;
this.z = z;
cz = -x;
cx = -x;
}
public void LoadUpdate(){

if(cx>= x && cz <= x){
cz++;
cx = -x;
}else{
cx++;
}
//println(cx);
if(cz<= x || cx<=x){
  if (cz > 2){
IBlock.add(new cube(1,(width/2)+scale*2*cx,(height/2),scale*cz*2));
IBlock.add(new cube(1,(width/2)+scale*2*cx,(height/2)-scale*2,scale*cz*2));
IBlock.add(new cube(1,(width/2)+scale*2*cx,(height/2)-scale*4,scale*cz*2));
  }else{
    if (cx > 2){
  IBlock.add(new cube(2,(width/2)+scale*2*cx,(height/2),scale*cz*2));
  IBlock.add(new cube(2,(width/2)+scale*2*cx,(height/2)-scale*2,scale*cz*2));
    }else{
      IBlock.add(new cube(5,(width/2)+scale*2*cx,(height/2),scale*cz*2));
    }
  }
}
if(cx> x && cz > x){
IsLoaded = true;
CurrentlyLoading =false;
}

}
public void RenderLoadBar(){
progress = (cx*cz)/(4*x*z);

}

}