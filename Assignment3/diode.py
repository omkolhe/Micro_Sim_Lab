#Solve Poisson's equation

import numpy as np
import matplotlib.pyplot as plt
from numpy import linalg

#Constants
eps_0=8.85e-12 #Vacuum dielectric constant
eps=11.7*eps_0 #Dielectric constant of Si
q=1.6e-19      #Charge of an electron
nm=1        #Nanometer
um=1e-6
DOP=1e12*1e6   #Doping level
ni=1e10*1e6    #Intrinsic carrier concentration
mu=0.1           #1000 cm^2/V.s
Vt=0.026
D=Vt*mu        #By Einsten's relation at room temperature

#Parameters for solving problem in the interval 0 < x < L
#Simulation array
L = 12e-6
N = 50
x,dx = np.linspace(0,L,N,retstep=True,endpoint=True,dtype=float) #Coordinate vector
rho=np.zeros(N) #Charge density
Nd=np.zeros(N)  #Doping at each position
n=np.zeros(N)   #Electron density at each position
p=np.zeros(N)   #Hole density at each position
V=np.zeros(N)   #Potential
SG=np.zeros(N)
Vnew=V

#Fixed doping does not change, Full ionization
Nd[0:int((N+1)/2)],Nd[int((N+1)/2):N]=DOP,-DOP

#Boundary condition for carriers
n[0],p[0],n[N-1],p[N-1]=DOP,ni**2/DOP,ni**2/DOP,DOP
#n[0],p[0],n[N-1],p[N-1]=DOP,0.0,0.0,DOP

#Initial guess for carriers
n[1:int((N+1)/3)], p[int(2*(N+1)/3):(N-1)]=DOP/2, DOP/2
plt.plot(p,'g*-')
plt.plot(n,'r*-')
plt.plot(Nd,'*-')
plt.show()

emax=0.0
count=0

#Three-point finite-difference representation of Laplacian
Lap = (-2*np.diag([1]*N,k=0)+np.diag([1]*(N-1),k=1)+np.diag([1]*(N-1),k=-1))
Lap[0,0] = -2
Lap[N-1,N-1] = -1;
myLap=np.matrix(Lap)

f1=-(q/eps)*(dx)**2
while True:    
    rho=(Nd-n+p)
    rho[N-1]=rho[N-1]/2   #For Neumann boundary condition at x=L
    myrho=np.matrix(rho)
    
    V_mat = -myLap.I*myrho.T
    Vnew=f1*np.squeeze(np.asarray(V_mat))
    err=100*np.max(np.abs((Vnew-V)/Vnew))
    V=Vnew
    
    #Calculate Scharfetter-Gummel factor
    for idx in range (1,N-1):
        sg=(V[idx+1]-V[idx-1])/(2*Vt)
        if sg>2:
            sg=4
        SG[idx]=np.exp(sg)
        n[idx]=(n[idx-1]*SG[idx]+n[idx+1]/SG[idx])/2
        p[idx]=(p[idx-1]/SG[idx]+p[idx+1]*SG[idx])/2
    count=count+1
    if err<0.01 :
        break
print(count)
plt.plot(SG)
plt.show()
plt.plot(x/um,V)
plt.grid()
plt.show()  
plt.plot((n),'r-')
plt.plot((p),'g-')
plt.show()
plt.plot(rho,'k-')
plt.grid()
plt.show()
