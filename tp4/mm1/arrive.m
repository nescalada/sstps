function arrive()
% Funcion:   arrive
% Proposito: Funcion de los eventos de arribos
%
%
global Q_LIMIT;
global BUSY;
global IDLE;

global next_event_type;
global num_custs_delayed;
global num_delays_required;
global num_events;
global num_in_q;
global server_status;

global area_num_in_q;
global area_server_status;
global mean_interarrival;
global mean_service;
global time;
global time_arrival;
global time_last_event;
global time_next_event;
global total_of_delays;

% Programa el proximo arrivo
time_next_event(1) = time + expon(mean_interarrival);

% Chequea si el servidor esta ocupado 
if ( server_status == BUSY )
	% Si el servido esta ocupado: incrementa el numero de
	% clientes en la cola.
	 num_in_q = num_in_q + 1;

	 % Chequea si no se excede la cantidad de clientes en cola
	 if ( num_in_q > Q_LIMIT )
	 	% La cola alcanzo su limite, entonces para la simulacion
	 	fprintf(outfile, '\nOverflow de la cola a los %f minutos', time);
		return;
	end
	% Hay lugar en la cola, entonces almacena el tiempo de llegada del
	% cliente en arribo en el nuevo tiempo de arribo
		time_arrival(num_in_q) = time;
else
	% El servidor esta libre, entonces el cliente en arribo tiene un
	% delay igual a cero.
	delay            = 0.0;
	total_of_delays = total_of_delays + delay;

	% Incrementa el numero de clientes atendidos y pone el estatus
	% del servidor ocupado.
	num_custs_delayed =num_custs_delayed + 1;
	server_status = BUSY;
	
	% Programa una partida (servicio completado)
	time_next_event(2) = time + expon(mean_service);
end
return;