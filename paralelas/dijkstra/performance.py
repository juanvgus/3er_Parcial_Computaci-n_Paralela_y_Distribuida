#Fichero para la prueba y comparativa rendimiento

import time
import py_dijkstra
import cy_dijkstra



formato_datos = "{:.5f},{:.5f}\n"



for i in range(1200, 5000, 50):

    dijkstra_cy = cy_dijkstra.coordenadas(i-8)
    dijkstra_py = py_dijkstra.coordenadas(i)

    #prueba.pruebaa()
    init_time = time.time()
    py_dijkstra.hill_climbing(dijkstra_py)
    fin_time = time.time()
    total_time_python = fin_time - init_time

    init_time = time.time()
    cy_dijkstra.hill_climbing(dijkstra_cy)
    fin_time = time.time()
    total_time_cython = fin_time - init_time

    
    
    
    with open("results1.csv", "a") as archivo:
        archivo.write(formato_datos.format(total_time_python, total_time_cython))
