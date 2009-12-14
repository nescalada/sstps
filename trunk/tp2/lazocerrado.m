function [x, y, t, gama1, gama2] = lazocerrado(lambda1, lambda2)

gama1 = (-(lambda1+lambda2)-6)/1.5

gama2 = ((lambda1*lambda2)-4.5*gama1)/4.5

%gama1 = -gama1
%gama2  = -gama2




	u 	= zeros(1,1001);		%funcion de imput
	t 	= [0:0.01:10];
	
	x	= [0];		% vector de concentracion en sangre
	y	= [0];		% vector de concentracion en ORGANO
	k0	= 0.5;		% parametro del sistema
	k1	= 2.5;		% parametro del sistema
	k2	= 3;		% parametro del sistema
	b0 	= 1.5;		% parametro del sistema
	h       = 0.01;		% paso 
	c1	= 0;		% concentracion en sangre inicial
	c2 	= 0;		% concentracion en organo inicial
	i       = 1;
	tiemp   = 0;		% tiempo en horas
	%K 	= 9;		% Constante K que hay que variar experimentalmente
    
    
    
	%u(i)	= 60;

	while( tiemp <10 )
		
		u(i) 	= (30-  (gama1)*c1 - (gama2)*c2 );		% funcion de realimentacion
	
		m1 = h * (-(1.5*(gama1)+3) * c1 + (3-1.5*(gama2)) * c2 + b0 * u(i));
		n1 = h * (k2 * c1 - k2 * c2 );
		
		m2 = h * (-(1.5*(gama1)+3) * ( c1 + m1 / 2 ) + (3-1.5*(gama2)) * ( c2 + n1 /2 )+ b0 * u(i) );
		n2 = h * (k2 * ( c1 + m1 /2 ) - k2 * (c2 + n1/ 2) );
	
		m3 = h * (-(1.5*(gama1)+3) * ( c1 + m2 / 2 ) + (3-1.5*(gama2)) * ( c2 + n2 /2 )+ b0 * u(i));
		n3 = h * (k2 * ( c1 + m2 /2 ) - k2 * (c2 + n2/ 2) );

		m4 = h * (-(1.5*(gama1)+3) * ( c1 + m3 ) +  (3-1.5*(gama2)) * ( c2 + n3  )+ b0 * u(i) );
		n4 = h * (k2 * ( c1 + m3 ) - k2 * (c2 + n3 ) );

		x = [x; ( c1 + ( m1 + 2*m2 + 2*m3 + m4 ) / 6 )  ];
		y = [y; ( c2 + ( n1 + 2*n2 + 2*n3 + n4 ) / 6 )];

		tiemp = tiemp + h;
		
		c1 = x(i + 1);
		c2 = y(i + 1);
		
		i=i+1;
    end
    

    
  t(1002) = 10.02;
  
  
    size(t);
  size(x);
  size(u);
    hold on
	plot(t, x )
 plot( t,y )
end

