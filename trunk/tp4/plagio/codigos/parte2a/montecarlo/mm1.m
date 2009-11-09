function [mrc mrs prop_rc prop_rs tiempo_medio max_cola] = mm1()

% Octave script: mm1.m
% Proposito:     Simula una cola M/M/1
%
% Declaracion de constantes y variables:

global Q_LIMIT = 100;
global BUSY    = 1;
global IDLE    = 0;

global next_event_type;
global num_custs_delayed;
global num_delays_required;
global num_events;
global num_in_q;
global server_status;

global area_num_in_q;
global area_num_in_s;
global area_server_status;
global mean_interarrival;
global mean_service;
global time;
global time_arrival;
global time_last_event;
global time_next_event;
global total_of_delays;

global arrival_time;
global queue_departure_time;
global system_departure_time;
global arrival_time_len;
global queue_departure_time_len;
global system_departure_time_len;
global num_custs_arrivals;

i = 1;
num_arrivals = 0;

% Especifica el numero de eventos
num_events = 2;

% Lee el archivo de entrada
mean_interarrival   = 1;
mean_service        = 0.5;
num_delays_required = 100;
%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Inicializa la simulacion
time = 0.0;

% Inicializa las variables de estado del modelo
server_status   = IDLE;
num_in_q        = 0;
time_last_event = 0.0;

% Inicializa los contadores estadisticos
num_custs_delayed  = 0;
total_of_delays    = 0.0;
area_num_in_q      = 0.0;
area_num_in_s      = 0.0;
area_server_status = 0.0;

% Inicializa la lista de eventos
% Como no hay clientes presentes, el evento:partida (servicio completo),
% es eliminado de la consideracion.
time_next_event(1) = time + expon(mean_interarrival);
time_next_event(2) = 1.0e+030;

arrival_time_len = 0;
queue_departure_time_len = 0;
system_departure_time_len = 0;
num_custs_arrivals = 0;
max_cola = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%

% Corre la simulacion
while ( num_custs_delayed < num_delays_required )
	% Determina el proximo evento
	timing();
	
	% Actualiza los acumuladores estadisticos de tiempos medios
	update_time_avg_stats();
	
	% Invoca al evento apropiado
	switch (next_event_type)
		case 1
			arrive();
			num_arrivals++;
			if (max_cola < num_in_q)
				max_cola = num_in_q;
			end
		case 2
			depart();
	endswitch

	times(i) = time;
	queue_len(i) = num_in_q;
	i++;
endwhile

queue_departure_time = queue_departure_time(1:queue_departure_time_len);
system_departure_time = system_departure_time(1:system_departure_time_len);

% Computar salidas
retardo_cola = queue_departure_time-arrival_time(1:queue_departure_time_len);
mrc = max(retardo_cola);
retardo_sistema = system_departure_time-arrival_time(1:system_departure_time_len);
mrs = max(retardo_sistema);

cant = 0;
for i = 1:queue_departure_time_len
	if (retardo_cola(i) > 1)
		cant++;
	end
end
prop_rc = cant/queue_departure_time_len;

cant = 0;
for i = 1:system_departure_time_len
	if (retardo_sistema(i) > 1)
		cant++;
	end
end
prop_rs = cant/system_departure_time_len;


tiempo_medio = total_of_delays / num_custs_delayed;


end
