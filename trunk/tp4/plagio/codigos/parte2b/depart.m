function depart()
% Funcion:   depart
% Proposito: Funcion de los eventos de partidas
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

global arrival_time;
global queue_departure_time;
global system_departure_time;
global arrival_time_len;
global queue_departure_time_len;
global system_departure_time_len;


if ( server_status == BUSY )
	system_departure_time(system_departure_time_len + 1) = time;
	system_departure_time_len++;
end

% Chequea si la cola esta vacia
	if ( num_in_q == 0)
		% La cola esta vacia entonces, pone el servidor en libre
		server_status      = IDLE;
		time_next_event(2) = 1.0e+30;
	else
		queue_departure_time(queue_departure_time_len + 1) = time;
		queue_departure_time_len++;
		% La cola no esta vacia, entonces decrementa el numero de
		%  clientes en cola.
		num_in_q = num_in_q - 1;
		
		% Calcula el delay del cliente que esta comenzando a ser servido
		% y actualiza el acumulador del delay total
		delay            = time - time_arrival(1);
		% Comentada esta linea para en vez de computar tiempo medio
		% en cola, calcular tiempo medio en sistema
		% total_of_delays = total_of_delays + delay;

		% Incrementa el numero de clientes atendidos y programa la
		%  partida.
		num_custs_delayed = num_custs_delayed + 1;
		time_next_event(2) = time + expon(mean_service);
		% Linea agregada para computar tiempo medio en sistema en vez
		% de tiempo medio en cola
		total_of_delays = total_of_delays + delay + (time_next_event(2) - time);


		% Mueve cada cliente en la cola un lugar.
		for i = 1:num_in_q
			time_arrival(i) = time_arrival(i + 1);
		end
	end
return;

