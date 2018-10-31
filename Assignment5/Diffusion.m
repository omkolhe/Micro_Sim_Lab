%%Constants 
delta_x = 1e-6; %1um 
L = 1e-4; %100um
initial_conc = 1e25; %per m^3
N = ceil(L/delta_x);

%The time for which the code simulates the diffusion
sim_time = 1e-8; %10ns
delta_T = 1e-10; %1ns time step
T = ceil(sim_time/delta_T);

D = 25e-4; % Diffusion constant

k = D*delta_T/(delta_x^2);

%% Defining arrays 
C = zeros(T,N); % The concentration across L and with time 

%Three-point finite-difference representation of Laplacian
Lap = -2.*diag(ones(N,1),0) + diag(ones(N-1,1),1) + diag(ones(N-1,1),-1); %Three-point finite-difference representation of Laplacian
Lap(1,1) = -2;
Lap(N,N) = -1;

%% Initial Condition 
C(1,ceil(N/2) -1) = initial_conc;
C(1,ceil(N/2)) = initial_conc;

%% Iterrations

for i=1:T
   C(i+1,:) = C(i,:) + k.*(Lap*C(i,:)')'; 
   for check=1:N
       if(C(i+1,check) < 0)
           C(i+1,check)=0;
       end
   end 
end

%% Ploting Results 
figure();
for i=1:5:T
    plot(C(i,:));
    hold on;
end 

title('Concentration with time')
ylabel('Concentration');
xlabel('Length');
xlim([1 101]);
grid on;
