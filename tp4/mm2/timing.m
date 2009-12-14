function  timing()
% Funcion:   timing
% Proposito:
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

min_time_next_event = 1.0e+029;
next_event_type     = 0;

% Determina el tipo de evento que sera el proximo evento a ocurrir
for i = 1:num_events
	if (time_next_event(i) < min_time_next_event)
		min_time_next_event = time_next_event(i);
		next_event_type     = i;
	end
	
end

% Chequea si la lista de eventos esta vacia
if ( next_event_type == 0 )
	
	% La lista de eventos esta vacia, entonces detenga la simulacion.
	fprintf(outfile,'\nLista de eventos vacia en el tiempo %f',time);
	return;
end

% La lista de eventos no esta vacia, entonces avanza el reloj de la simulacion
time = min_time_next_event;
return;
 
	
		