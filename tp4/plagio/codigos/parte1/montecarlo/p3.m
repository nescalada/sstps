load ../datos/q
load ../datos/l
load ../datos/b
load ../datos/time_arrivals

plot(time_arrivals, q, 'x;;');
xlabel('Número de clientes');
ylabel('Cantidad media de clientes en el sistema');
gset encoding iso_8859_1; % Para que se banque tildes
gset terminal postscript eps enhanced color;
gset output '../graficos/media_clientes_vs_tiempo.eps';
replot;

plot(time_arrivals, l, 'x;;');
xlabel('Número de clientes');
ylabel('Longitud media de la cola');
gset encoding iso_8859_1; % Para que se banque tildes
gset terminal postscript eps enhanced color;
gset output '../graficos/media_longitud_cola_vs_tiempo.eps';
replot;

plot(time_arrivals, b, 'x;;');
xlabel('Número de clientes');
ylabel('Ocupación media del servidor');
gset encoding iso_8859_1; % Para que se banque tildes
gset terminal postscript eps enhanced color;
gset output '../graficos/media_ocupacion_servidor_vs_tiempo.eps';
replot;
