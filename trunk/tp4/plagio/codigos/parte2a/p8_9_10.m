% Cargar los datos de la simulacion
load ../../datos_parte2a/arrival_time;
arrival_time = aux;
load ../../datos_parte2a/queue_departure_time;
queue_departure_time = aux;
load ../../datos_parte2a/system_departure_time;
system_departure_time = aux;

fprintf(2, 'Maximo retardo en cola %.4f\n', max(queue_departure_time - arrival_time));
fprintf(2, 'Maximo retardo en el sistema %.4f\n', max(system_departure_time - arrival_time));

retardo_sistema = system_departure_time-arrival_time;
retardo_cola = queue_departure_time-arrival_time;

len = length(retardo_sistema);
cant = 0;
for i = 1:len
	if (retardo_sistema(i) > 1)
		cant++;
	end
end
fprintf(2, 'Proporcion de clientes con retardo de sistema mayor a 1 minuto: %.4f\n', cant/len);

len = length(retardo_cola);
cant = 0;
for i = 1:len
	if (retardo_cola(i) > 1)
		cant++;
	end
end
fprintf(2, 'Proporcion de clientes con retardo de cola mayor a 1 minuto: %.4f\n', cant/len);
