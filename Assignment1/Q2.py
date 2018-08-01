import numpy as np
import matplotlib.pyplot as plt
#pylab qt
#length of the plates of the capacitor
x1,y1 = -10+30,-10+30
x2,y2 = 30,-10+30
l1=20
l2=10
#The capacitor is placed on a bigger box of size N1xN2
Nx=3*l1
Ny=6*l2
x=np.linspace(0,Nx-1,num=Nx)
y=np.linspace(0,Ny-1,num=Ny)

X,Y = np.meshgrid(x,y)

#Potential is 2D variable
V=np.zeros((Nx,Ny))

V[x1,y1:y1+l1]=0
V[x2:x2+l2,y2]=1
#print(V)
#Potential at each point is the average of its neighbor barring the boundary codidtions
iter=3000

count=0
while count<iter:
    for i in range(1,Nx-2): #x
        for j in range(1,Ny-2): #y
            if i>=x2 and i<x2+l2 and j==y2:
                #print(i,j,V[i][j])
                continue
            if j>=y1 and j<y1+l1 and i==x1:
                #print(i,j,V[i][j])
                continue
            V[i][j]=(V[i-1][j]+V[i+1][j]+V[i][j-1]+V[i][j+1])/4
    count=count+1
#print(V)

fig = plt.figure(figsize=(6, 3.2))

ax = fig.add_subplot(111)
ax.set_title('colorMap')
plt.imshow(V)
ax.set_aspect('equal')

cax = fig.add_axes([0.12, 0.1, 0.78, 0.8])
cax.get_xaxis().set_visible(False)
cax.get_yaxis().set_visible(False)
cax.patch.set_alpha(0)
cax.set_frame_on(False)
plt.colorbar(orientation='vertical')
plt.show()
