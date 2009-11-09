load ../../../datos_parte2b/var_corte;
load ../../../datos_parte2b/resultados;

x = 1.96;
% computar desvios standars
for i = 8:length(resultados)
	resultados(i) = sqrt(resultados(i));
end
i = resultados(7);
fprintf(1, 'cantidad necesaria de iteraciones: %d\n', i);
fprintf(1, 'maximo retardo en cola promedio: %.6f +- %.6f\n', resultados(1), x*resultados(8)/sqrt(i));
fprintf(1, 'maximo retardo en el sistema promedio: %.6f +-%.6f\n',
	resultados(2), x*resultados(9)/sqrt(i));
fprintf(1, 'proporcion de clientes con retardo superior al minuto en cola: %.6f +- %.6f\n', resultados(3), resultados(10)*x/sqrt(i));
fprintf(1, 'proporcion de clientes con retardo superior al minuto en el sistema: %.6f +- %.6f\n', resultados(4), resultados(11)*x/sqrt(i));
fprintf(1, 'Tiempo medio de un cliente en el sistema: %.6f +- %.6f\n', resultados(5), resultados(12)*x/sqrt(i));
fprintf(1, 'Longitud maxima de la cola: %.6f +- %.6f\n', resultados(6), resultados(13)*x/sqrt(i));




plot(1:length(var_corte), var_corte, 'x;;');
xlabel('Cantidad de realizaciones');
ylabel('Módulo de las varianzas de los estimadores');
gset encoding iso_8859_1; % Para que se banque tildes
gset terminal postscript eps enhanced color;
gset output '../../../graficos_parte2b/modulo_varianza_vs_realizaciones.eps';
replot;

