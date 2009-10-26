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
    
    %%%%%%%%% PARTE B %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%% CALCULO DE CHI CUADRADO X^2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %%% frecuencia en cada intervalo de clase %%%
    i=0;
    
    dist = zeros(1,10);
    clases = [0.05, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.75, 0.85, 0.95];
    
    while (i<10000)
        i=i+1;
        if(u(i) < 0.1)
            dist(1)=dist(1)+1;
        else if(u(i) <0.2)
                dist(2)=dist(2)+1;
                else if(u(i) <0.3)
                    dist(3)=dist(3)+1;
                    else if(u(i) <0.4)
                        dist(4)=dist(4)+1;
                        else if(u(i) <0.5)
                            dist(5)=dist(5)+1;
                            else if(u(i) <0.6)
                                dist(6)=dist(6)+1;
                                else if(u(i) <0.7)
                                    dist(7)=dist(7)+1;
                                    else if(u(i) <0.8)
                                    dist(8)=dist(8)+1;
                                        else if(u(i) <0.9)
                                        dist(9)=dist(9)+1;
                                            else
                                            dist(10)=dist(10)+1;
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
            end
        end
    end
    
    dist
    plot( clases, dist);
    
    %%%%%%%%% estadistico chi cuadrado %%%%%%%%
    
    
    chi0cuadrado = 0;
    i=1;
    while (i<=10)
        chi0cuadrado = chi0cuadrado + (dist(i)-1000)^2/1000;
        i=i+1;
    end
    
    chi0cuadrado
    xcritico = 16.91898
    
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %%%%%%%%%%%%% plots en 2 d y en 3d     %%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    i = 1;
    u2d= zeros(1,10000);
    u3d= zeros(1,10000);
    while(i+1<10000)
        u2d(i+1) = u(i);
        u3d(i+2) = u(i);
        i=i+1;
    end
    
    size(u)
    size(u2d)
    size(u3d)
    
    %plot(u, u2d);
   % plot3(u, u2d, u3d);
        
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% test KS  %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    sorted_u = sort(u)
    
    
        
        
        
        
        
        
         
           
     
    
    