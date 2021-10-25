PROGRAM caida_en_un_fluido

   IMPLICIT NONE

! Programa modular para aproximar la ecuacion de velocidad en un fluido y en interracion con la gravedad, 
! usando el metodo deeuler con diferentes anchos de paso y graficarlos juntos con la ecuacion analitica.

!  	 Diccionario de variables:

!	 g: Constante de gravedad, real.
!	 m: Masa del objeto, real.
!	 a: Intervalo inferior, real.
!	 b: Intervalo superior, real.
!	 h: Ancho de paso, real, vector.
!	 n: Cantidad de anchos de paso a evaluar, entero.
!	 t: Tiempo a evaluar, real.
!	 bf: Constante de friccion del fluido, real.
!	 Vin: Velocidad en ese momento, real.
!   V0: Velocidad inicial, real.
!	 i: Contador para los DOs, entero.
!	 archi: Array para guardar los nombre de archivos para plotear, caracter, vector.
!   nada: Variable que no vamos a usar pero la necesitamos por que la funcion necesita dos variables, real.
!   FF: Formato para escribir en el archivo a plotear, caracter


  REAL :: Vin,m,a,b,t,V0,bf
  REAL, ALLOCATABLE :: h(:)
  REAL, PARAMETER :: g = 9.80665
  INTEGER :: n,i
  CHARACTER(LEN = 30), ALLOCATABLE :: archi(:)
  CHARACTER(LEN = 10000) :: FF


  

  PRINT*, "Cual es la velocidad incial(m/s)?"
  READ*, V0

  PRINT*, "Cual es la masa del objeto(kg)?"
  READ*, m

  PRINT*, "Cual es la constante de friccion del fluido(kg/s)?"
  READ*, bf

  PRINT*, "Cual es el limite inferior del intervalo de tiempo?"
  READ*, a

  PRINT*, "Cual es el limite superior del intervalo de tiempo?"
  READ*, b

  PRINT*, "Cuantos anchos de paso vas a ingresar?"
  READ*, n

  IF (n <= 0) THEN ! IF antitroleo.

     PRINT*, "El numero de anchos de paso debe ser entero"

     STOP

  END IF


  ALLOCATE(h(n))     ! Darle tamaño a los vectores.
  ALLOCATE(archi(n))

  PRINT*, "Cada ancho de paso debe tener maximo 4 cifras significativas, ej: 23.25"

  DO i = 1,n ! DO para asignar los anchos de paso al vector ancho de paso.

     PRINT*, "Ancho de paso ",i, " = "

     READ*, h(i)

     IF (h(i) <= 0) THEN ! IF antitroleo

        PRINT*, "Los anchos de paso deben ser positivos"

        STOP

     END IF  

  END DO

  OPEN(2, FILE = "sol_analitica", ACTION = "write", STATUS = "unknown") ! OPEN para crear archivo con los datos de la sol analitica.

  t = a ! Inicializando variable.

  DO
     IF (t > b) EXIT ! Condicion de salida del DO.

     Vin = V0*EXP(-(bf/m)*t) + g*(m/bf)*(1 - EXP(-(bf/m)*t))

     WRITE(2,*) t,Vin

     t = t + (b-a)/b

  END DO

  CLOSE(2)


  DO i = 1,n ! DO para llamar a la subrutina con cada ancho de paso.

     CALL met_euler(velo,V0,a,b,h(i),archi(i),n) !Subrutina con el metodo de euler.

  END DO


  OPEN(20, FILE = "plotear.plt", ACTION = "write",STATUS = "unknown") ! OPEN para crear archivo con toda las caracteristicas a graficar.


  FF = '(A,A'              ! Bloque de codigo para crear el formato que
  DO i=1, 3*n              ! usaremos al momento de escribir los archivos
  FF = TRIM(FF) // ',A'    ! en el archivo a plotear.
  END DO
  FF = TRIM(FF) // ',A,A)'


  WRITE(20,*) 'set title "Aproximaciones usando Euler de la velocidad en la caida de un fluido"'

  WRITE(20,*) 'set xlabel "tiempo"'

  WRITE(20,*) 'set ylabel "velocidad"'

  WRITE(20,*) 'set terminal png'

  WRITE(20,*) 'set output "Caida_en_un_fluido.png"'

  WRITE(20,*) 'show label'


     WRITE(20,FF) 'plot "sol_analitica"',(',"',TRIM(archi(i)),'"',i=1,n) 


  CLOSE(20)


  CALL system('gnuplot -p "plotear.plt"') ! CALL para llamar a gnuplot para que lea el contenido del archivo plotear.plt para que grafique los anchos de pasos junto con la solucion analitica.

  CONTAINS

  FUNCTION velo(Vin,nada) !Funcion que usara el metodo de euler para calcular el cambio de velocidad por tiempo.

    REAL :: velo
    REAL, INTENT(IN) :: Vin, nada

    velo = g - (bf/m)*Vin 

  END FUNCTION velo
  
END PROGRAM caida_en_un_fluido


    
