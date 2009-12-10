
public class UniformServer extends Server {
  double min;
  double max;
  
  @Override
  double timeInServer(double now) {
    Statistics s = new Statistics();
    this.time_next_event = now + s.uniform(this.min, this.max);
    return this.time_next_event;
  }
  
  UniformServer(double min, double max){
    super();
    this.min = min;
    this.max = max;
   
  }

}
