format long 

M	= 2147483562
 A1 =	40014
 M1	= 2147483563
 A2	= 40692
 M2	= 2147483399
 CORRIDAS	= 10000

 
 %%%%%%%%%%% PARTE A%%%%%%%%%%%%%
 %%%% 10000 PASADAS DE U %%%%%%%%
 
	 i=1; 	v1=23; v2=23;

     x1(1) = 23;
     x2(1)= 23;
     
		
	while(i < CORRIDAS)
	i=i+1;

    
		x1(i) = mod((A1 * x1(i-1)) , M1);
		x2(i) = mod((A2 * x2(i-1)) , M2);

		
		x(i) = mod((x1(i) - x2(i)) , M);
		if(x(i)<0)
		
			while(x(i)<0)
				x(i) = x(i) + M;
            end
        end
         
		

		if(x(i) > 0)
			u(i) = x(i)/M1;
		else
			u(i) = M/M1;
        end
    end
    
    sorted_u = sort(u);
    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
       triang = mi_randtriang2(sorted_u, 0, 1, 3, CORRIDAS);
       
       
