N=1000;
L=1e-9;
x=linspace(-L,L,N)';
dx=x(2)-x(1);

Lap = (-2*diag(ones(N,1),0) + diag(ones((N-1),1),1) + diag(ones((N-1),1),-1))/(dx^2);
% Next modify Lap so that it is consistent with f(0) = f(L) = 0 
Lap(1,1) = 0; Lap(1,2) = 0; Lap(2,1) = 0; % So that f(0) = 0 
Lap(N,N-1) = 0; Lap(N-1,N) = 0; Lap(N,N) = 0;% So that f(L) = 0

hbar = 1; 
m = 0.067; 
H = -(1/2)*(hbar^2/m)*Lap;
% Solve for eigenvector matrix V and eigenvalue matrix E of H 
[V,E] = eig(H);
% Plot lowest 3 eigenfunctions
plot(x,V(:,3),'r',x,V(:,4),'b',x,V(:,5),'k'); shg;
E; % display eigenvalue matrix
diag(E); % display a vector containing the eigenvalues

