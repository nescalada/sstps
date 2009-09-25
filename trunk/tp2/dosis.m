function [x, y, t] = dosis()

	u 	= zeros(1,70);
	t 	= [0:0.1:4];
	
	 x	= [0];
	 y	= [0];
	k0	= 0.5;
	k1	= 2.5;
	k2	= 3;
	b0 	= 1.5;
	h       = 0.1;		% paso 
	c1	= 30;
	c2 	= 0;
	i       = 1;
	tiemp   = 0;
	K 	= 4;
		
	while( tiemp < 4 )

		u(i) 	= K* 30 - K * c2;
	
		m1 = h * (-( k1 + k0 ) * c1 + b0 * u(i) );
		n1 = h * (k2 * c1 - k2 * c2 );
		
		m2 = h * (-( k1 + k0 ) * ( c1 + m1 / 2 ) + b0 * u(i) );
		n2 = h * (k2 * ( c1 + m1 /2 ) - k2 * (c2 + n1/ 2) );
	
		m3 = h * (-( k1 + k0 ) * ( c1 + m2 / 2 ) + b0 * u(i) );
		n3 = h * (k2 * ( c1 + m2 /2 ) - k2 * (c2 + n2/ 2) );

		m4 = h * (-( k1 + k0 ) * ( c1 + m3 ) + b0 * u(i) );
		n4 = h * (k2 * ( c1 + m3 ) - k2 * (c2 + n3 ) );

		x = [x; ( c1 + ( m1 + 2*m2 + 2*m3 + m4 ) / 6 )];
		y = [y; ( c2 + ( n1 + 2*n2 + 2*n3 + n4 ) / 6 )];

		tiemp = tiemp + h;
		
		c1 = x(i + 1);
		c2 = y(i + 1);
		
		i++;
		
	end
	plot(t, x, t, y,t, 30,'')
end

