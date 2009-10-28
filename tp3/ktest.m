function[fx] = ktest(u, x)
    fx=0;
    i=1;
    while (i<=10000 && u(i)< x)
        fx=fx+1;
        i=i+1;
    end
    
    i=i-1;
    
    


end