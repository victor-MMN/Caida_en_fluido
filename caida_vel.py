# Programa modular para aproximar la ecuacion de velocidad en un fluido y en interracion con la gravedad, 
# usando el metodo de euler con diferentes anchos de paso y graficarlos juntos con la ecuacion analitica.

#  	 Diccionario de variables:

#	 g: Constante de gravedad, real.
#	 m: Masa del objeto, real.
#	 a: Intervalo inferior, real.
#	 b: Intervalo superior, real.
#	 h: Anchos de paso, real, arreglo.
#	 analit: Tiempos de la funcion analitica, real, arreglo.
#	 analiv: Velocidades de la funcion analitica, real, arreglo.
#	 aproxt: Tiempos de la h a aproximar, real, arreglo.
#	 euler: Velocidades de la h a aproximar, real, arreglo.
#	 n: Cantidad de anchos de paso a evaluar, entero.
#	 t: Tiempo a evaluar, real.
#	 bf: Constante de friccion del fluido, real.
#	 Vin: Velocidad en ese momento, real.
#    V0: Velocidad inicial, real.
#	 i,j,c: Contadores o asignadores, entero.
#    nada: Variable que no vamos a usar pero la necesitamos por que la funcion necesita dos variables, real.

import math # Paquete para usar las funciones trigonometricas.
import sys  # Paquete para usar el comando exit() que permite detener el programa en esa linea.
import matplotlib.pyplot as plt # Paquete para plottear.
import numpy as np # Paquete para crear arreglos.
# import pandas as pd # Paquete para crear un archivo interno(dataframe). No lo use pero lo dejare aqui.



m = float(input("Cual es la masa del objeto(kg)? "))

if m <= 0: # If antitroleo.

	sys.exit("La masa no puede ser negativa")


bf = float(input("Cual es la friccion del fluido/kg/s)? "))


v0 = float(input("Cual es la velocidad incial(m/s)? "))


a = float(input("Cual es el limite inferior del intervalo? "))


b = float(input("Cual es el limite superior del intervalo? "))


if a > b: # If antitroleo.

	sys.exit("El limite inferior no puede ser mayor que el superior")


n = int(input("Cuantos anchos de paso quieres graficar? "))

if n <= 0: # If antitroleo.

	sys.exit("El numero de anchos de paso no puede ser negativo ni cero")



h = [] # Declara h como arreglo.
j = 0
while j <= n-1: # While para pedir y asignar los elemntos de h, es hasta n-1 porque los arreglos empiezan en 0.

	c = float(input("Cual es el ancho de paso " + str(j+1) + "?  "))

	if c <= 0: # If antitroleo.
		sys.exit("El ancho de paso no puede ser negativo ni cero")

	h.append(c) 
	j += 1


g = 9.80665 #Valor de la gravedad.


t = a # Inicializando el tiempo para usarlo en las funciones.





#Funciones.

def velo(t,Vin): # Funcion que usara el metodo de euler para calcular el cambio de vel por tiempo.

	velo = g - (bf/m)*Vin 

	return velo




def analitiem(t): # Funcion para guardar los tiempos en un arreglo de la funcion analitica.

	analit = []

	while t <= b:

		analit.append(t)

		t += (b-a)/b

	return analit



		

def analivel(t): # Funcion para guardar las velocidades en un arreglo de la funcion analitica.

	analiv = []

	while t <= b: # Mientras t sea menor o igual a b(limite superior) que haga lo que sigue.
		
		Vin = v0*math.exp(-(bf/m)*t) + g*(m/bf)*(1 - math.exp(-t*(bf/m))) 

		analiv.append(Vin)

		t += (b-a)/b

	return analiv




def aproxtiem(t,h): # Funcion para guardar los tiempos de la h a aproximar.

	aproxt = []

	while t <= b:

		aproxt.append(t)

		t += h

	return aproxt



def euler(f,y0,a,b,h): # Metodo de euler.

	t,y = a,y0 # Inicializamos variables.

	euler = []

	while t <= b: # Mientras t sea menor o igual a b(limite superior) que haga lo que sigue.

		y = y + h * f(t,y)
		euler.append(y)

		t += h

	return euler




# LLamado de funciones 


j = 0
while j <= n-1: # While para plotear las diferentes h's.
	plt.plot(aproxtiem(t,h[j]), euler(velo,v0,a,b,h[j]), label = "aprox_h= " + str(h[j]))
# Para graficas continuos debes usar el comando plot, pero lo que debes de darle a este comando son 
# arreglos con todos los datos a plotear que se te graficaran como una linea continua, por eso el eje x (tiempo)
# es un arreglo igual que el y (metod. euler).
	j += 1


plt.plot(analitiem(t),analivel(t), color = "red",label = "sol_analitica")




# Comandos para el plot.


plt.legend(loc = "upper right") # Con esto hago que aparezcan las etiquetas arriba a la derecha.
plt.xlabel("tiempo")
plt.ylabel("velocidad")
plt.title("Aproximacion vs analitica caida en un fluido")
plt.show() # Comando para que grafique los dos plots internos de plt.scatter en una sola grafica.












