import java.io.FileOutputStream;
import java.io.PrintStream;
import java.util.ArrayList;

public class Programa {
  static int ARRIVE = 1;
  static int DEPART_R = 2;
  static int DEPART_E1 = 3;
  static int DEPART_E3 = 4;
  static int DEPART_OFT = 5;
  static int DEPART_PSF = 6;
  static int DEPART_E2 = 7;
  static int DEPART_C1 = 8;
  static int DEPART_C2 = 9;
  static int DEPART_C3 = 10;
  static int CANT_EVENTS = 10;
  
  static double BEGINS = 8.0*60; //08:00 hs (en minutos)
  static double ENDS = 13.0*60;  //13:00 hs (en minutos)
  
  private Double time;
  private Server r, e1, e3, oft, psf, e2, c1, c2, c3;
  private Double time_last_event;

  /* estadisticos */
  int num_custs_delayed;
  double total_of_delays;
  double area_num_in_q;
  double area_server_status;
  
  private FileOutputStream outfile; // declare a file output object
  private FileOutputStream timefile; // declare a file output object
  private PrintStream p_out; // declare a print stream object
  private PrintStream p_time; // declare a print stream object
  
  ArrayList<Double> time_next_event;
  ArrayList<Server> servers;
  

  public Programa(){
    try{
    
      this.outfile = new FileOutputStream("mm1.out");
      this.timefile = new FileOutputStream("mm1.tim");
      this.p_out = new PrintStream( outfile );
      this.p_time = new PrintStream( timefile);
    }catch(Exception e){
      e.printStackTrace();
    }
    
  }
  
  public void main(String[] args) {
    /* Abre los archivos de entrada y salida */
    new Programa();
    
    /* Escribe el encabezado del reporte de salida en mm1.out */
    this.p_out.println("Sistema de cola con servidor simple\n\n"); 
    /* Escrible el encabezado del archivo con series de tiempo */
    this.p_time.println("File: mm1.tim - Programa: mm1.c\n");
    this.p_time.println("3\n");
    this.p_time.println("Tiempo\n");
    this.p_time.println("Longitud de la cola\n");
    this.p_time.println("Ocupacion del servidor\n");
    /* Inicializa la simulacion */
    initialize();
    /* Simulacion */
    while ( ends() ) {//TODO: haya alguien en el sistema. entran mientras sea mas temprano qe las 13 hs
    /* Determina el proximo evento */
    try{
      this.timing();
    }catch(Exception e){
      this.p_out.println(e);
      p_out.close();
    }
    //
    // /* Actualiza los acumuladores estadisticos de tiempos medios */
    //
    // update_time_avg_stats();
    //
    // /* Llama a la funcion de evento que corresponde */
    //
    // switch (next_event_type) {
    // case 1:
    // arrive();
    // break;
    // case 2:
    // depart();
    // break;
    // }
    //
    // /* Imprime las series de tiempo */
    //
    // fprintf(timefile,"%12.3f %4d %d\n",time,num_in_q,server_status);
    //
    }

    /* Llama a la funcion que genera el reporte de salida y finaliza */

    // report();
    //
    // fclose(infile);
    // fclose(outfile);
    // fclose(timefile);
    //
    // return 0;
  }

  void initialize() {
    /* Inicializa el reloj de la simulacion */
    this.time = BEGINS;
    /* Inicializa las variables de estado */
    this.time_last_event = 0.0;
    //TODO: las llegadas!
    this.r = new UniformServer(0.0833333333, 0.5);
    this.e1 = new ExpServer(0.05);
    this.e2 = new ExpServer(4);
   // this.e3 = new Server(); //TODO: calcular
    this.oft = new ExpServer(3.5);
    this.psf = new ExpServer(8);
    this.c1 = new ExpServer(2.5);
    this.c2 = new ExpServer(2.5);
    this.c3 = new ExpServer(2.5);
    this.servers = new ArrayList<Server>();
    this.servers.add(r);
    this.servers.add(e1);
    this.servers.add(e2);
    this.servers.add(e3);
    this.servers.add(oft);
    this.servers.add(psf);
    this.servers.add(c1);
    this.servers.add(c2);
    this.servers.add(c3);
    /* Inicializa los contadores estadisticos */
    this.num_custs_delayed = 0;
    this.total_of_delays = 0.0;
    this.area_num_in_q = 0.0;
    this.area_server_status = 0.0;

    /*
     * Inicializa la lista de eventos. Como no hay clientes presentes, el evento
     * partida (completitud del servicio) es no considerado.
     */
    this.time_next_event = new ArrayList<Double>();
    this.time_next_event.add(1, 0.0);
    for (int i = 2; i <= Programa.CANT_EVENTS; i++) {
      this.time_next_event.add(i, 1.0e+30);
    }
      
    
  }

  void timing()
    throws Exception{
    int i;
    double min_time_next_event = 1.0e+29;
    int next_event_type = 0;
    /* Determina que tipo de evento sera el proximo */
    for ( i = 1; i <= Programa.CANT_EVENTS; ++i) {
      if ( time_next_event.get(i) < min_time_next_event ) {
        min_time_next_event = time_next_event.get(i);
        next_event_type = i;
      }
    }
    /* Chequea si la lista de eventos esta vacia */
    if ( next_event_type == 0 ) {
      throw new Exception("Lista de eventos vacia a los " +time +"minutos");
    }
    /* La lista de eventos no esta vacia, entonces avanza la simulacion */
    time = min_time_next_event;
  }

  void arrive_r() {
    float delay;
    /* Programa el proximo arribo */
    
    
    //
    // time_next_event[1] = time + expon(mean_interarrival);
    //
    // /* Chequea si el servidor esta ocupado */
    //
    // if ( server_status == BUSY ) {
    //
    // /* Si el servido esta ocupado: incrementa el numero de
    // clientes en la cola. */
    //
    // ++num_in_q;
    //
    // /* Chequea si no se excede la cantidad de clientes en cola */
    //
    // if ( num_in_q > Q_LIMIT ) {
    //
    // /* La cola alcanzo su limite, entonces para la simulacion */
    //
    // fprintf(outfile, "\nOverflow de la cola a los %f minutos", time);
    // exit(2);
    // }
    //
    // /* Hay lugar en la cola, entonces almacena el tiempo de llegada del
    // cliente en arribo en el nuevo tiempo de arribo */
    //
    // time_arrival[num_in_q] = time;
    // }
    // else {
    //
    // /* El servidor esta libre, entonces el cliente en arribo tiene un
    // delay igual a cero. */
    //
    // delay = 0.0;
    // total_of_delays += delay;
    //
    // /* Incrementa el numero de clientes atendidos y pone el estatus
    // del servidor ocupado. */
    //
    // ++num_custs_delayed;
    // server_status = BUSY;
    //
    // /* Programa una partida (servicio completado) */
    //
    // time_next_event[2] = time + expon(mean_service);
    // }
  }

  void depart() {
    // int i;
    // float delay;
    //
    // /* Chequea si la cola esta vacia */
    //
    // if ( num_in_q == 0) {
    //
    // /* La cola esta vacia entonces, pone el servidor en libre */
    //
    // server_status = IDLE;
    // time_next_event[2] = 1.0e+30;
    //
    // }
    // else {
    //
    // /* La cola no esta vacia, entonces decrementa el numero de
    // clientes en cola. */
    //
    // --num_in_q;
    //
    // /* Calcula el delay del cliente que esta comenzando a ser servido
    // y actualiza el acumulador del delay total */
    //
    // delay = time - time_arrival[1];
    // total_of_delays += delay;
    //
    // /* Incrementa el numero de clientes atendidos y programa la
    // partida */
    //
    // ++num_custs_delayed;
    // time_next_event[2] = time + expon(mean_service);
    //
    // /* Mueve cada cliente en la cola un lugar */
    //
    // for (i = 1; i <= num_in_q; ++i)
    // time_arrival[i] = time_arrival[i + 1];
    // }
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
  
  boolean ends(){
    int cant=0;
    for(Server s: this.servers )
      cant += s.q.size();
    if(cant == 0){
      return true;
    }
    return false;
  }

}
