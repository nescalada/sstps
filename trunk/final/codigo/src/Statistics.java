import java.util.Random;


public class Statistics extends Random {
  private static final long serialVersionUID = 1L;
  
  public Double expon(Double mean){
   Double u;
   
   u = this.nextDouble();
   
   return - mean * Math.log(u);
  }
  
  public Double uniform(Double min, Double max){
    Double u;
    u = this.nextDouble();
    return  u*(max-min)   + min  ;
  }
  
}
