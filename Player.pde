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
public ArrayList<AABBHitbox> Intersecting = new ArrayList<AABBHitbox>();
public float Damage;
private cube mCube;
AABBHitbox HitBox;
AABBHitbox Rbox;
AABBHitbox Lbox;
boolean Rint = false;
boolean Lint = false;
boolean IsPerpendicular = false;
float slope;
float intercept;
float ly;
float lx;
public Player(int health,int speed, float Damage){
  this.health = health;
  this.speed = speed;
  this.Damage = Damage;
  isJumping = false;
  x = width/2;
  y = height/2- pheight*1.618-5;
  z = 0;
  pwidth = scale;
  mCube = new cube(0,int(x),int(y),int(z));
  shiftX = 1;
}
public void generateHitbox(){
  HitBox = new AABBHitbox(float(pwidth),float(pheight),new PVector(0,player.y));
  Lbox = new AABBHitbox(2,pheight-7,new PVector(-pwidth,player.y));
  Rbox = new AABBHitbox(2,pheight-7,new PVector(pwidth,player.y));
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
public void CheckCollision(AABBHitbox HitBox){
  Intersecting.clear();
  isColliding = false;
  Rint = false;
  Lint = false;
  for(int i = 0; i < C2Dplane.size();i++){
    if(HitBox.IsColliding(C2Dplane.get(i).k)){
      Intersecting.add(C2Dplane.get(i).k);
      isColliding = true;
    }
    if(Rbox.IsColliding(C2Dplane.get(i).k)){
        Rint = true;
    }
    if(Lbox.IsColliding(C2Dplane.get(i).k)){
        Lint = true;
    }
  }

}
public void respawn(){
    isJumping = false;
  x = width/2;
  y = height/2- pheight*1.618 -5;
  z = 0;
  Yvel = 0;
}
public void subFX(float l){
    FXpos+=l;
  x +=shiftX*l;
  z +=shiftZ*l;
}
public void updatePlayer(){
  if(abs(shiftX) < 0.0000001){
shiftX = 0;
}
if(abs(shiftZ) < 0.0000001){
  shiftZ = 0;
}
  if(IsRotating == false){
    UpdateInputs();
    CheckCollision(HitBox);
  if(Rint&!Lint){
    int i = 0;
    println("r");
    if (FXvel >= 0){
      if(FXvel == 0){
         subFX(-1);
      }
      subFX(-FXvel);
    FXvel =0;
    }
  /*while(Rint){
    CheckCollision(HitBox);
    Rbox.center.x--;
    i++;
  }
  FXvel = 0;
   subFX(-i);*/
  }
  if(Lint&!Rint){
    int i = 0;
    println("l");
    if (FXvel <= 0){
      if(FXvel == 0){
         subFX(1);
      }
    subFX(-FXvel);
    FXvel =0;
    }
  /*while(Rint){
    CheckCollision(HitBox);
    Rbox.center.x--;
    i++;
  }
  FXvel = 0;
   subFX(-i);*/
  }
  if(isJumping){
    if(Yvel > -5 && Yvel< 0){
      Yvel = 0.2;
    }
    if (Yvel < 0){
      Yvel*= 0.9;
     
    }else{
       Yvel*=1.111;
    }
    CheckCollision(HitBox);
    //println(C2Dplane.size());
    if(isColliding){
      if(Yvel >= 0.3 ){
    isJumping = false;
    int i =0;
    while(isColliding){
      CheckCollision(new AABBHitbox(pwidth,pheight,new PVector(0,HitBox.center.y+i)));
      i--;
    }
    y += i+1;
    Yvel = 0;
      }else{
        if(!( Yvel< -15) ){
        println(Yvel);
      int i = 0;
          while(isColliding){
            CheckCollision(new AABBHitbox(pwidth,pheight,new PVector(0,HitBox.center.y+i)));
            i++;
          }
          if(y+i < ly){
          y = y+i;
          }
      //Yvel =  -0.2;
      }
    }

    }
  }else{
   if(!isColliding){
     if(Yvel <= 0){
      Yvel = 1;
     }else{
       Yvel *= 1.05;
     }
    }else{
      Yvel = 0;
    }
  }
  }else{
  FXvel = 0;
  FXpos = 0;
  }
}
public void UpdateInputs(){
  if (KeyUp&&isJumping == false && isColliding){
    isJumping = true;
    ly = y;
    lx = FXpos;
    Yvel = -scale;
  }
  if(KeyLeft&&!Lint){
    FXvel -= 0.07;
    if(FXvel > 0){
      FXvel *= -0.8;
    }else{
      FXvel *= 1.2;
    }
  }
  if(KeyRight && !Rint){
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
  Lbox.center.y = y;
  Rbox.center.y = y;
  HitBox.center.y = y;
  if(y > 1000){
  respawn();
  }
}

}