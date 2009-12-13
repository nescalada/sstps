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

  private ArrayList<ArrayList<Double>> vectores;

  /* estadisticos */
  int num_custs_delayed;
  double total_of_delays;
  double area_num_in_q;
  double area_server_status;
  int next_event_type;

  private FileOutputStream outfile; // declare a file output object

  private PrintStream p_out; // declare a print stream object

  ArrayList<Double> time_next_event;
  ArrayList<Server> servers;
  private boolean FLAG_ENDS;

  public Programa() {
    try {

      this.outfile = new FileOutputStream(
          "C:\\Users\\Lucila\\Documents\\simulacion de sistemas\\tp2\\final\\codigo\\src\\vectores.m");

      this.p_out = new PrintStream(outfile);

      this.FLAG_ENDS = false;
    } catch (Exception e) {
      e.printStackTrace();
    }
    vectores = new ArrayList<ArrayList<Double>>();
    for (int i = 0; i <= Programa.CANT_EVENTS; i++) {
      vectores.add(new ArrayList<Double>());
    }
  }

  public static void main(String[] args) {
    /* Abre los archivos de entrada y salida */
    Programa p = new Programa();
    /* Escribe el encabezado del reporte de salida en mm1.out */
    

    /* Inicializa la simulacion */
    p.initialize();

    /* Simulacion */
    while (!p.ends()) {
      /* Determina el proximo evento */
      try {

        p.timing();

        if (p.next_event_type != 0) {
          // en 0 va el tiempo
          p.vectores.get(0).add(p.time);
          for (int i = Programa.DEPART_R; i < Programa.CANT_EVENTS; i++) {
            p.vectores.get(i).add((double) p.servers.get(i).len());

          }
        }
        // /* Actualiza los acumuladores estadisticos de tiempos medios */
        // update_time_avg_stats();
        /* Llama a la funcion de evento que corresponde */

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

    System.out.println("fin!===>" + p.num_custs_delayed);
    p.printMatlab();
    p.p_out.close();
    /* Llama a la funcion que genera el reporte de salida y finaliza */
    // report();
    // fclose(infile);
    // fclose(outfile);
    // fclose(timefile);
  }

  private void printMatlab() {
    // imprimo los tiempos
    this.p_out.println("t = [");
    for (int i = 0; i < this.vectores.get(0).size(); i++) {
      this.p_out.println(this.vectores.get(0).get(i));
    }
    this.p_out.println("];");
    // imprimo las longitudes de las colas
    for (int i = Programa.DEPART_R; i <= Programa.CANT_EVENTS; i++) {
      this.p_out.println("x_" + i + " = [");
      for (int j = 0; j < this.vectores.get(i).size(); j++) {
        this.p_out.println(this.vectores.get(i).get(j));
      }
      this.p_out.println("];");
    }
    this.p_out.println("hold  on");
    this.p_out
        .println("plot(t,x_2, t, x_3 ,t, x_4,t, x_5 ,t, x_6,t, x_7, t, x_8,t,x_9);");
    this.p_out
        .println("legend('Recepcion', 'E1','E3','OFT','PSF','E2','C1','C2');");
    this.p_out.flush();
  }

  private void depart_oft() throws Exception {
    double delay;
    Cliente cliente = null;
    Server srv = servers.get(Programa.DEPART_OFT);
    /* SUPONGO QUE SI EL SERVIDOR ESTA ATENDIENDO, LA COLA TIENE UN CLIENTE */
    /* La cola no esta vacia. decrementa el numero de clientes en cola. */
    cliente = srv.remove();
    System.out.println("[" + cliente.getId() + "] depart_oft:" + this.time);
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
      time_next_event.set(Programa.DEPART_OFT, srv.timeInServer(time));
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
    if (srv.status != Server.BUSY) {
      srv.status = Server.BUSY;
      /* Programa una partida (servicio completado) */
      double timeInServer = srv.timeInServer(time);

      time_next_event.set(Programa.DEPART_E2, timeInServer);
    }
    System.out.println("[" + cliente.getId() + "] arrive_e2:" + this.time);
    servers.set(Programa.DEPART_E2, srv);
  }

  private void arrive_psf(Cliente cliente) throws Exception {
    Server srv = servers.get(Programa.DEPART_PSF);
    cliente.setFail_oft();
    srv.add(cliente);
    if (srv.status != Server.BUSY) {
      srv.status = Server.BUSY;
      /* Programa una partida (servicio completado) */
      double timeInServer = srv.timeInServer(time);
      time_next_event.set(Programa.DEPART_PSF, timeInServer);
    }
    System.out.println("[" + cliente.getId() + "] arrive_psf:" + this.time);
    servers.set(Programa.DEPART_PSF, srv);
  }

  private void arrive_e1(Cliente cliente) throws Exception {
    Server srv = servers.get(Programa.DEPART_E1);

    if (srv.status != Server.BUSY) {
      srv.status = Server.BUSY;
      cliente.setTime_receive_form(time);
      /* Programa una partida (servicio completado) */

      double timeInServer = srv.timeInServer(time);

      time_next_event.set(Programa.DEPART_E1, timeInServer);
    }
    srv.add(cliente);
    servers.set(Programa.DEPART_E1, srv);
    System.out.println("[" + cliente.getId() + "] arrive_e1:" + this.time);
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
      time_next_event.set(cola, srv.timeInServer(time));
    }
    System.out.println("[" + cliente.getId() + "] depart_c"+ cola+ ":" + this.time);
    servers.set(cola, srv);
    cliente.Pay();
    arrive_e2(cliente);

  }

  private void depart_e3() throws Exception {
    Server srv = servers.get(Programa.DEPART_E3);
    Cliente cliente = null;
    cliente = srv.remove();
    if (srv.size() == 0) {
      srv.status = Server.IDLE;
      this.time_next_event.set(Programa.DEPART_E3, 1.0e+30);
    } else {
      Cliente c = srv.q.get(0);
      int index = 0;
      boolean finish = false;
      // calculo el que primero termina de llenar el form
      for (int i = 1; i < srv.size() && !finish; i++) {
        if (c.getTimeFinishForm() < this.time) {
          finish = true;
          index = i;
        } else {
          if (c.getTimeFinishForm() < srv.q.get(i).getTimeFinishForm()) {
            c = srv.q.get(i);
            index = i;
          }
        }
      }
      // c es el cliente [index] que antes va a terminar der llenar el form
      c = srv.q.remove(index);
      srv.q.add(0, c);
      // si ya terminó el form, lo atiendo
      if (finish) {
        this.time_next_event.set(Programa.DEPART_E3, srv.timeInServer(time));
      } else {
        // no terminó el form.
        // el tiempo es el momento en que termina el form + lo que tarda en
        // atenderlo
        this.time_next_event.set(Programa.DEPART_E3, srv.timeInServer(c
            .getTimeFinishForm()));
      }

    }
    servers.set(Programa.DEPART_E3, srv);
    arrive_oft(cliente);

  }

  private void arrive_oft(Cliente cliente) throws Exception {
    Server srv = servers.get(Programa.DEPART_OFT);
    cliente.setFail_oft();
    srv.add(cliente);
    if (srv.status != Server.BUSY) {
      srv.status = Server.BUSY;
      /* Programa una partida (servicio completado) */
      double timeInServer = srv.timeInServer(time);
      time_next_event.set(Programa.DEPART_OFT, timeInServer);
    }
    System.out.println("[" + cliente.getId() + "] arrive_oft:" + this.time);
    servers.set(Programa.DEPART_OFT, srv);
  }

  private void depart_psf() throws Exception {
    double delay;
    Cliente cliente = null;
    Server srv = servers.get(Programa.DEPART_PSF);
    /* SUPONGO QUE SI EL SERVIDOR ESTA ATENDIENDO, LA COLA TIENE UN CLIENTE */
    /* La cola no esta vacia. decrementa el numero de clientes en cola. */
    cliente = srv.remove();
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
      time_next_event.set(Programa.DEPART_PSF, srv.timeInServer(time));
    }
    System.out.println("[" + cliente.getId() + "] depart_psf:" + this.time);
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
      time_next_event.set(Programa.DEPART_E2, srv.timeInServer(time));
    }
    System.out.println("[" + cliente.getId() + "] depart_e2:" + this.time);
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
    System.out.println("[" + cliente.getId() + "] arrive_c"+ cola+ ":" + this.time);
    servers.set(cola, srv);
  }

  private void exit(Cliente cliente) {
    System.out.println("[" + cliente.getId() + "] exit:" + this.time);
    // TODO Auto-generated method stub

  }

  private void depart_e1() throws Exception {
    double delay;
    Cliente cliente = null;
    Server srv = servers.get(Programa.DEPART_E1);
    /* SUPONGO QUE SI EL SERVIDOR ESTA ATENDIENDO, LA COLA TIENE UN CLIENTE */
    /* La cola no esta vacia. decrementa el numero de clientes en cola. */
    cliente = srv.remove();
    cliente.setTime_receive_form(time);
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
      time_next_event.set(Programa.DEPART_E1, srv.timeInServer(time));
    }
    servers.set(Programa.DEPART_E1, srv);
    System.out.println("[" + cliente.getId() + "] depart_e1:" + this.time);
    if (!cliente.isFail_oft() && !cliente.isFail_psf())
      this.arrive_e3(cliente);
    else
      this.exit(cliente);
  }

  private void arrive_e3(Cliente cliente) throws Exception {

    Server srv = servers.get(Programa.DEPART_E3);
    if (srv == null) {
      throw new Exception("srv es null");
    }
    if (cliente == null) {
      throw new Exception("cliente es null");
    }
    srv.add(cliente);

    if (srv.status != Server.BUSY) {

      srv.status = Server.BUSY;
      this.time_next_event.set(Programa.DEPART_E3, srv.timeInServer(cliente
          .getTimeFinishForm()));

    }
    // if (srv.status != Server.BUSY) {
    // /* si ya completó el formulario: */
    // if (cliente.getTime_receive_form() + cliente.getFormTime() < time) {
    // srv.status = Server.BUSY;
    // /* Programa una partida (servicio completado) */
    // double timeInServer = srv.timeInServer(time);
    // time_next_event.set(Programa.DEPART_E3, timeInServer);
    // }else{
    // time_next_event.set(Programa.DEPART_E3, cliente.getTime_receive_form()
    // + cliente.getFormTime());
    // }
    //      
    // }
    //    
    //    
    System.out.println("[" + cliente.getId() + "] arrive_e3!:" + this.time);
    servers.set(Programa.DEPART_E3, srv);
  }

  void initialize() {
    /* Inicializa el reloj de la simulacion */
    this.time = BEGINS;
    /* Inicializa las variables de estado */

    // TODO: las llegadas!
    this.r = new UniformServer(0.0833333333, 0.5);
    this.e1 = new ExpServer( 1/0.05);
    this.e2 = new ExpServer(1 / 4.0);
    this.e3 = new NormalServer(1.995, 0.00832); 
    this.oft = new ExpServer(1 / 3.5);
    this.psf = new ExpServer(1 / 8.0);
    this.c1 = new ExpServer(1 / 2.5);
    this.c2 = new ExpServer(1 / 2.5);
    this.c3 = new ExpServer(1 / 2.5);
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

    }
    /* La lista de eventos no esta vacia, entonces avanza la simulacion */
    time = min_time_next_event;
    this.next_event_type = next_event_type;
  }

  void arrive_r() throws Exception {
    /* Programa el proximo arribo */
    Statistics s = new Statistics();
    /* si son las 13 hs no se deja entrar a nadie mas */
    if (this.time >= Programa.ENDS   ) {// TODO:
      // DEBUG
      // las 13
      // horas
      time_next_event.set(Programa.ARRIVE, 1.0e+30);
      return;
    }
    
    time_next_event.set(Programa.ARRIVE, time + s.expon(0.31375));

    /* Chequea si el servidor R esta ocupado */
    Cliente cliente = new Cliente(time, this.num_custs_delayed);
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
    System.out.println("[" + cliente.getId() + "] arrive_r:" + this.time);
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
      time_next_event.set(Programa.DEPART_R, srv.timeInServer(time));
    }
    servers.set(Programa.DEPART_R, srv);
    System.out.println("[" + cliente.getId() + "] depart_r:" + this.time);
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
    if (this.FLAG_ENDS == true) {
      System.out.println("flaggg!!!");
      return true;
    }
    int cant = 0;
    if (this.time >= Programa.ENDS) {
      for (Server s : this.servers) {
        if (s != null)
          cant += s.size();
      }
      if (cant == 0) {
        return true;
      }
    }
    return false;
  }

}
