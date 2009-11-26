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
global total_time_in_sistem;

fprintf(outfile, '\n\nTiempo medio en cola:   %16.3f minutos\n\n', ...
        total_of_delays / num_custs_delayed);
fprintf(outfile, 'Longitud media de la cola:  %16.3f\n\n', ...
		area_num_in_q / time);
fprintf(outfile, 'Utilizacion del servidor:   %16.3f\n\n', ...
		area_server_status / time);
fprintf(outfile, 'Simulacion finalizada a:    %16.3f minutos\n\n', time);
fprintf(outfile, 'Tiempo medio en el sistema (L):    %16.3f minutos', ...
    total_time_in_sistem / num_custs_delayed);


return;