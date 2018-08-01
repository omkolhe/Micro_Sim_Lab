%%Dimensions of the plates
%End points of Plate 1
x1 = -10+60;
y1 = -10+60;
x2 = 60;
y2 = -10+60;

l1=20;
l2=10;
%The capacitor is placed on a bigger box of size N1xN2
Nx = 6*l1;
Ny = 12*l2;
x = linspace(1,Nx,Nx);
y = linspace(1,Ny,Ny);      

[X,Y] = meshgrid(x,y);

V = zeros(Nx,Ny);

V(x1,y1:y1+l1) = 0;
V(x2:x2+l2,y2) = 1;

iter=6000;

count=0;
while count<iter
    for i = 2:Nx-1 %x
        for j = 2:Ny-1 %y
            if (i>=x2 && i<x2+l2 && j==y2)
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
    count=count+1;
end

surf(X,Y,V)
view(2)

[Ex,Ey]=gradient(V);
figure
contour(X,Y,V);
hold on
quiver(Ex,Ey,4)
hold off
title(' Electrical field of the Capacitor in static case');

figure
E = Ex^2 + Ey^2;
surf(X,Y,E)
view(2)
  