# caída en un fluido

Programa que calcula la velocidad en caída libre de un cuerpo dentro de un fluido en presencia del campo gravitacional. Donde suponemos que el movimiento es unidimensional, solo cae. Usamos el método de Euler para aproximar la ecuación diferencial de primer grado $$\frac{dv}{dt} = g - \frac{bf}{m}v$$

Siendo $g$ la acceleracion gravitacional, $bf$ la viscosidad del fluido y $m$ la masa del cuerpo.

Comparamos la aproximación numérica con la función analítica. El problema fue programado en los lenguajes Fortran y Python:

* En Python todas las subrutinas están integradas en el programa *caida_vel.py*

* En Fortran se separa el método de Euler (*met_euler.f90*)  del programa principal *vel_caida.f90*
