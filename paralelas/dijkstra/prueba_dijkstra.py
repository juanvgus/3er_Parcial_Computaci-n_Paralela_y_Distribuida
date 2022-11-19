import time
import py_dijkstra
import cy_dijkstra

dijkstra_cy = cy_dijkstra.coordenadas
dijkstra_py = py_dijkstra.coordenadas

formato_datos="{:.5f},{:5f}\n"


for i in range(30):
	inicioPy=time.time()
	py_dijkstra.hill_climbing(dijkstra_py)
	finalPy=time.time()-inicioPy

	inicioCy=time.time()
	cy_dijkstra.hill_climbing(dijkstra_cy)
	finalCy=time.time()-inicioCy

	with open("tierra.csv","a") as archivo:
		archivo.write(formato_datos.format(finalPy,finalCy))