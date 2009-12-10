
public class ExpServer extends Server {
  private double lambda;
    
  @Override
  public double timeInServer(double now) {
    Statistics s = new Statistics();
    this.time_next_event = now + s.expon(this.lambda);
    return this.time_next_event;
  }
  
  ExpServer(double lambda){
    super();
    this.lambda = lambda;
       
  }

}
