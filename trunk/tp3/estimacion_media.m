%%%%% para distintas cantidades de simulaciones, calculo el valor medio



j=1;
i=100;
while(i<=10000)
    n(j)=i;
    [media(j), var(j)] = parte2(i);
    
    i=i+100;
    j=j+1;
end

%plot(n, media);
plot(n, var);
    