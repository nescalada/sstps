function depart2()
% Funcion:   depart
% Proposito: Funcion de los eventos de partidas
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
% Chequea si la cola esta vacia
	if ( num_in_q2 == 0)
		% La cola esta vacia entonces, pone el servidor en libre
		server_status2      = IDLE;
		time_next_event(3) = 1.0e+30;
	else
		% La cola no esta vacia, entonces decrementa el numero de
		%  clientes en cola.
		num_in_q2 = num_in_q2 - 1;
		
		% Calcula el delay del cliente que esta comenzando a ser servido
		% y actualiza el acumulador del delay total
		delay            = time - time_arrival2(1);
		total_of_delays2 = total_of_delays2 + delay;

		% Incrementa el numero de clientes atendidos y programa la
		%  partida.
		num_custs_delayed2 = num_custs_delayed2 + 1;
		time_next_event(3) = time + expon(mean_service2);

		% Mueve cada cliente en la cola un lugar.
		for i = 1:num_in_q2
			time_arrival2(i) = time_arrival2(i + 1);
		end
	end
return;

