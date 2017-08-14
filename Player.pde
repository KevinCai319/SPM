public class Player{
public int health;
public int speed;
public float FXvel;
public float FXpos;
public float Yvel;
public float shiftZ;
public int pwidth = scale;
public int pheight = int(scale*1.618);
public float shiftX;
private float x,y,z;
private boolean isColliding = false;
public boolean isJumping = false;
public float Damage;
private cube mCube;
AABBHitbox HitBox;
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
  pwidth = scale;
  height = int(scale*1.618);
  mCube = new cube(0,int(x),int(y),int(z));
  shiftX = 1;
}
public void generateHitbox(){
  HitBox = new AABBHitbox(float(pwidth/2),float(pheight/2),new PVector(0,player.y));
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
public void CheckCollision(){
  isColliding = false;
  for(int i = 0; i < C2Dplane.size();i++){
    if(HitBox.IsColliding(C2Dplane.get(i).k)){
      isColliding = true;
    }
  }

}
public void respawn(){
    isJumping = false;
  x = width/2;
  y = height/2- pheight*1.618;
  z = 0;
  Yvel = 0;
}
public void updatePlayer(){
  if(abs(shiftX) < 0.0000001){
shiftX = 0;
}
if(abs(shiftZ) < 0.0000001){
  shiftZ = 0;
}
  if(IsRotating == false){
    CheckCollision();
  if (KeyUp&&isJumping == false){
    isJumping = true;
    Yvel = -scale;
  }
  if(isJumping){
    if(Yvel > -scale/10 && Yvel< 0){
      Yvel = 0.2;
    }
    if (Yvel < 0){
      Yvel*= 0.95;
     
    }else{
       Yvel*=1.05;
    }
    CheckCollision();
    //println(C2Dplane.size());
    if(isColliding){
    isJumping = false;
    Yvel = 0;
    }
  }else{
   if(!isColliding){
     if(Yvel <= 0){
      Yvel = -1;
     }else{
       Yvel *= 1.05;
     }
    }else{
      Yvel = 0;
    }
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
  HitBox.center.y = y;
  if(y > 1000){
  respawn();
  }
  }else{
  FXvel = 0;
  FXpos = 0;
  }
}


}