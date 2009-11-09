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

clear next_event_type;
clear num_custs_delayed;
clear num_in_q;
clear server_status;

clear area_num_in_q;
clear area_num_in_s;
clear area_server_status;
clear time;
clear time_arrival;
clear time_last_event;
clear time_next_event;
clear total_of_delays;

clear arrival_time;
clear queue_departure_time;
clear system_departure_time;
clear arrival_time_len;
clear queue_departure_time_len;
clear system_departure_time_len;
clear num_custs_arrivals;

clear arrival_time;
clear queue_departure_time;
clear system_departure_time;
% Inicializa el reloj de la simulacion
time = 0.0;

% Inicializa las variables de estado del modelo
server_status   = IDLE;
num_in_q        = 0;
time_last_event = 0.0;

% Inicializa los contadores estadisticos
num_custs_delayed  = 0;
total_of_delays    = 0.0;
area_num_in_q      = 0.0;
area_num_in_s      = 0.0;
area_server_status = 0.0;

% Inicializa la lista de eventos
% Como no hay clientes presentes, el evento:partida (servicio completo),
% es eliminado de la consideracion.
time_next_event(1) = time + expon(mean_interarrival);
time_next_event(2) = 1.0e+030;

arrival_time_len = 0;
queue_departure_time_len = 0;
system_departure_time_len = 0;
num_custs_arrivals = 0;
