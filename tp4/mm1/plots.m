rho = [
0.083333333
0.1
0.125
0.142857143
0.166666667
0.2
0.25
0.344827586
0.454545455
0.5
];

L_medido = [
0.089
0.105
0.134
0.157
0.189
0.237
0.323
0.499
0.724
0.846
];

L_teorico = [
0.090909091
0.111111111
0.142857143
0.166666667
0.2
0.25
0.333333333
0.526315789
0.833333333
1
];

plot(rho, L_teorico, rho, L_medido);

