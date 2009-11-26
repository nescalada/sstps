function initialize()
% Funcion:   initilize
% Proposito: Inicializa el reloj de la simulacion
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%inicializo la semilla del rand

rand('seed', 5);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Inicializa el reloj de la simulacion
time = 0.0;

% Inicializa las variables de estado del modelo
server_status   = IDLE;
server_status2   = IDLE;
num_in_q        = 0;
num_in_q2        = 0;
time_last_event = 0.0;

% Inicializa los contadores estadisticos
num_custs_delayed  = 0;
total_of_delays    = 0.0;
area_num_in_q      = 0.0;
area_server_status = 0.0;
area_num_in_q2      = 0.0;
area_server_status2 = 0.0;
num_custs_delayed2  = 0;
total_of_delays2    = 0.0;



% Inicializa la lista de eventos
% Como no hay clientes presentes, el evento:partida (servicio completo),
% es eliminado de la consideracion.
time_next_event(1) = time + expon(mean_interarrival);
time_next_event(2) = 1.0e+030;
time_next_event(3) = 1.0e+030;
