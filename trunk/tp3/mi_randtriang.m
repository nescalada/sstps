function[x] = mi_randtriang(u, a, b, c)
i=1;
while(i<=10000)
    aux = u(i);
    
    if( aux >= 0 && aux <= (b-a)/(c-a)  )
        x(i) = a + sqrt( (b-a)*(c-a)*aux ) ;
    else if( aux >(b-a)/(c-a) && aux <=1)
            
            x(i) =  c - sqrt((c-a)*(c-b)*(1-aux));
        else
            x(i)=0;
        end
    end
    
    i=i+1;
end

i

end

