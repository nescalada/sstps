function[y] =funa1(t,X)
%function y = funa1(X, t)

lambda1 = -0.83/0.3333333
lambda2 = -0.6/0.333333

gama1 = (-(lambda1+lambda2)-6)/1.5

gama2 = (lambda1*lambda2)/4.5-gama1

k0 = 0.5;
k1 = 2.5;
k2 = 3;
b0 = 1.5;

A=[ -(k1+k0)-b0*gama1   , k2-b0*gama2;
    k2                  , -k2  ];
B=[ b0; 0 ];


y= (A * X) + B*30;

end
%endfunction