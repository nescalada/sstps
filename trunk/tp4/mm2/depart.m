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

% Chequea si la cola esta vacia
	if ( num_in_q == 0)
		% La cola esta vacia entonces, pone el servidor en libre
		server_status      = IDLE;
		time_next_event(2) = 1.0e+30;
	else
		% La cola no esta vacia, entonces decrementa el numero de
		%  clientes en cola.
		num_in_q = num_in_q - 1;
		
		% Calcula el delay del cliente que esta comenzando a ser servido
		% y actualiza el acumulador del delay total
		delay            = time - time_arrival(1);
		total_of_delays = total_of_delays + delay;

		% Incrementa el numero de clientes atendidos y programa la
		%  partida.
		num_custs_delayed = num_custs_delayed + 1;
		time_next_event(2) = time + expon(mean_service);

		% Mueve cada cliente en la cola un lugar.
		for i = 1:num_in_q
			time_arrival(i) = time_arrival(i + 1);
		end
	end
return;

