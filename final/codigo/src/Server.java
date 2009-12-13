
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
  
  public void add(Cliente element)
    throws Exception{
    this.q.add(element);
  }
  
  public Cliente remove()
    throws Exception{
    return this.q.remove();
  }
  
  public int size(){
    return this.q.size();
  }
  
  public int len(){
    int ret  = this.q.size();
    if( ret > 0)
      ret--;
    return ret;
  }
  
  public Cliente swap(Cliente element) throws Exception{
    return this.q.swap(element);
  }
  
  
}
