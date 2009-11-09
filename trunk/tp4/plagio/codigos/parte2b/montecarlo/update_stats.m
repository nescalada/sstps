function update_arrivals_stats()
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

l(num_custs_arrivals) = area_num_in_q / time;
q(num_custs_arrivals) = area_num_in_s / time;
b(num_custs_arrivals) = area_server_status / time;
time_arrivals(num_custs_arrivals) = time;

if(num_custs_arrivals > 1)
	mrc(num_custs_arrivals) = asimilar_media(mrc(num_custs_arrivals-1),max(queue_departure_time - arrival_time), num_custs_arrivals-1);
else
	mrc(num_custs_arrivals) = max(queue_departure_time - arrival_time);
end

if(num_custs_arrivals > 1)
	mrs(num_custs_arrivals) = asimilar_media(mrs(num_custs_arrivals-1), max(system_departure_time - arrival_time), num_custs_arrivals-1);
else
	1
	num_custs_arrivals
	arrival_time
	max(system_departure_time - arrival_time)
	mrs(num_custs_arrivals) = max(system_departure_time - arrival_time)
	2
end

retardo_sistema = system_departure_time-arrival_time;
len = length(retardo_sistema);
if (len > 0)
	cant = 0;
	for i = 1:len
		if (retardo_sistema(i) > 1)
			cant++;
		end
	end
	if (num_custs_arrivals > 1)
		prop_rc(num_custs_arrivals) = asimilar_media(prop_rs(num_custs_arrivals-1), cant/len, num_custs_delayed - 1);
	else
		prop_rc(num_custs_arrivals) = cant/len;
	end
end

retardo_cola = queue_departure_time-arrival_time;
len = length(retardo_cola);
if (len > 0)
	cant = 0;
	for i = 1:len
		if (retardo_cola(i) > 1)
			cant++;
		end
	end
	if (num_custs_arrivals > 1)
		prop_rs(num_custs_arrivals) = asimilar_media(prop_rs(num_custs_arrivals-1), cant/len, num_custs_delayed - 1);
	else
		prop_rs(num_custs_arrivals) = cant/len;
	end	
end


end;
