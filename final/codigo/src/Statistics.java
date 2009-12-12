import java.util.Random;


public class Statistics extends Random {
  private static final long serialVersionUID = 1L;
  
  public double expon(Double mean){
   Double u;
   u = this.nextDouble();
   return - mean * Math.log(u);
  }
  
  public double uniform(double min, double max){
    Double u;
    u = this.nextDouble();
    return  u*(max-min)   + min  ;
  }

  public double normal(double mu, double sigma){
    //TODO: revisar
    
    return (this.nextGaussian() - mu)/sigma;
  }
  
}
