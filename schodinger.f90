function well(x,l,v0)
	implicit none 
	double precision :: well,x,l,v0
	if(dabs(x)<=l/2) then 
		well = 0.d0
	else
		well = v0
    endif
	return 

end function 

program wave 
	implicit none 
	integer :: i,j,INFO
	double precision :: l,a,v0,dx,x,well
	double precision :: H(1000,1000)
	double precision :: w(1000)
	double precision :: work(3000)
	open(6, file='wave1.dat',status ='new')
	print *,"Ok"

	a = 4.0
	l = 2.d0*a
	v0 = 30.0
	dx = 2*l/1000.d0
	x = -l
	do i=1,1000
		do j = 1,1000
			if(j==i+1 .and. i+1<=1000) then 
				H(i,j) =-1.d0
			elseif(j==i) then 
				H(i,j)=2.d0+dx**2*well(x+i*dx,l,v0)
			elseif(j==i-1 .and. i-1>0) then 
				H(i,j)=-1.d0
			else
				H(i,j)=0.d0
			endif 
		enddo
	enddo
	!print *,"Matrix Ok"
	call dsyev('V','U',1000, H, 1000, W, WORK, 3000, INFO)
	!print *,w(1)/dx**2,w(2)/dx**2,w(3)/dx**2

	do i=1,1000
		write(6,*)x+i*dx,H(i,1),H(i,2),H(i,3)
	enddo
	print *, "End"

end program wave
