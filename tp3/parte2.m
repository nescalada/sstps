format long 

CORRIDAS = 10000;

%generacion de las uniformes (con semmillas distintas)

u1=mi_uniforme(23,  CORRIDAS);
u2=mi_uniforme(2,  CORRIDAS);
u3=mi_uniforme( 5,  CORRIDAS);
u4=mi_uniforme(17,  CORRIDAS);
u5=mi_uniforme( 7,  CORRIDAS);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%camaras de dilitio. uniforme entre a y b
x1 = mi_uniforme_ajustada(u1, 20, 50, CORRIDAS);
x2 = mi_uniforme_ajustada(u2,  5, 12, CORRIDAS);

% triangular[60, 72, 84] para el nucleo
x3 = mi_randtriang2(u3, 60, 72, 84, CORRIDAS);

min(u4)
min(u5)

%exponencial para los propulsores
x4 = mi_exponencial(u4, 1/240, CORRIDAS);
x5 = mi_exponencial(u5, 1/240, CORRIDAS);

       
       
%%calculo de medias muestrales:
m1 = media_muestral(x1, CORRIDAS)
m2 = media_muestral(x2, CORRIDAS)
m3 = media_muestral(x3, CORRIDAS)
m4 = media_muestral(x4, CORRIDAS)
m5 = media_muestral(x5, CORRIDAS)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Simulacion de montecarlo



