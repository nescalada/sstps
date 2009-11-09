function ret = asimilar_media(media_vieja, realizacion, n)
% Parametros de entrada:
	% media es la media muestral de la poblacion sin la nueva realizacion
	% realizacion es el nuevo dato
	% n es la cantidad de realizaciones realizadas sin considerar la nueva
% Parametros de salida:
	% ret es la nueva media muestral considerando la nueva realizacion
	ret = (media_vieja*n + realizacion)/(n + 1);

end

