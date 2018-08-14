N = 701;
L = 700;

x = linspace(0,L,N);
rho = zeros(N,1);
V = zeros(N,1);

Lap = zeros(N,N);

v = ones(N,1);
v1 = ones(N-1,1);

Lap = -2.*diag(v,0) + diag(v1,1) + diag(v1,-1);

Lap(1,1) = -2;
Lap(N,N) = -1;

rho(1:200) = 0.0;
rho(201:250) = 5.0;
rho(251:500) = -1.0;
rho(501:701) = 0.0;

figure(1)
plot(rho);

V = -1*inv(Lap)*rho;

figure(2)
plot(V);
