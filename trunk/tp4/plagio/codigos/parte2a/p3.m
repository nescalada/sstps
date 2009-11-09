load ../../datos_parte2a/q
load ../../datos_parte2a/l
load ../../datos_parte2a/b
load ../../datos_parte2a/time_arrivals

closeplot;
%plot(time_arrivals, q, 'x;;');
plot(1:length(q), q, 'x;;');
xlabel('Número de clientes');
ylabel('Cantidad media de clientes en el sistema');
gset encoding iso_8859_1; % Para que se banque tildes
gset terminal postscript eps enhanced color;
gset output '../../graficos_parte2a/media_clientes_vs_tiempo.eps';
replot;

closeplot;
%plot(time_arrivals, l, 'x;;');
plot(1:length(l), l, 'x;;');
xlabel('Número de clientes');
ylabel('Longitud media de la cola');
gset encoding iso_8859_1; % Para que se banque tildes
gset terminal postscript eps enhanced color;
gset output '../../graficos_parte2a/media_longitud_cola_vs_tiempo.eps';
replot;

closeplot;
%plot(time_arrivals, b, 'x;;');
plot(1:length(b), b, 'x;;');
xlabel('Número de clientes');
ylabel('Ocupación media del servidor');
gset encoding iso_8859_1; % Para que se banque tildes
gset terminal postscript eps enhanced color;
gset output '../../graficos_parte2a/media_ocupacion_servidor_vs_tiempo.eps';
replot;
