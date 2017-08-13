public class Player{
public int health;
public int speed;
public float FXvel;
public float FXpos;
public float Yvel;
public float shiftZ;
public float shiftX;
public int pwidth = scale;
public int pheight = int(scale*1.618);
private float x,y,z;
public boolean isJumping = false;
public float Damage;
private cube mCube;
boolean IsPerpendicular = false;
float slope;
float intercept;
public Player(int health,int speed, float Damage){
  this.health = health;
  this.speed = speed;
  this.Damage = Damage;
  isJumping = false;
  x = width/2;
  y = height/2- pheight*1.618;
  z = 0;
  mCube = new cube(0,int(x),int(y),int(z));
  shiftX = 1;
}
public void RenderPlayer(){

}
public float getX(){
return x;
}
public float getY(){
return y;
}
public float getZ(){
return z;
}
public void calculateShift(float ang){
shiftZ = sin(radians(ang));
shiftX = cos(radians(ang));
 player.genEquation();
}
public void genEquation(){
if (abs(shiftX) > 0.0000001){
  IsPerpendicular = false;
slope = shiftZ/shiftX;
}else{
IsPerpendicular = true;
slope = 0;
}
intercept = z-x*slope;
}
public void updatePlayer(){
  if(abs(shiftX) < 0.0000001){
shiftX = 0;
}
if(abs(shiftZ) < 0.0000001){
  shiftZ = 0;
}
  if(IsRotating == false){
  if (KeyUp){
  }
  if(KeyLeft){
    FXvel -= 0.07;
    if(FXvel > 0){
      FXvel *= -0.8;
    }else{
      FXvel *= 1.2;
    }
  }
  if(KeyRight){
    FXvel += 0.07;
    if(FXvel > 0){
      FXvel *= 1.2;
    }else{
      FXvel *= -0.8;
    }
  }
  FXvel *= 0.95;
  if (abs(FXvel) < 0.01){
    FXvel = 0;
  }
  if(abs(FXvel) > 5){
    if(FXvel > 0){
      FXvel =5;
    }else{
      FXvel = -5;
    }
  }    
  y+=Yvel;
  
  x+=shiftX*FXvel;
  z+=shiftZ*FXvel;
  FXpos+=FXvel;
  mCube.x = int(x);
  mCube.y = int(y);
  mCube.z = int(z);
  }else{
  FXvel = 0;
  FXpos = 0;
  }
}


}