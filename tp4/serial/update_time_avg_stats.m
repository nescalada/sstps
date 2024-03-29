function update_time_avg_stats()
% Funcion:   update_time_avg_stats
% Proposito: Actualiza los acumuladores estadisticos para las 
%            areas en el calculo de tiempos medios
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

% Computa el tiempo desde el ultimo evento
% y actualiza el markador de teiempo del
% ultimo evento.
time_since_last_event = time - time_last_event;
time_last_event       = time;

% Actualiza el area bajo la curva de numero en cola
area_num_in_q = area_num_in_q + num_in_q * time_since_last_event;
area_num_in_q2 = area_num_in_q2 + num_in_q2 * time_since_last_event;

% Actualiza el area bajo la curva de la funcio de servidor-ocupado
area_server_status = area_server_status + server_status * time_since_last_event;
area_server_status2 = area_server_status2 + server_status2 * time_since_last_event;

return;