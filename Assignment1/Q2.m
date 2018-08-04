  l = 10;
  k = 1;
  Cap = zeros(21);
  Capt = zeros(21);
  while l<=1000
    %%Dimensions of the plates
    %End points of Plate 1
    x1 = -5+600;
    y1 = -l/2+600;
    x2 = 5+600;
    y2 = -l/2+600;

    Er = 5;

    l1=l;
    l2=l;
    %The capacitor is placed on a bigger box of size N1xN2
    Nx = 1200;
    Ny = 1200;
    x = linspace(1,Nx,Nx);
    y = linspace(1,Ny,Ny);      

    [X,Y] = meshgrid(x,y);

    V = zeros(Nx,Ny);

    V(x1,y1:y1+l1) = 1;
    V(x2,y2:y2+l2) = 0;

    iter=1000;

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
        count=count+1;
    end


    [Ex,Ey]=-1*gradient(V);


    E = Ex^2 + Ey^2;

    rho = divergence(X,Y,Ex,Ey);

    Q=0;

    for i = -l/2+600:l/2+600
        Q = Q + rho(605,i);
    end

    Cap(k) = Q * 5 * 8.85 * 1e-12 
    d = 10;
    Cap_t(k) = l*8.85*1e-12*Er/d
    l = l + 50
    k = k + 1;
  end 
  
  figure
  plot(Cap(1:20))
  figure
  plot(Cap(1:20)-Cap_t(1:20))