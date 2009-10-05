

function tp
X0=[0 ; 0];

%intervalo de 1 minuto
%T=linspace(0,10,60);
%T=[0 10];

%SOL1 = lsode( "funa1", X0, T);

%plot(T, SOL1(:,1))

%intervalo de 1 minuto
tspan=[0 10];

[t,Y] = ode45( 'funa1', tspan, X0);

%size(Y)
%hold on
plot(t, Y(:,1));
plot(t, Y(:,2));
%endfunction

end
