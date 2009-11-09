clear all;

rand('seed', 3000);


i = 1;
salir = 0;
cota = 0.005;
while(i < 300 && salir == 0)
	[amrc amrs aprop_rc aprop_rs atiempo_medio amax_cola] = mm1();
	if (i == 1)
		mrc(1) = amrc;
		mrs(1) = amrs;
		prop_rc(1) = aprop_rc;
		prop_rs(1) = aprop_rs;
		tiempo_medio(1) = atiempo_medio;
		max_cola(1) = amax_cola;

		var_mrc(1) = 0;
		var_mrs(1) = 0;
		var_prop_rc(1) = 0;
		var_prop_rs(1) = 0;
		var_corte(1) = 0;
		var_tiempo_medio(1) = 0;
		var_max_cola(1) = 0;
	else
		mrc(i)=asimilar_media(mrc(i-1), amrc, i-1);
		mrs(i)=asimilar_media(mrs(i-1), amrs, i-1);
		prop_rc(i)=asimilar_media(prop_rc(i-1), aprop_rc, i-1);
		prop_rs(i)=asimilar_media(prop_rs(i-1), aprop_rs, i-1);
		tiempo_medio(i)=asimilar_media(tiempo_medio(i-1), atiempo_medio, i-1);
		max_cola(i)=asimilar_media(max_cola(i-1), amax_cola, i-1);

		var_mrc(i)=asimilar_varianza(mrc(i), mrc, i);
		var_mrs(i)=asimilar_varianza(mrs(i), mrs, i);
		var_prop_rc(i)=asimilar_varianza(prop_rc(i), prop_rc, i);
		var_prop_rs(i)=asimilar_varianza(prop_rs(i), prop_rs, i);
		var_tiempo_medio(i)=asimilar_varianza(tiempo_medio(i), tiempo_medio, i);
		var_max_cola(i)=asimilar_varianza(max_cola(i), max_cola, i);
		var_corte(i) = sqrt(var_mrc(i)^2 + var_mrs(i)^2 + var_prop_rc(i)^2 + var_prop_rs(i)^2 + var_tiempo_medio(i)^2 + var_max_cola(i)^2);
	end

	if (i > 10 && abs(var_corte(i) - var_corte(i-1)) < cota)
		salir = 1;
	end
	i++;
end
i--;
resultados = [mrc(i) mrs(i) prop_rc(i) prop_rs(i) tiempo_medio(i) max_cola(i) i  var_mrc(i) var_mrs(i) var_prop_rc(i) var_prop_rs(i) var_tiempo_medio(i) var_max_cola(i)];

save ../../../datos_parte2a/var_corte var_corte;
save ../../../datos_parte2a/resultados resultados;

