% Matlab script: mm1.m
% Proposito: Simula un modelo de cola con servidor simple del tipo
%			  M/M/1 con disciplina FIFO.
%			  Lee el archivo de entrada mm1.inp donde en el primer registro
%			  aparecen, separados por espacios: tiempo medio entre arribos,
%			  tiempo medio de servicio y numero de clientes total procesados.
%			  La salida de la simulacion se da en dos archivos:
%			  mm1.out: Muestra valores estadisticos computados
%			  mm1.tim: Muestra la series de tiempo resultado de la simulacion
%
%			  Adaptado de "Simulation Modeling & Analysis", Law y Kelton.Proposito:     Simula una cola M/M/1
%
% Funciones utilizadas:
% arrive.m
% depart.m
% expon.m
% initialize.m
% report.m
% timing.m
% update_time_avg_stats.m
%
% Autor: Alejandro Diaz
% Declaracion de constantes y variables:
clear all

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

%
Q_LIMIT = 100;
BUSY    = 1;
IDLE    = 0;

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
	fprintf(timfile, '%16.3f %d %d\n',time,num_in_q,server_status);
	% Determina el proximo evento
	timing();

	% Actualiza los acumuladores estadisticos de tiempos medios
	update_time_avg_stats();

	% Invoca al evento apropiado
	switch (next_event_type)
		case 1
			arrive();
			%break;
		case 2
			depart();
			%break;
    end
end

% Invoca al generador de reportes y fin de la simulacion
report(outfile);
fclose(inpfile);
fclose(outfile);
fclose(timfile);