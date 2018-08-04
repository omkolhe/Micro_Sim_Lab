%%Dimensions of the plates
%End points of Plate 1
x1 = -5+600;
y1 = -500+600;
x2 = 5+600;
y2 = -500+600;

Er = 5;

l1=1000;
l2=1000;
%The capacitor is placed on a bigger box of size N1xN2
Nx = 1200;
Ny = 1200;
x = linspace(1,Nx,Nx);
y = linspace(1,Ny,Ny);      

[X,Y] = meshgrid(x,y);

V = zeros(Nx,Ny);

V(x1,y1:y1+l1) = 1;
V(x2,y2:y2+l2) = 0;

iter=500;

count=0;
while count<iter
    for i = 2:Nx-1 %x
        for j = 2:Ny-1 %y
            if (j>=y2 && j<y2+l2 && i==x2)
                %print(i,j,V[i][j])
                continue
            end
            if (j>=y1 && j<y1+l1 && i==x1)
                %print(i,j,V[i][j])
                continue
            end
            V(i,j)=(V(i-1,j)+V(i+1,j)+V(i,j-1)+V(i,j+1))/4;
        end
    end
    count=count+1
end

surf(X,Y,V)
view(2)

[Ex,Ey]=gradient(V);
figure
contour(X,Y,V);
figure
hold on
quiver(Ex,Ey,4)
hold off
title(' Electrical field of the Capacitor in static case');

figure
E = Ex^2 + Ey^2;
surf(X,Y,E)
view(2)

figure
rho = divergence(X,Y,Ex,Ey);

Q=0;

for i = 100:1100
    Q = Q + rho(605,i);
end

C = Q * 5 * 8.85 * 1e-12 
l =1000;
d = 10;
C_theoritical = l*8.85*1e-12*Er/d
  