function report(outfile)
% Funcion:   report
% Proposito:
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
global total_people_sys;

fprintf(outfile, '\n\nTiempo medio en cola:   %16.3f minutos\n\n', ...
        total_of_delays / num_custs_delayed);
fprintf(outfile, 'Longitud media de la cola:  %16.3f\n\n', ...
		area_num_in_q / time);
fprintf(outfile, 'Utilizacion del servidor:   %16.3f\n\n', ...
		area_server_status / time);
fprintf(outfile, 'Simulacion finalizada a:    %16.3f minutos', time);

fprintf(outfile, '\n\nTiempo medio en cola2:   %16.3f minutos\n\n', ...
        total_of_delays2 / num_custs_delayed2);
fprintf(outfile, 'Longitud media de la cola2:  %16.3f\n\n', ...
		area_num_in_q2 / time);
fprintf(outfile, 'Utilizacion del servidor2:   %16.3f\n\n', ...
		area_server_status2 / time);
fprintf(outfile, 'Simulacion finalizada a:    %16.3f minutos\n\n', time);

fprintf(outfile, 'L (cant clientes en el sistema):   %16.3f\n\n', ...
		total_people_sys / time);

return;