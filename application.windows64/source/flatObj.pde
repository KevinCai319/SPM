public class flatObj{
float FxT;
float yT;
float FxB;
int Id;
float yB;
AABBHitbox k;
public flatObj(float fx, float y, float fb, float yb,int BID){
  Id = BID;
  k = new AABBHitbox(abs(fx-fb)/2,abs(y-yb)/2,new PVector((fx+fb)/2,(y+yb)/2));
}
}