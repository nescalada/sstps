function[y] = media_muestral(u, N)
i = 1;
m=0;
while(i<=N)
    m=m+u(i);
    i=i+1;
end

y = m/N;