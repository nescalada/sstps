function[media, desv, i]=montecarlo()

format long

CORRIDAS = 10000;
EPSILON = 5;

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
%exponencial para los propulsores
x4 = mi_exponencial(u4, 1/240, CORRIDAS);
x5 = mi_exponencial(u5, 1/240, CORRIDAS);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Simulacion de montecarlo

i=1;
while(i<=CORRIDAS)
    T(i) = min( [ max(x1(i), x2(i)), x3(i), max(x4(i), x5(i)) ]);
    i=i+1;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i = 2;
corte = false;

acum_media = T(1);
acum_desv = 0;

p_media(1) = T(1);
p_desv(1) = T(1);




while(i<=CORRIDAS && corte==false)
    acum_media=acum_media + T(i);
    media = acum_media / i;
    
    acum_desv = acum_desv + ( T(i)-media )^2;
    desv=sqrt( acum_desv / (i -1));
    
    L= 2*1.6*desv / sqrt(i);
    error_porcentual(i-1) = 100*L/media;
    if( 100*L/media < EPSILON)
        corte = true;
        i=i-1;
    end
    
    p_media(i)=media;
    p_desv(i)=desv;
    
    i=i+1;
   
end

%plot(error_porcentual);
%plot(p_media);
plot(p_desv);

