! Module containing finite difference approximations 
! for 1D-Advection model in main.f90

module fin_diff
		
contains


	subroutine eulerforw(u, up1, ubg, dx, dt)
		! Euler forward for advection equation
		implicit none
		real(kind=8), dimension(:), intent(in) :: u
		real(kind=8), dimension(size(u)), intent(out) :: up1
		real(kind=8), intent(in) :: dx, dt, ubg
		real(kind=8) :: ux
		integer :: i
		do i=1,size(u)
			
			if (i.ge.3.and.i.le.size(u)) then
				ux = cs4(u(i-2), u(i-1), u(i+1), u(1+2), dx)  
			endif
			if (i.eq.1) then
				ux = cs4w1(u(i), u(i+1), u(i+2), u(i+3), u(i+4), dx)
			endif
			if (i.eq.2) then
				ux = cs4w2(u(i-1), u(i), u(i+1), u(i+2), u(i+3), dx)
			endif
			if (i.eq.size(u)) then
				ux = cs4e1(u(i-4), u(i-3), u(i-2), u(i-1), u(i), dx)
			endif
			if (i.eq.size(u)-1) then
				ux = cs4e2(u(i-3), u(i-2), u(i-1), u(i), u(i+1), dx)
			endif
			!print *, up1(i), u(i)
			up1(i) = u(i) - dt * ubg * ux
			
		enddo
		
	end subroutine eulerforw
	
	real(kind=8) function cs4(um2, um1, up1, up2, dx)
		! Centered space, 4th order
		implicit none
		real(kind=8), intent(in) :: um2, um1, up1, up2, dx
		cs4 = (8. * (up1 - um1) - (up2 - um2)) / (12. * dx)
	end function cs4
	
	real(kind=8) function cs4w1(u, up1, up2, up3, up4, dx)
		! CS 4th order, at i = 1, w stands for west
		implicit none
		real(kind=8), intent(in) :: u, up1, up2, up3, up4, dx
		cs4w1 = (-25. * u + 48. * up1 - 36. * up2 + 16. * up3 - 3. * up4) / (12. * dx)
	end function cs4w1
	
	real(kind=8) function cs4w2(um1, u, up1, up2, up3, dx)
		! CS 4th order, at i = 2
		implicit none
		real(kind=8), intent(in) :: um1, u, up1, up2, up3, dx
		cs4w2 = (-3. * um1 - 10. * u + 18. * up1 - 6. * up2 + up3) / (12. * dx)
	end function cs4w2 
	
	real(kind=8) function cs4e1(um4, um3, um2, um1, u, dx)
		! CS 4th order, at i = 1, e stands for east
		implicit none
		real(kind=8), intent(in) :: um4, um3, um2, um1, u, dx
		cs4e1 = (25. * u - 48. * um1 + 36. * um2 - 16. * um3 + 3. * um4) / (12. * dx)
	end function cs4e1
	
	real(kind=8) function cs4e2(um3, um2, um1, u, up1, dx)
		! CS 4th order, at i = 2
		implicit none
		real(kind=8), intent(in) :: um3, um2, um1, u, up1, dx
		cs4e2 = (3. * up1 + 10. * u - 18. * um1 + 6. * um2 + um3) / (12. * dx)
	end function cs4e2 
	
	
end module fin_diff	
