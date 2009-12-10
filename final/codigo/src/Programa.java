
public class Programa {
  static int ARRIVE_a = 1;
  static int ARRIVE_b = 2;
  static int DEPART_R = 3;
  static int DEPART_E1 = 4;
  static int DEPART_E3 = 5;
  static int DEPART_OFT = 6;
  static int DEPART_PSF = 7;
  static int DEPART_E2_c = 8;
  static int DEPART_E2_out = 9;
  static int DEPART_C1 = 10;
  static int DEPART_C2 = 11;
  static int DEPART_C3 = 12;
  static int CANT_EVENTS = 12;
  
  
  /**
   * @param args
   */
  public static void main(String[] args) {
//      /* Abre los archivos de entrada y salida */
//
//      infile   = fopen("mm1.inp","r");
//      outfile  = fopen("mm1.out","w");
//      timefile = fopen("mm1.tim","w");
//
//      /* Establece el numero de eventos */
//
//      num_events = 2;
//
//      /* Lee los parametros de entrada en mm1.in */
//
//      fscanf(infile, "%f %f %d", &mean_interarrival, &mean_service,
//                     &num_delays_required);
//
//      /* Escribe el encabezado del reporte de salida en mm1.out */
//
//      fprintf(outfile, "Sistema de cola con servidor simple\n\n");
//      fprintf(outfile, "Tiempo medio entre arribos: %16.3f minutos\n\n",
//          mean_interarrival);
//      fprintf(outfile, "Tiempo medio de servicio:   %16.3f minutos\n\n",
//          mean_service);
//      fprintf(outfile, "Numero de clientes:         %16d \n\n",
//          num_delays_required);
//
//      /* Escrible el encabezado del archivo con series de tiempo */
//
//      fprintf(timefile,"File:  mm1.tim   - Programa: mm1.c\n");
//      fprintf(timefile,"3\n");
//      fprintf(timefile,"Tiempo\n");
//      fprintf(timefile,"Longitud de la cola\n");
//      fprintf(timefile,"Ocupacion del servidor\n");
//
//      /* Inicializa la simulacion */
//
//      initialize();
//
//      /* Simulacion */
//
//      while ( num_custs_delayed < num_delays_required ) {
//
//        /* Determina el proximo evento */
//
//        timing();
//
//        /* Actualiza los acumuladores estadisticos de tiempos medios */
//
//        update_time_avg_stats();
//
//        /* Llama a la funcion de evento que corresponde */
//
//        switch (next_event_type) {
//          case 1:
//            arrive();
//            break;
//          case 2:
//            depart();
//            break;
//        }
//
//        /* Imprime las series de tiempo */
//
//        fprintf(timefile,"%12.3f  %4d  %d\n",time,num_in_q,server_status);
//
//      }

    /* Llama a la funcion que genera el reporte de salida y finaliza */

//    report();
//
//    fclose(infile);
//    fclose(outfile);
//    fclose(timefile);
//
//    return 0;
    
  }

  /* Funciones utilizadas
  --------------------

  Funcion initialize()
  Proposito: Inicializa el reloj de la simulacion, las variables
  de estado del modelo, los contadores estadisticos y la lista de
  eventos.
*/

  void initialize()
  {
   /* Inicializa el reloj de la simulacion */
  
  // time = 0.0;
  //
  // /* Inicializa las variables de estado */
  //
  // server_status   = IDLE;
  // num_in_q        = 0;
  // time_last_event = 0.0;
  //
  // /* Inicializa los contadores estadisticos */
  //
  // num_custs_delayed  = 0;
  // total_of_delays    = 0.0;
  // area_num_in_q      = 0.0;
  // area_server_status = 0.0;
  //
  // /* Inicializa la lista de eventos. Como no hay clientes
  //    presentes, el evento partida (completitud del servicio)
  //    es no considerado. */
  //
  // time_next_event[1] = time + expon(mean_interarrival);
  // time_next_event[2] = 1.0e+30;
  }

  void timing()
  {
//    int   i;
//    float min_time_next_event = 1.0e+29;
//
//    next_event_type = 0;
//
//    /* Determina que tipo de evento sera el proximo */
//
//    for ( i = 1; i <= num_events; ++i) {
//      if ( time_next_event[i] < min_time_next_event ) {
//        min_time_next_event = time_next_event[i];
//        next_event_type     = i;
//      }
//    }
//
//    /* Chequea si la lista de eventos esta vacia */
//
//    if ( next_event_type == 0 ) {
//
//      /* La lista de evento esta vacia, entonces para la simulacion */
//
//      fprintf(outfile, "\nLista de eventos vacia a los %f minutos",time);
//      exit(1);
//    }
//
//    /* La lista de eventos no esta vacia, entonces avanza la simulacion */
//
//    time = min_time_next_event;
  }

  void arrive()
  {
//    float delay;
//
//    /* Programa el proximo arribo */
//
//    time_next_event[1] = time + expon(mean_interarrival);
//
//    /* Chequea si el servidor esta ocupado */
//
//    if ( server_status == BUSY ) {
//
//      /* Si el servido esta ocupado: incrementa el numero de
//         clientes en la cola. */
//
//      ++num_in_q;
//
//      /* Chequea si no se excede la cantidad de clientes en cola */
//
//      if ( num_in_q > Q_LIMIT ) {
//
//        /* La cola alcanzo su limite, entonces para la simulacion */
//
//        fprintf(outfile, "\nOverflow de la cola a los %f minutos", time);
//        exit(2);
//      }
//
//      /* Hay lugar en la cola, entonces almacena el tiempo de llegada del
//         cliente en arribo en el nuevo tiempo de arribo */
//
//      time_arrival[num_in_q] = time;
//    }
//    else {
//
//      /* El servidor esta libre, entonces el cliente en arribo tiene un
//         delay igual a cero. */
//
//      delay            = 0.0;
//      total_of_delays += delay;
//
//      /* Incrementa el numero de clientes atendidos y pone el estatus
//         del servidor ocupado. */
//
//      ++num_custs_delayed;
//      server_status = BUSY;
//
//      /* Programa una partida (servicio completado) */
//
//      time_next_event[2] = time + expon(mean_service);
//    }
  }

  void depart()
  {
//    int   i;
//    float delay;
//
//    /* Chequea si la cola esta vacia */
//
//    if ( num_in_q == 0) {
//
//      /* La cola esta vacia entonces, pone el servidor en libre */
//
//      server_status      = IDLE;
//      time_next_event[2] = 1.0e+30;
//
//    }
//    else {
//
//      /* La cola no esta vacia, entonces decrementa el numero de
//         clientes en cola. */
//
//      --num_in_q;
//
//      /* Calcula el delay del cliente que esta comenzando a ser servido
//         y actualiza el acumulador del delay total */
//
//      delay            = time - time_arrival[1];
//      total_of_delays += delay;
//
//      /* Incrementa el numero de clientes atendidos y programa la
//         partida */
//
//      ++num_custs_delayed;
//      time_next_event[2] = time + expon(mean_service);
//
//      /* Mueve cada cliente en la cola un lugar */
//
//      for (i = 1; i <= num_in_q; ++i)
//        time_arrival[i] = time_arrival[i + 1];
//    }
  }

  void report()
  {
//    fprintf(outfile, "\n\nTiempo medio en cola:       %16.3f minutos\n\n",
//        total_of_delays / num_custs_delayed);
//    fprintf(outfile, "Longitud media de la cola:  %16.3f\n\n",
//        area_num_in_q / time);
//    fprintf(outfile, "Utilizacion del servidor:   %16.3f\n\n",
//        area_server_status / time);
//    fprintf(outfile, "Simulacion finalizada a:    %16.3f minutos", time);
  }

  void update_time_avg_stats()
  {
//    float time_since_last_event;
//
//    /* Computa el tiempo desde el ultimo evento */
//
//    time_since_last_event = time - time_last_event;
//    time_last_event       = time;
//
//    /* Acutualiza el area bajo num_in_q */
//
//    area_num_in_q += num_in_q * time_since_last_event;
//
//    /* Actualiza el area bajo la funcion de ocupacion del server */
//
//    area_server_status += server_status * time_since_last_event;
  }

  
  
}
