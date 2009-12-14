function z = expon(mean)
% Funcion:   expon
% Proposito:
%
%
% Genera un numero pseudo-aleat. U(0,1)
u = rand;
z = -mean * log(u);
return

