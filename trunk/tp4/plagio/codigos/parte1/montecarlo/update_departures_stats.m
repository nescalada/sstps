function update_departures_stats()
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

if(num_custs_delayed > 1)
	mrs(num_custs_delayed) = asimilar_media(mrs(num_custs_delayed-1), max(system_departure_time - arrival_time(1:system_departure_time_len)), num_custs_delayed-1);
else
	mrs(num_custs_delayed) = max(system_departure_time - arrival_time(1:system_departure_time_len));
end

retardo_sistema = system_departure_time-arrival_time(1:system_departure_time_len);
len = length(retardo_sistema);
if (len > 0)
	cant = 0;
	for i = 1:len
		if (retardo_sistema(i) > 1)
			cant++;
		end
	end
	if (num_custs_delayed> 1)
		prop_rc(num_custs_delayed) = asimilar_media(prop_rs(num_custs_delayed-1), cant/len, num_custs_delayed - 1);
	else
		prop_rc(num_custs_delayed) = cant/len;
	end
end

end;
