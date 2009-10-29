function[t_medio, varianza] =parte2 (CORRIDAS)

format long 

%CORRIDAS = 10000;

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


i=1;
while(i<=CORRIDAS)
    T(i) = min( [ max(x1(i), x2(i)), x3(i), max(x4(i), x5(i)) ]);
    i=i+1;
end


%tiempo medio
t_medio  = media_muestral(T, CORRIDAS)




t_medio_experimental =   34.70290343659776;
%varianza

i=1;
while(i<=CORRIDAS)
    acum = (T(i) - t_medio_experimental) * (T(i) - t_medio_experimental);
    i=i+1;
end
varianza = acum/(CORRIDAS-1)



end



















% 
% minimo= min(T)
% maximo = max(T)
% 
% %%%%%%%%%%%%% histograma %%%%%%%%%%
% 
% i=0;
% clases = [ 34, 35.6 , 37.2 , 38.8, 40.4, 42, 43.6, 45.2, 46.8, 48.4];
% dist = zeros(1,10);
%     
%    
%    
%     
%     while (i<CORRIDAS)
%         i=i+1;
%         if(T(i) < clases(1)-0.8)
%             dist(1)=dist(1)+1;
%         else if(T(i) < clases(2)-0.8)
%                 dist(2)=dist(2)+1;
%                 else if(T(i) < clases(3)-0.8)
%                     dist(3)=dist(3)+1;
%                     else if(T(i) < clases(4)-0.8)
%                         dist(4)=dist(4)+1;
%                         else if(T(i) < clases(5)-0.8)
%                             dist(5)=dist(5)+1;
%                             else if(T(i) < clases(6)-0.8)
%                                 dist(6)=dist(6)+1;
%                                 else if(T(i) < clases(7)-0.8)
%                                     dist(7)=dist(7)+1;
%                                     else if(T(i) < clases(8)-0.8)
%                                     dist(8)=dist(8)+1;
%                                         else if(T(i) < clases(9)-0.8)
%                                         dist(9)=dist(9)+1;
%                                             else
%                                             dist(10)=dist(10)+1;
%                                             end
%                                         end
%                                     end
%                                 end
%                             end
%                         end
%                     end
%             end
%         end
%     end
%     
%     dist
%     %%%% frecuencias para cada intervalo de clase
%     plot( clases, dist);
   



