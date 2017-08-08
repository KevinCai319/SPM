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

if(cx> x && cz < z){
cz++;
cx = -x;
}else{
cx++;
}
IBlock.add(new cube(0,(width/2)+scale*2*x,(height/2),scale*z*2));
if(cx> x && cz > z){
IsLoaded = true;
CurrentlyLoading =false;
}

}
public void RenderLoadBar(){
progress = (cx*cz)/(4*x*z);

}

}