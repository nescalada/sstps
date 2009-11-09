% Octave script: mm1.m
% Proposito:     Simula una cola M/M/1
%
% Declaracion de constantes y variables:
clear all

rand('seed', 3000);

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

global mrc;
global mrs;
global prop_rc;
global prop_rs;


i = 1;
num_arrivals = 0;


% Abre los archivos I/O
inpfile = fopen('mm1.inp','r');
outfile = fopen('mm1.out','w');
timfile = fopen('mm1.tim','w');

% Especifica el numero de eventos
num_events = 2;

% Lee el archivo de entrada
xdata = fscanf(inpfile,'%f %f %f',[1 3]);
mean_interarrival   = xdata(1);
mean_service        = xdata(2);
num_delays_required = xdata(3);
 

% Escribe los encabezados de los reportes y parametros de entrada
fprintf(outfile,'Sistema de cola de servidor simple\n\n');
fprintf(outfile,'Tiempo medio entre arribos %11.3f minutos\n\n',mean_interarrival);
fprintf(outfile,'Tiempo medio de servicio   %11.3f minutos\n\n',mean_service);
fprintf(outfile,'Numero de clientes         %14d\n\n', num_delays_required);

fprintf(timfile,'Series de tiempo producidas por mm1.m \n');
fprintf(timfile,'3\n');
fprintf(timfile,'time\n');
fprintf(timfile,'longitud de la cola\n');
fprintf(timfile,'ocupacion del servidor (OCUPADO=1,LIBRE=0)\n');

% Inicializa la simulacion
initialize();

% Corre la simulacion
while ( num_custs_delayed < num_delays_required )
	fprintf(timfile, "%16.3f %d %d\n",time,num_in_q,server_status);
	% Determina el proximo evento
	timing();
	
	% Actualiza los acumuladores estadisticos de tiempos medios
	update_time_avg_stats();
	
	% Invoca al evento apropiado
	switch (next_event_type)
		case 1
			arrive();
			num_arrivals++;
			if (num_arrivals == 10)
				save ../../datos_parte2a/time_p2 time;
			end
			l(num_custs_arrivals) = area_num_in_q / time;
			q(num_custs_arrivals) = area_num_in_s / time;
			b(num_custs_arrivals) = area_server_status / time;
			time_arrivals(num_custs_arrivals) = time;
			%update_arrivals_stats();
			% punto 3
			%break;
		case 2
			depart();
			%update_departures_stats();
			%break;
	endswitch

	times(i) = time;
	queue_len(i) = num_in_q;
	i++;
endwhile

% Invoca al generador de reportes y fin de la simulacion
report(outfile);
fclose(inpfile);
fclose(outfile);
fclose(timfile);

save ../../datos_parte2a/times times;
save ../../datos_parte2a/queue_len queue_len;

save ../../datos_parte2a/l l;
save ../../datos_parte2a/q q;
save ../../datos_parte2a/b b;
save ../../datos_parte2a/time_arrivals time_arrivals;

save ../../datos_parte2a/arrival_time arrival_time;
save ../../datos_parte2a/queue_departure_time queue_departure_time;
save ../../datos_parte2a/system_departure_time system_departure_time;

aux = arrival_time(1:num_delays_required);
save../../datos_parte2a/arrival_time aux;
aux = queue_departure_time(1:num_delays_required);
save../../datos_parte2a/queue_departure_time aux;
aux = system_departure_time(1:num_delays_required);
save../../datos_parte2a/system_departure_time aux;
