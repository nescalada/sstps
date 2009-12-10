
public abstract class Server{
  boolean status;
  double time_next_event;
  static boolean IDLE = false;
  static boolean BUSY = true;
  Cola<Cliente> q;
  
  /**
   * determina el tiempo que tarda en ser atendido un cliente en este servidor
   * @return
   */
  abstract double timeInServer(double now); 
    
  Server(){
    this.status = IDLE;
    this.time_next_event = 1.0e+30;
    this.q = new Cola<Cliente>();
  }
  
}
