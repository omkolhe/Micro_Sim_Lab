N = 601;
L = 600;

x = linspace(0,L,N);
rho = zeros(N,1);
V = zeros(N,1);

Lap = zeros(N,N);

v = ones(N,1);
v1 = ones(N-1,1);

Lap = -2.*diag(v,0) + diag(v1,1) + diag(v1,-1);

Lap(1,1) = -2;
Lap(N,N) = -1;

x1 = linspace(-5,0,100);
y1 = gaussmf(x1,[1,0]);

x2 = linspace(0,5,500);
y2 = gaussmf(x2,[1,0]);

% rho(1:200) = 0.0;
% rho(201:250) = 5*y1;
% rho(251:500) = -1*y2;
% rho(501:701) = 0.0;

rho(1:100) = 5*y1;
rho(101:600) = -1*y2;

rho = rho*1.6e-19*1e6*1e-18/8.85e-12*1e17;

figure(1)
plot(rho);

V = -1*inv(Lap)*rho;

E = gradient(V);
E = -1*E;
figure(2)
plot(E);

figure(3)
plot(V);