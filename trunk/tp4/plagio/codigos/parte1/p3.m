load ../../datos_parte1/q
load ../../datos_parte1/l
load ../../datos_parte1/b
load ../../datos_parte1/time_arrivals

closeplot;
%plot(time_arrivals, q, 'x;;');
length(q)
plot(1:length(q), q, 'x;;');
xlabel('Número de clientes');
ylabel('Cantidad media de clientes en el sistema');
gset encoding iso_8859_1; % Para que se banque tildes
gset terminal postscript eps enhanced color;
gset output '../../graficos_parte1/media_clientes_vs_tiempo.eps';
replot;

closeplot;
%plot(time_arrivals, l, 'x;;');
plot(1:length(l), l, 'x;;');
xlabel('Número de clientes');
ylabel('Longitud media de la cola');
gset encoding iso_8859_1; % Para que se banque tildes
gset terminal postscript eps enhanced color;
gset output '../../graficos_parte1/media_longitud_cola_vs_tiempo.eps';
replot;

closeplot;
%plot(time_arrivals, b, 'x;;');
plot(1:length(b), b, 'x;;');
xlabel('Número de clientes');
ylabel('Ocupación media del servidor');
gset encoding iso_8859_1; % Para que se banque tildes
gset terminal postscript eps enhanced color;
gset output '../../graficos_parte1/media_ocupacion_servidor_vs_tiempo.eps';
replot;
