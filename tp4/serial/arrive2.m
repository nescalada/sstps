function arrive2()
% Funcion:   arrive
% Proposito: Funcion de los eventos de arribos
%
%
global Q_LIMIT;
global BUSY;
global IDLE;

global next_event_type;
global num_custs_delayed;
global num_custs_delayed2;
global num_delays_required;
global num_events;
global num_in_q;
global num_in_q2;
global server_status;
global server_status2;

global area_num_in_q;
global area_server_status;
global area_num_in_q2;
global area_server_status2;
global mean_interarrival;
global mean_service;
global mean_service2;
global time;
global time_arrival;
global time_arrival2;
global time_last_event;
global time_next_event;
global total_of_delays;
global total_of_delays2;

% Chequea si el servidor esta ocupado 
if ( server_status2 == BUSY )
	% Si el servido esta ocupado: incrementa el numero de
	% clientes en la cola.
	 num_in_q2 = num_in_q2 + 1;

	 % Chequea si no se excede la cantidad de clientes en cola
	 if ( num_in_q2 > Q_LIMIT )
	 	% La cola alcanzo su limite, entonces para la simulacion
	 	fprintf(outfile, '\nOverflow de la cola a los %f minutos', time);
		return;
	end
	% Hay lugar en la cola, entonces almacena el tiempo de llegada del
	% cliente en arribo en el nuevo tiempo de arribo
		time_arrival2(num_in_q2) = time;
else
	% El servidor esta libre, entonces el cliente en arribo tiene un
	% delay igual a cero.
	delay            = 0.0;
	total_of_delays2 = total_of_delays2 + delay;

	% Incrementa el numero de clientes atendidos y pone el estatus
	% del servidor ocupado.
	num_custs_delayed2 =num_custs_delayed2 + 1;
	server_status2 = BUSY;
	
	% Programa una partida (servicio completado)
	time_next_event(3) = time + expon(mean_service2);
    
end
return;