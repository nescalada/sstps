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
global total_time_in_sistem;
%
Q_LIMIT = 100;
BUSY    = 1;
IDLE    = 0;
%jjj=1.0;
%while( jjj<=10)

% Abre los archivos I/O
inpfile = fopen('mm1.inp','r');
outfile = fopen('mm1.out','w');
timfile = fopen('mm1.tim','w');

% Especifica el numero de eventos
num_events = 2;

% Lee el archivo de entrada
xdata = fscanf(inpfile,'%f %f %f',[1 3]);
mean_interarrival   = xdata(1);%%%%%%%%%%%%%ESTE VALOR SE PISA!!!!!
mean_service        = xdata(2);
num_delays_required = xdata(3);


%mean_interval = jjj;

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
i=1;

%para calcular el promedio en cada iteracion
corte = false;
acum_media = 0;
acum_desv = 0;
media =0;
p_media(1) = 0;
p_desv(1) = 0;



% Corre la simulacion
while ( num_custs_delayed < num_delays_required )
	fprintf(timfile, '%16.3f %d %d\n',time,num_in_q,server_status);
    
   % if(num_in_q >0)
        plot_time(i) = time;
        plot_people(i) = i;
        plot_num_in_q(i) = num_in_q;
        plot_num_in_sis(i) = num_in_q + server_status;
        plot_server_status(i) = server_status;

        %promedio... acumulado y actual
        acum_media = acum_media + num_in_q;
        media = acum_media / i;
        p_media(i) = media;
        %desvio standard... idem
        acum_desv = acum_desv + ( num_in_q-media )^2;
        p_desv(i)=sqrt( acum_desv / (i -1));



        i= i+1;
   % end
    
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

hold on
%longitud de la cola en funcion del tiempo
plot(plot_time, plot_num_in_q);

%estado del servidor en funcion del tiempo
%plot(plot_time, plot_server_status);

%promedio de longitud de la cola segun el tiempo
%plot(plot_people, p_media);
%plot(plot_time, p_media);

%desvio de longitud de la cola segun el tiempo
%plot(plot_people, p_desv);

%cantidad de personasn el sistema en funcion del tiempo
plot(plot_time, plot_num_in_sis);



%Longitud media de la cola:  %16.3f\n\n', ...
%        rho =  mean_interval / mean_service;
%        plot_rho(jjj) = rho;
        
%		plot_longitud_media_cola(jjj) = area_num_in_q / time;
        
%        plot_L_teorico(jjj) = rho/(1-rho);
     
%       jjj=jjj+1; 
%end        
%hold on
%plot(plot_rho, plot_longitud_media_cola);
%plot(plot_rho, plot_L_teorico);
