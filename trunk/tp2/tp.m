


X0=[0  0];

%intervalo de 1 minuto
tspan=[0 10];


[t,Y] = ode45( 'funa1', tspan, X0);


size(Y)
hold on
plot(t, Y(:,1));
plot(t, Y(:,2));

