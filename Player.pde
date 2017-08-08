public class Player{
public int health;
public int speed;
public float FXvel;
public float Yvel;
public float shiftZ;
public float shiftX;
private float x,y,z;
public boolean IsJumping = false;
public float Damage;
public Player(int health,int speed, float Damage){
  this.health = health;
  this.speed = speed;
  this.Damage = Damage;
  x = width/2;
  y = height/2;
  z = 0;
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
public void UpdatePlayer(){
  if(KeyUp && IsJumping == false){           
    Yvel -= 0.1;
    if(Yvel > 0){
      Yvel *= -0.8333333;
    }else{
      Yvel *= 1.2;
    }
    IsJumping = true;
  }
  Yvel *= 0.8;
  if (abs(Yvel) < 0.05){
    Yvel = 0;
  }
  if(abs(Yvel) > 8){
    if(Yvel > 7){
      Yvel = 8;
    }else{
      Yvel = -8;
    }
  }
  if(KeyLeft){
    FXvel -= 0.1;
    if(FXvel > 0){
      FXvel *= -0.8;
    }else{
      FXvel *= 1.2;
    }
  }
  if(KeyRight){
    FXvel += 0.1;
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
  if(abs(FXvel) > 8){
    if(FXvel > 0){
      FXvel =8;
    }else{
      FXvel = -8;
    }
  }    

}


}