! Main program for 1D-Advection

program main
	use fin_diff 
	implicit none

	! Variable declaration
	integer :: n
	integer :: i
	integer, parameter :: nx = 100, nt = 100
	real (kind=8), dimension(nx) :: u1, u2, u3, x
	real (kind=8) :: ubg, dt, dx
	real (kind=8) :: ax, u0, hx

	! Setting other parameters
	dx = 10.e3
	dt = 30.
	ubg = 10.
	u0 = 10.
	ax = 50.e3

	print *, "Setting up grid structure"
	print *, "nx = ", nx, ", nt = ", nt
	print *, "dx = ", dx, ", dt = ", dt
	print *, "Grid width = ", nx*dx
	print *, "Integration period = ", nt*dt
	
	! Initialize field
	hx = nx/2 +1
	
	do i=1,nx
		x(i) = i * dx
		u1(i) = u0 * ax * ax / (((i-hx) * dx)**2 + ax * ax)
	enddo
	
	call eulerforw(u1, u2, ubg, dx, dt)
	
	!  Write field to file
	open(unit = 10, file = 'grid.txt')
	do i=1,nx
		write(10, *) x(i)
	enddo
	close(10)
	open(unit=20, file = 'output.txt')
	do i=1,nx
		write(20, *) u2(i)
	enddo
	close(20)

end program main