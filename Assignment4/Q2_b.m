% Parameters for solving problem in the interval -L < x < L
% PARAMETERS:
L = 22.5;
N = 1000;
x = linspace(-L,L,N)';
dx = x(2) - x(1);

w = 2.5;
U = 1.0452*(heaviside(x+w)-heaviside(x-w));

% Three-point finite-difference representation of Laplacian
% using sparse matrices, where you save memory by only
% storing non-zero matrix elements
e = ones(N,1); Lap = spdiags([e -2*e e],[-1 0 1],N,N)/dx^2;


% Total Hamiltonian
% constants for Hamiltonian
hbar = 1; 
m = 15; 
H = -1/2*(hbar^2/m)*Lap + spdiags(U,0,N,N);
% Find lowest nmodes eigenvectors and eigenvalues of sparse matrix 
nmodes = 3; options.disp = 0;
[V,E] = eigs(H,nmodes,'sa',options); % find eigs
[E,ind] = sort(diag(E));% convert E to vector and sort low to high 
V = V(:,ind); % rearrange corresponding eigenvectors
% Generate plot of lowest energy eigenvectors V(x) and U(x)
Usc = U*max(abs(V(:)))/max(abs(U)); % rescale U for plotting 
plot(x,V,x,Usc,'--k'); % plot V(x) and rescaled U(x)
% Add legend showing Energy of plotted V(x)
lgnd_str = [repmat('E = ',nmodes,1),num2str(E)];
legend(lgnd_str) % place lengend string on plot
shg