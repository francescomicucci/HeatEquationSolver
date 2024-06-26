PROGRAM Heat

  IMPLICIT NONE
  
  INTEGER, PARAMETER :: nt = 6400, nx = 40
  INTEGER :: i
  REAL(KIND=8), DIMENSION(0:nx+1) :: x, T, To
  REAL(KIND=8) :: time, dx, dt, len, coeff
  REAL(KIND=8) :: start, stop
  
  CALL CPU_TIME(start)

  len = 1
  time = 0
  dx = len/(nx+1)
  dt = 1.d0/nt
  coeff = dt/(dx*dx)
  
  DO i = 1, nx + 1
    x(i) = i * dx
  END DO
  
  To = 0.d0
  
  DO WHILE (time < 1.d0)
    time = time + dt
    T(0) = 0.d0
    T(1:nx) = To(1:nx) * (1.d0 - 2.d0*coeff) + coeff * (To(0:nx-1) + To(2:nx+1)) + dt * sin(x(1:nx)) * (sin(time) + cos(time))
    T(nx+1) = sin(1.d0) * sin(time)
    To = T
  END DO

  CALL CPU_TIME(stop)
  WRITE(*,*) "Time [ms]: ", (stop-start)*1000
  WRITE(*,*) "Time / (nx * nt) [ms]: ", ((stop-start)*1000)/(nx*nt)
  WRITE(*,*) "Error: ", NORM2(T-sin(x)*sin(time))/nx

END PROGRAM Heat
