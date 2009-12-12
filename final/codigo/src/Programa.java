import java.io.FileOutputStream;
import java.io.PrintStream;
import java.util.ArrayList;

public class Programa {
  static final int ARRIVE = 1;
  static final int DEPART_R = 2;
  static final int DEPART_E1 = 3;
  static final int DEPART_E3 = 4;
  static final int DEPART_OFT = 5;
  static final int DEPART_PSF = 6;
  static final int DEPART_E2 = 7;
  static final int DEPART_C1 = 8;
  static final int DEPART_C2 = 9;
  static final int DEPART_C3 = 10;
  static final int CANT_EVENTS = 10;

  static double BEGINS = 8.0 * 60; // 08:00 hs (en minutos)
  static double ENDS = 13.0 * 60; // 13:00 hs (en minutos)

  private double time;
  private Server r, e1, e3, oft, psf, e2, c1, c2, c3;
  private double time_last_event;

  /* estadisticos */
  int num_custs_delayed;
  double total_of_delays;
  double area_num_in_q;
  double area_server_status;
  int next_event_type;

  private FileOutputStream outfile; // declare a file output object
  private FileOutputStream timefile; // declare a file output object
  private PrintStream p_out; // declare a print stream object
  private PrintStream p_time; // declare a print stream object

  ArrayList<Double> time_next_event;
  ArrayList<Server> servers;
  private boolean FLAG_ENDS;

  public Programa() {
    try {

      this.outfile = new FileOutputStream("mm1.out");
      this.timefile = new FileOutputStream("mm1.tim");
      this.p_out = new PrintStream(outfile);
      this.p_time = new PrintStream(timefile);
      this.FLAG_ENDS = false;
    } catch (Exception e) {
      e.printStackTrace();
    }

  }

  public static void main(String[] args) {

    /* Abre los archivos de entrada y salida */
    Programa p = new Programa();

    /* Escribe el encabezado del reporte de salida en mm1.out */
    p.p_out.println("Sistema de cola con servidor simple\n\n");
    /* Escrible el encabezado del archivo con series de tiempo */
    p.p_time.println("File: mm1.tim - Programa: mm1.c\n");
    p.p_time.println("3\n");
    p.p_time.println("Tiempo\n");
    p.p_time.println("Longitud de la cola\n");
    p.p_time.println("Ocupacion del servidor\n");
    /* Inicializa la simulacion */
    p.initialize();
   
    /* Simulacion */
    while (!p.ends()) {
      /* Determina el proximo evento */
      try {
       // System.out.println(p.time_next_event.toString());
        p.timing();
        // /* Actualiza los acumuladores estadisticos de tiempos medios */
        // update_time_avg_stats();
        /* Llama a la funcion de evento que corresponde */
        System.out.println(p.time + "-> el evento es: " + p.next_event_type);
        //System.out.println(p.time_next_event.toString());
        switch (p.next_event_type) {

        case Programa.ARRIVE:
          p.arrive_r();
          break;
        case Programa.DEPART_R:
          p.depart_r();
          break;
        case Programa.DEPART_E1:
          p.depart_e1();
          break;
        case Programa.DEPART_E3:
          p.depart_e3();
          break;
        case Programa.DEPART_OFT:
          p.depart_oft();
          break;
        case Programa.DEPART_PSF:
          p.depart_psf();
          break;
        case Programa.DEPART_E2:
          p.depart_e2();
          break;
        case Programa.DEPART_C1:
          p.depart_c(Programa.DEPART_C1);
          break;
        case Programa.DEPART_C2:
          p.depart_c(Programa.DEPART_C2);
          break;
        case Programa.DEPART_C3:
          p.depart_c(Programa.DEPART_C3);
          break;
        }
      } catch (Exception e) {
        p.FLAG_ENDS = true; 
        e.printStackTrace();
        System.out.println(e.getMessage());
        p.p_out.close();
        
      }
      // /* Imprime las series de tiempo */
      // fprintf(timefile,"%12.3f %4d %d\n",time,num_in_q,server_status);
    }

    p.p_out.close();
    System.out.println("fin!");
    /* Llama a la funcion que genera el reporte de salida y finaliza */
    // report();
    // fclose(infile);
    // fclose(outfile);
    // fclose(timefile);
  }

  private void depart_oft() throws Exception {
    double delay;
    Cliente cliente = null;
    Server srv = servers.get(Programa.DEPART_OFT);
    /* SUPONGO QUE SI EL SERVIDOR ESTA ATENDIENDO, LA COLA TIENE UN CLIENTE */
    /* La cola no esta vacia. decrementa el numero de clientes en cola. */
    cliente = srv.remove();
    
    cliente.setFail_oft();

    /* Chequea si la cola esta vacia */
    if (srv.size() == 0) {
      /* La cola esta vacia entonces, pone el servidor en libre */
      srv.status = Server.IDLE;
      time_next_event.set(Programa.DEPART_OFT, 1.0e+30);
    } else {
      /*
       * Calcula el delay del cliente que esta comenzando a ser servido y
       * actualiza el acumulador del delay total
       */
      delay = time - cliente.getTime();
      total_of_delays += delay;
      /* programa la partida */
      time_next_event.set(Programa.DEPART_OFT, time
          + servers.get(Programa.DEPART_OFT).timeInServer(time));
    }
    servers.set(Programa.DEPART_OFT, srv);
    if (cliente.isFail_oft()) {
      this.arrive_e1(cliente);
      return;
    }
    if (cliente.isDo_psf()) {
      this.arrive_psf(cliente);
      return;
    }
    this.arrive_e2(cliente);
  }

  private void arrive_e2(Cliente cliente) throws Exception {
    Server srv = servers.get(Programa.DEPART_E2);
    srv.add(cliente);
    if (srv.status == Server.BUSY) {
      srv.status = Server.BUSY;
      /* Programa una partida (servicio completado) */
      double timeInServer = srv.timeInServer(time);
      time_next_event.set(Programa.DEPART_E2, timeInServer);
    }
    servers.set(Programa.DEPART_E2, srv);
  }

  private void arrive_psf(Cliente cliente) throws Exception {
    Server srv = servers.get(Programa.DEPART_PSF);
    srv.add(cliente);
    if (srv.status != Server.BUSY) {
      srv.status = Server.BUSY;
      /* Programa una partida (servicio completado) */
      double timeInServer = srv.timeInServer(time);
      time_next_event.set(Programa.DEPART_PSF, timeInServer);
    }
    servers.set(Programa.DEPART_PSF, srv);
  }

  private void arrive_e1(Cliente cliente) throws Exception {
    Server srv = servers.get(Programa.DEPART_E1);
    
    if (srv.status != Server.BUSY) {
      srv.status = Server.BUSY;
      cliente.setTime_last_stage(time);
      /* Programa una partida (servicio completado) */
      double timeInServer = srv.timeInServer(time);
      time_next_event.set(Programa.DEPART_E1, timeInServer);
    }
    srv.add(cliente);
    servers.set(Programa.DEPART_E1, srv);
  }

  private void depart_c(int cola) throws Exception {
    double delay;
    Cliente cliente = null;
    Server srv = servers.get(cola);
    /* SUPONGO QUE SI EL SERVIDOR ESTA ATENDIENDO, LA COLA TIENE UN CLIENTE */
    /* La cola no esta vacia. decrementa el numero de clientes en cola. */
    cliente = srv.remove();
    
    /* Chequea si la cola esta vacia */
    if (srv.size() == 0) {
      /* La cola esta vacia entonces, pone el servidor en libre */
      srv.status = Server.IDLE;
      time_next_event.set(cola, 1.0e+30);
    } else {
      /*
       * Calcula el delay del cliente que esta comenzando a ser servido y
       * actualiza el acumulador del delay total
       */
      delay = time - cliente.getTime();
      total_of_delays += delay;
      /* programa la partida */
      time_next_event.set(cola, time + srv.timeInServer(time));
    }
    servers.set(cola, srv);
    cliente.Pay();
    arrive_e2(cliente);

  }

  private void depart_e3() throws Exception {
    double delay;
    Cliente cliente = null;
    /* SUPONGO QUE SI EL SERVIDOR ESTA ATENDIENDO, LA COLA TIENE UN CLIENTE */
    /* La cola no esta vacia. decrementa el numero de clientes en cola. */
    Server srv = servers.get(Programa.DEPART_E3);
    cliente = srv.remove();
    
    /* si no completó el formulario: */
    if (!(cliente.getTime_last_stage() + cliente.getFormTime() < time)) {
      srv.swap(cliente);
      /* programa la partida */
      time_next_event.set(Programa.DEPART_E3, time + 0.1);
      servers.set(Programa.DEPART_E3, srv);
      return;
    }

    /* Chequea si la cola esta vacia */
    if (srv.size() == 0) {
      /* La cola esta vacia entonces, pone el servidor en libre */
      srv.status = Server.IDLE;
      time_next_event.set(Programa.DEPART_E3, 1.0e+30);
    } else {
      /*
       * Calcula el delay del cliente que esta comenzando a ser servido y
       * actualiza el acumulador del delay total
       */
      delay = time - cliente.getTime();
      total_of_delays += delay;
      /* programa la partida */
      time_next_event.set(Programa.DEPART_E3, time
          + srv.timeInServer(time));
    }
    servers.set(Programa.DEPART_E3, srv);
    arrive_oft(cliente);
  }

  private void arrive_oft(Cliente cliente) throws Exception {
    Server srv = servers.get(Programa.DEPART_OFT);
    srv.add(cliente);
    if (srv.status != Server.BUSY) {
      srv.status = Server.BUSY;
      /* Programa una partida (servicio completado) */
      double timeInServer = srv.timeInServer(time);
      time_next_event.set(Programa.DEPART_OFT, timeInServer);
    }
    
    servers.set(Programa.DEPART_OFT, srv);
  }

  private void depart_psf() throws Exception {
    double delay;
    Cliente cliente = null;
    Server srv = servers.get(Programa.DEPART_PSF); 
    /* SUPONGO QUE SI EL SERVIDOR ESTA ATENDIENDO, LA COLA TIENE UN CLIENTE */
    /* La cola no esta vacia. decrementa el numero de clientes en cola. */
    cliente = srv.remove();
    
    cliente.setFail_psf();

    /* Chequea si la cola esta vacia */
    if (srv.size() == 0) {
      /* La cola esta vacia entonces, pone el servidor en libre */
      srv.status = Server.IDLE;
      time_next_event.set(Programa.DEPART_PSF, 1.0e+30);
    } else {
      /*
       * Calcula el delay del cliente que esta comenzando a ser servido y
       * actualiza el acumulador del delay total
       */
      delay = time - cliente.getTime();
      total_of_delays += delay;
      /* programa la partida */
      time_next_event.set(Programa.DEPART_PSF, time
          + srv.timeInServer(time));
    }
    servers.set(Programa.DEPART_PSF, srv); 
    if (cliente.isFail_psf()) {
      this.arrive_e1(cliente);
      return;
    }
    this.arrive_e2(cliente);
  }

  private void depart_e2() throws Exception {
    double delay;
    Cliente cliente = null;
    Server srv = servers.get(Programa.DEPART_E2);
    /* SUPONGO QUE SI EL SERVIDOR ESTA ATENDIENDO, LA COLA TIENE UN CLIENTE */
    /* La cola no esta vacia. decrementa el numero de clientes en cola. */
    cliente = srv.remove();
    
    /* Chequea si la cola esta vacia */
    if (srv.size() == 0) {
      /* La cola esta vacia entonces, pone el servidor en libre */
      srv.status = Server.IDLE;
      time_next_event.set(Programa.DEPART_E2, 1.0e+30);
    } else {
      /*
       * Calcula el delay del cliente que esta comenzando a ser servido y
       * actualiza el acumulador del delay total
       */
      delay = time - cliente.getTime();
      total_of_delays += delay;
      /* programa la partida */
      time_next_event.set(Programa.DEPART_E2, time
          + srv.timeInServer(time));
    }
    servers.set(Programa.DEPART_E2, srv);
    if (cliente.isPaid())
      this.exit(cliente);
    else
      this.arrive_c(cliente);
  }

  private void arrive_c(Cliente cliente) throws Exception {
    int shorter = servers.get(Programa.DEPART_C1).size();
    int cola = Programa.DEPART_C1;
    int aux = 0;
    if (shorter > (aux = servers.get(Programa.DEPART_C2).size())) {
      shorter = aux;
      cola = Programa.DEPART_C2;
    }
    if (shorter > (aux = servers.get(Programa.DEPART_C3).size())) {
      cola = Programa.DEPART_C3;
      shorter = aux;
    }
    Server srv = servers.get(cola); 
    srv.add(cliente);
    /* hago el arrive en la cola mas corta entre C1 C2 y C3 */
    if (srv.status != Server.BUSY) {
      srv.status = Server.BUSY;
      /* Programa una partida (servicio completado) */
      double timeInServer = srv.timeInServer(time);
      time_next_event.set(cola, timeInServer);
    }
    servers.set(cola, srv);
  }

  private void exit(Cliente cliente) {
    // TODO Auto-generated method stub

  }
  

  private void depart_e1() throws Exception {
    double delay;
    Cliente cliente = null;
    Server srv = servers.get(Programa.DEPART_E1);
    /* SUPONGO QUE SI EL SERVIDOR ESTA ATENDIENDO, LA COLA TIENE UN CLIENTE */
    /* La cola no esta vacia. decrementa el numero de clientes en cola. */
    cliente = srv.remove();
    cliente.setTime_last_stage(time);
    /* Chequea si la cola esta vacia */
    if (srv.size() == 0) {
      /* La cola esta vacia entonces, pone el servidor en libre */
      srv.status = Server.IDLE;
      time_next_event.set(Programa.DEPART_E1, 1.0e+30);
    } else {
      /*
       * Calcula el delay del cliente que esta comenzando a ser servido y
       * actualiza el acumulador del delay total
       */
      delay = time - cliente.getTime();
      total_of_delays += delay;
      /* programa la partida */
      time_next_event.set(Programa.DEPART_E1, time
          + srv.timeInServer(time));
    }
    servers.set(Programa.DEPART_E1, srv);
    if (!cliente.isFail_oft() && !cliente.isFail_psf())
      this.arrive_e3(cliente);
    else
      this.exit(cliente);
  }
  

  private void arrive_e3(Cliente cliente) throws Exception {
    Server srv = servers.get(Programa.DEPART_E3);
    if(srv ==null){
      throw new Exception("srv es null");
    }
    if(cliente == null){
      throw new Exception("cliente es null");
    }
    srv.add(cliente);
    if (srv.status != Server.BUSY) {
      /* si ya completó el formulario: */
      if (cliente.getTime_last_stage() + cliente.getFormTime() < time) {
        srv.status = Server.BUSY;
        /* Programa una partida (servicio completado) */
        double timeInServer = srv.timeInServer(time);
        time_next_event.set(Programa.DEPART_E3, timeInServer);
      }
    }
    servers.set(Programa.DEPART_E3, srv);
  }
  

  void initialize() {
    /* Inicializa el reloj de la simulacion */
    this.time = BEGINS;
    /* Inicializa las variables de estado */
    this.time_last_event = 0.0;
    // TODO: las llegadas!
    this.r = new UniformServer(0.0833333333, 0.5);
    this.e1 = new ExpServer(0.05);
    this.e2 = new ExpServer(4);
     this.e3 = new ExpServer(4); //TODO: calcular
    this.oft = new ExpServer(3.5);
    this.psf = new ExpServer(8);
    this.c1 = new ExpServer(2.5);
    this.c2 = new ExpServer(2.5);
    this.c3 = new ExpServer(2.5);
    this.servers = new ArrayList<Server>(Programa.CANT_EVENTS);
    this.servers.ensureCapacity(Programa.CANT_EVENTS);
    this.servers.add(0, null);
    this.servers.add(1, null);
    this.servers.add(Programa.DEPART_R, r);
    this.servers.add(Programa.DEPART_E1, e1);
    this.servers.add(Programa.DEPART_E3, e3);
    this.servers.add(Programa.DEPART_OFT, oft);
    this.servers.add(Programa.DEPART_PSF, psf);
    this.servers.add(Programa.DEPART_E2, e2);
    this.servers.add(Programa.DEPART_C1, c1);
    this.servers.add(Programa.DEPART_C2, c2);
    this.servers.add(Programa.DEPART_C3, c3);
    /* Inicializa los contadores estadisticos */
    this.num_custs_delayed = 0;
    this.total_of_delays = 0.0;
    this.area_num_in_q = 0.0;
    this.area_server_status = 0.0;

    /*
     * Inicializa la lista de eventos. Como no hay clientes presentes, el evento
     * partida (completitud del servicio) es no considerado.
     */
    this.time_next_event = new ArrayList<Double>(Programa.CANT_EVENTS);
    this.time_next_event.add(0, null);
    this.time_next_event.add(Programa.ARRIVE, this.time);
    for (int i = 2; i <= Programa.CANT_EVENTS; i++) {
      this.time_next_event.add(i, 1.0e+30);
    }
  }

  void timing() throws Exception {
    int i;
    double min_time_next_event = 1.0e+29;
    int next_event_type = 0;
    /* Determina que tipo de evento sera el proximo */
    for (i = 1; i <= Programa.CANT_EVENTS; ++i) {
      if (time_next_event.get(i) < min_time_next_event) {
        min_time_next_event = time_next_event.get(i);
        next_event_type = i;
      }
    }
    /* Chequea si la lista de eventos esta vacia */
    if (next_event_type == 0) {
      this.FLAG_ENDS = true;
      throw new Exception("Lista de eventos vacia a los " + this.time + " minutos");
    }
    /* La lista de eventos no esta vacia, entonces avanza la simulacion */
    time = min_time_next_event;
    this.next_event_type = next_event_type;
  }

  void arrive_r() throws Exception {
    /* Programa el proximo arribo */
    Statistics s = new Statistics();
    if (this.time > Programa.ENDS) {// las 13 horas
      time_next_event.set(Programa.ARRIVE, 1.0e+30);
      return;
    }else{
      //TODO: ver cual es el lambda!!!!!
      time_next_event.set(Programa.ARRIVE, time + s.expon(3.0480));  
    }
    /* Chequea si el servidor R esta ocupado */
    Cliente cliente = new Cliente(time);
    /* siempre lo encolo */
    Server srv = servers.get(Programa.DEPART_R);
    srv.add(cliente);
    if (srv.status != Server.BUSY) {
      srv.status = Server.BUSY;
      /* Programa una partida (servicio completado) */
      double timeInServer = srv.timeInServer(this.time);
      time_next_event.set(Programa.DEPART_R, timeInServer);
    }
    servers.set(Programa.DEPART_R, srv);
    this.num_custs_delayed++; // cantidad de clientes que vinieron
    
  }

  void depart_r() throws Exception {
    double delay;
    Cliente cliente = null;
    Server srv = servers.get(Programa.DEPART_R);
    /* SUPONGO QUE SI EL SERVIDOR ESTA ATENDIENDO, LA COLA TIENE UN CLIENTE */
    /* La cola no esta vacia. decrementa el numero de clientes en cola. */
    cliente = srv.remove();
    
    /* Chequea si la cola esta vacia */
    if (srv.size() == 0) {
      /* La cola esta vacia entonces, pone el servidor en libre */
      srv.status = Server.IDLE;
      time_next_event.set(Programa.DEPART_R, 1.0e+30);
    } else {
      /*
       * Calcula el delay del cliente que esta comenzando a ser servido y
       * actualiza el acumulador del delay total
       */
      delay = time - cliente.getTime();
      total_of_delays += delay;
      /* programa la partida */
      time_next_event.set(Programa.DEPART_R, time
          + srv.timeInServer(time));
    }
    servers.set(Programa.DEPART_R, srv);
    /* si vino a buscar un formulario, se va; sino lo encolo en E1 */
    if (cliente.isR())
      this.arrive_e1(cliente);
    else
      this.exit(cliente);

  }
  

  void report() {
    // fprintf(outfile, "\n\nTiempo medio en cola: %16.3f minutos\n\n",
    // total_of_delays / num_custs_delayed);
    // fprintf(outfile, "Longitud media de la cola: %16.3f\n\n",
    // area_num_in_q / time);
    // fprintf(outfile, "Utilizacion del servidor: %16.3f\n\n",
    // area_server_status / time);
    // fprintf(outfile, "Simulacion finalizada a: %16.3f minutos", time);
  }

  void update_time_avg_stats() {
    // float time_since_last_event;
    //
    // /* Computa el tiempo desde el ultimo evento */
    //
    // time_since_last_event = time - time_last_event;
    // time_last_event = time;
    //
    // /* Acutualiza el area bajo num_in_q */
    //
    // area_num_in_q += num_in_q * time_since_last_event;
    //
    // /* Actualiza el area bajo la funcion de ocupacion del server */
    //
    // area_server_status += server_status * time_since_last_event;
  }

  
  boolean ends() {
    if(this.FLAG_ENDS == true ){
      System.out.println(this.time_next_event.toString());
      return true;
    }
    int cant = 0;
    if( this.time >= Programa.ENDS){
      for (Server s : this.servers){
        if (s != null)
          cant += s.size();
      }
      if (cant == 0 ) {
        return true;
      }
    }
    return false;
  }

}
