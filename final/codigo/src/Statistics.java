
public class Statistics{
  public static final Statistics stats = new Statistics();
  //variables para l'ecuyer
  public static int x1n = (40014 * 800634) % 2147483563;
  public static int x2n = (40692 * 2518) % 2147483399;

  public static Statistics getInstance(){
            return stats;
  }

  public double expon(Double mean){
   Double u;
   u = nextLecuyer();
   System.out.println("u = " + u);
   return - mean * Math.log(u);
  }
  
  public double uniform(double min, double max){
    Double u;
    u = nextLecuyer();
    return  u*(max-min)   + min  ;
  }

  public double normal(double mu, double sigma){
    return sigma*nextBoxMuller()+mu;
  }
 
  private double nextBoxMuller() {
    double u1, u2, S;
    
    do{
      u1 = nextLecuyer()*2 - 1;
      u2 = nextLecuyer()*2 - 1;
      S = u1*u1 + u2*u2; 
    }while(S>1);
    
    double c = Math.sqrt((-2*Math.log(S))/S);
    double X = c*u1;
    double Y = c*u2;
    
    if(nextLecuyer() > 0.5)
      return X;
    return Y;
  }

  private Double nextLecuyer(){
    double Xn = (Statistics.x1n - Statistics.x2n) % 2147483562;
    while(Xn<0){
      Xn += 2147483562;
    }

    Statistics.x1n = (40014 * Statistics.x1n) % 2147483563;
    Statistics.x2n = (40692 * Statistics.x2n) % 2147483399;

    if(Xn == 0){
      return 2147483562.0/2147483563.0;
    }
    return ((Double)Xn)/2147483563.0;
  }
}
