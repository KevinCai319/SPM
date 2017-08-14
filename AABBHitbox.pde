public class AABBHitbox{
public PVector center;
public float halfY;
public float halfX;
public AABBHitbox(float HalfX,float HalfY,PVector center){
  this.center = center;
  this.halfX = HalfX;
  this.halfY = HalfY;
}
public boolean IsColiding(AABBHitbox tile){
  if ( abs(center.x - tile.center.x) > halfX + tile.halfX ){
    return false;
  }
  if ( abs(center.y - tile.center.y) > halfY + tile.halfY ){
    return false;
  }
  return true;
}

}