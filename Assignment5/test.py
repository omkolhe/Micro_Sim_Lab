import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import axes3d
import math

delta_x = 1e-6 #10nm
L = 1e-4      #100um
initial_conc = 1e25 #(/m^3)
N = math.ceil(L/delta_x)  #10k div
# print(N)
simulation_time = 1e-8
delta_T = 1e-10
T = math.ceil(simulation_time/delta_T)
print(T)
D = 25*1e-4 #(25cm^2/sec)

C = np.zeros(N)
C = np.array([C]*T)

def lap(C, N):

	Laplacian = (-2*np.diag([1]*N,k=0)+np.diag([1]*(N-1),k=1)+np.diag([1]*(N-1),k=-1))#/(dx**2)
	Laplacian[0,0] = -2
	Laplacian[N-1,N-1] = -2;
	Laplacian_matrix=np.matrix(Laplacian)
	# print (Laplacian_matrix)
	C = np.matrix(C)
	# print (np.array((Laplacian*C.T).T)[0])
	return (np.array((Laplacian*C.T).T)[0])

#2 division covers 10 nm
C[0][int (N/2)]   =   initial_conc
C[0][int (N/2)-1] = initial_conc
# print (C[int (N/2)-3:int (N/2)+3])
# print (C[0][:])

# print(C[0][int (N/2)-2:int (N/2)+2])
# print(C[1][int (N/2)-2:int (N/2)+2])
# print(C[2][int (N/2)-2:int (N/2)+2])

# print (lap([0,0,0,0,1,1,0,0,0,0], 10))
k = (D*delta_T/delta_x**2)
print (k)
for i in range(0,T-1):
	# print (i)
	C[i+1] = C[i] + k*lap(C[i], N)
	for iter in range(N):
		if(C[i+1][iter]<0):
			C[i+1][iter]= 0
# 	# print(C[i][int (N/2)-1:int (N/2)+3])
# print (C[1][:])
# print (C[2][:])

# C[1] = C[0] - k*lap(C[0], N)
# C[2] = C[1] - k*lap(C[1], N)

print("done")
# print (lap(C[0][:],N)[4995:5003])
print(C[0][int (N/2)-2:int (N/2)+2])
print(C[1][int (N/2)-2:int (N/2)+2])
print(C[2][int (N/2)-2:int (N/2)+2])

x = np.arange(0, L, delta_x)
# print (len(x))
y = np.arange(0, simulation_time, delta_T)
# print (len(y))
X, Y = np.meshgrid(x, y)

# print (len(C))
# print (len(C[0]))



fig = plt.figure(0)
ax = fig.add_subplot(111)
ax.set_title("Initial concentration(/cm^3)")
ax.set_xlabel("Length(10 nm)")
ax.set_ylabel("Charge Density ()")
# ax.plot(C[0])
# ax.plot(C[1])
# ax.plot(C[2])
for i in range(T):
	ax.plot(C[i])
ax.grid()

# fig = plt.figure()
# ax = fig.add_subplot(111, projection='3d')
# ax.plot_wireframe(X,Y,C, rstride=2, cstride=2)


plt.show()