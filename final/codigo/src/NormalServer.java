
public class NormalServer extends Server {
  double mu;
  double sigma;
  
  @Override
  double timeInServer(double now) {
    Statistics s = new Statistics();
    this.time_next_event = now + s.normal(mu, sigma);
    return this.time_next_event;
  }

  NormalServer(double mu, double sigma){
    super();
    this.mu = mu;
    this.sigma = sigma;
   
  }
}
