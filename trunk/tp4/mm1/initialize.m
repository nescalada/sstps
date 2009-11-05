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
global area_server_status;
global mean_interarrival;
global mean_service;
global time;
global time_arrival;
global time_last_event;
global time_next_event;
global total_of_delays;

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
area_server_status = 0.0;

% Inicializa la lista de eventos
% Como no hay clientes presentes, el evento:partida (servicio completo),
% es eliminado de la consideracion.
time_next_event(1) = time + expon(mean_interarrival);
time_next_event(2) = 1.0e+030;
