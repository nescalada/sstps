function ret = asimilar_varianza(media, datos, n)
% TODO: implementacion recursiva?
% Parametros de entrada:
% Parametros de salida:

	ret = 0;
	for i = 1:n
		ret += (datos(i)-media)^2;
	end
	ret = ret / (n-1);

end

