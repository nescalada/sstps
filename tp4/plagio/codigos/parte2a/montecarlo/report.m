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

global num_custs_arrivals;
global mrc;
global mrs;
global prop_rc;
global prop_rs;

%fprintf(outfile, "\n\nTiempo medio en cola:   %16.3f minutos\n\n", ...
%        total_of_delays / num_custs_delayed);
fprintf(outfile, "\n\nTiempo medio en sistema:   %16.3f minutos\n\n", ...
        total_of_delays / num_custs_delayed);
fprintf(outfile, "Longitud media de la cola:  %16.3f\n\n", ...
		area_num_in_q / time);
fprintf(outfile, "Utilizacion del servidor:   %16.3f\n\n", ...
		area_server_status / time);
fprintf(outfile, "Simulacion finalizada a:    %16.3f minutos", time);


num_custs_arrivals--;

fprintf(1, 'maximo retardo en cola promedio: %.4f\n', mrc(num_custs_arrivals));
fprintf(1, 'maximo retardo en el sistema promedio: %.4f\n',
	mrs(num_custs_delayed));
fprintf(1, 'proporcion de clientes con retardo superior al minuto en cola: %.4f\n', prop_rc(num_custs_delayed));
fprintf(1, 'proporcion de clientes con retardo superior al minuto en el sistema: %.4f\n', prop_rs(num_custs_arrivals));

return;
