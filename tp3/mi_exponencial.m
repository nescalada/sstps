function[x] = mi_randtriang(u, lambda, N)
i=1;
while(i<=N)
     if(u(i)==0)
         x(i) = 0;
     else
    
        %log es logaritmo natural
        x(i) = - log( u(i) ) / lambda;
     end
    
    i=i+1;
end



end

