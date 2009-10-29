function[x] = mi_uniforme_ajustada(u, a, b, N)

i=1;

while(i<=N)
    x(i) = u(i)*(b-a)   + a  ;
    i=i+1;


end