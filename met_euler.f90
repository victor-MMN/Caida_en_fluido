SUBROUTINE met_euler(f,y0,a,b,h,archi,n)

  IMPLICIT NONE
  
!  Diccionario de variables:

!	 f: Funcion a aproximar, real.
!	 y0: Condicion inicial, real.
!	 a: Intervalo inferior, real.
!	 b: Intervalo superior, real.
!	 h: Ancho de paso, real, vector.
!	 t: Tiempo a evaluar, real.
!	 y: Punto a evaluar en t, real.
!	 i: Contador para los DOs, entero.
!        n: Cantidad de anchos de banda a evaluar, entero.
!	 nom: Nombre del archivo donde se guardaran los datos, caracter.
!	 archi: Array para guardar los nombre de archivos para plotear, caracter, vector.


  REAL, INTENT(IN) :: y0,a,b,h
  REAL, EXTERNAL :: f
  CHARACTER(LEN = 30) :: nom
  CHARACTER(LEN = 30), INTENT(INOUT) :: archi
  REAL :: t,y
  INTEGER :: i
  INTEGER, INTENT(IN) :: n

  IF (a > b) THEN ! IF antitroleo.

     PRINT*, "El limite inferior no puede ser mayor que el superior"

     STOP

  END IF
     
t = a   ! inilizacion de variables a usar.
y = y0

20 FORMAT (A,F5.2) ! El ancho de paso solo puede tener 5 cifras significativas.

WRITE(nom,20) "aprox_h=",h

OPEN(1, FILE = TRIM(nom), ACTION = "write", STATUS = "unknown") ! OPEN para escribir los datos en los archivos.


   DO ! DO para aproximar el valor en cada punto.
      IF (t > b) EXIT 

      WRITE(1,*) t,y

      t = t + h

      y = y + h*f(y,t)

   END DO

   archi = TRIM(nom)

 CLOSE(1)

END SUBROUTINE met_euler



   



  
