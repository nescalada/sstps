function [u] = mi_uniforme(seed, CORRIDAS)

M	= 2147483562;
 A1 =	40014;
 M1	= 2147483563;
 A2	= 40692;
 M2	= 2147483399;
 

 
 %%%%%%%%%%% PARTE A%%%%%%%%%%%%%
 %%%% 10000 PASADAS DE U %%%%%%%%
 
	 i=1; 	v1=seed; v2=seed;

     x1(1) = seed;
     x2(1)= seed;
     
		
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
    