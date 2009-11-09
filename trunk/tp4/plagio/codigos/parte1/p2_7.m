load ../../datos_parte1/times;
load ../../datos_parte1/queue_len;
load ../../datos_parte1/time_p2;

len = length(times);
for i = 1:len
	if (times(i) == time)
		break
	end
end

fprintf(2, 'Numero maximo de clientes en cola: ');
max(queue_len)

plot(times(1:i), queue_len(1:i), '^;;');
xlabel('Tiempo [s]');
ylabel('Longitud de la cola');
gset encoding iso_8859_1; % Para que se banque tildes
gset terminal postscript eps enhanced color;
gset output '../../graficos_parte1/longitud_cola_vs_tiempo.eps';
replot;

