import matplotlib.pylab as plt 
def v(x,l):
	Vo = 30 # Ry
	if abs(x)>= l/2:
		return 	Vo
	else:
		return 0 
	

def f(x,E):
	l = 4 # A
	m = 1
	hbar2= 1 
	return (2*m/hbar2)*(v(x,l)-E)

def fi(fix0,fix1,xi,xf,npaso,E):
	#x0 = x-h 
	#x1 = x
	#x2 = x+h   
	#return fi(x2) give two initial values
	
	
	h = (xf-xi)/(npaso*1.0)
	print(h)
	x0 = xi
	x1 = x0 +h 
	x2 = x1+2*h
	
	lfi = [fix0,fix1]
	x = [x0,x1]
	for i in range(2,npaso):
		
		num =  2*fix1*(1+(5/12.)*h**2*f(x1,E))-fix0*(1+h**2/12.)*f(x0-h,E) 

		den = 1+h**(2/12.)*f(x2,E)
		fix2 = num/den
		lfi+= [fix2]
		x+=[x2] 
		fix0 = fix1
		fix1 = fix2 
		x0 = x1
		x1 = x2
		x2 = x2+h
		


	return x,lfi


x,lfi = fi(0,1e-8,-4,4,400,0.5177146)
print(len(x),len(lfi))

plt.plot(x,lfi)
plt.show()
