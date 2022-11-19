#Fichero para la prueba y comparativa rendimiento

import time
import py_orbit
import cy_orbit




formato_datos = "{:.5f},{:.5f}\n"



for i in range(1000000, 100000000, 1000000):

    planeta_cy = cy_orbit.Planet()
    planeta_py = py_orbit.Planet()

    #prueba.pruebaa()
    init_time = time.time()
    py_orbit.step_time(planeta_py, i, i)
    fin_time = time.time()
    total_time_python = fin_time - init_time

    init_time = time.time()
    cy_orbit.step_time(planeta_cy, i, i)
    fin_time = time.time()
    total_time_cython = fin_time - init_time
    
    
    with open("results.csv", "a") as archivo:
        archivo.write(formato_datos.format(total_time_python, total_time_cython))

