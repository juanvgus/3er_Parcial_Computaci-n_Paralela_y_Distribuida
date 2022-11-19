cimport cython

import math
import random
from scipy.spatial import distance
import numpy as np



# Coordenadas de las ciudades de Djibouti
def coordenadas(int n):
  coordenadas = np.array([[round(random.uniform(10000.000000,20000.000000),6),round(random.uniform(40000.000000,50000.000000),6)] for i in range(n)])
  return coordenadas
"""
Funcion que genera la matriz de adyacencia de las coordenadas dadas
Recibe como parámetros las coordenadas de las ciudades y retorna una
matriz de adyacencia con las normas para estas coordenadas
"""
def generar_matriz(coordenada):
  matrix = []
  cdef int i, j
  cdef float p
  for i in range(len(coordenada)):
    for j in range(len(coordenada)):
      # Se encuentra la norma entre las coordenadas
      p = np.linalg.norm(coordenada[i] - coordenada[j])
      # Se agrega la norma a la matriz
      matrix.append(p)
  # Se aplica un reshape
  matrix = np.reshape(matrix, (len(coordenada),len(coordenada)))
  return matrix

"""
Función que retorna una solución aleatoria para el algoritmo de HillClimbing.
Recibe como parámetros la matriz de adyacencia
"""
def solucionRandom(matrix):
  nodos = list(range(0, len(matrix)))
  cdef int i, nodoRandom
  solucion = []
  for i in range(0, len(matrix)):
    nodoRandom = nodos[random.randint(0, len(nodos) - 1)]
    solucion.append(nodoRandom)
    nodos.remove(nodoRandom)
  return solucion

"""
Función que retorna la distancia total de la ruta de una solución recibida como parámetro
Recibe como parámetros la matriz de adyacencia y una solución
"""
def distanciaRuta(matrix, solucion):
    cdef int distanciaRutaActual = 0
    cdef int i
    for i in range(0, len(solucion)):
        distanciaRutaActual += matrix[solucion[i]][solucion[i - 1]]
    return distanciaRutaActual

"""
Función que recibe como parámetros una matriz de adyacencia y una solución
Retorna la mejor lista de vecinos junto con la mejor ruta
"""
def vecinos(matrix, solucion):
    vecinos = []
    cdef int i, j
    # Se buscan todos los vecinos posibles de la solucion entregada
    for i in range(len(solucion)):
      for j in range(i + 1, len(solucion)):
        # Se crea una copia de la solucion
        vecino = solucion.copy()
        # Se reemplaza el vecino i por la solucion j
        vecino[i] = solucion[j]
        # Se reemplaza el vecino j por la solucion i
        vecino[j] = solucion[i]
        # Se incluye el nuevo vecino en la lista de vecinos
        vecinos.append(vecino)
            
    # Se asume que el primer vecino de la lista es el mejor
    mejorVecino = vecinos[0]
    cdef float mejorRuta = distanciaRuta(matrix, mejorVecino)
    cdef float rutaActual
    # Se revisa si existe o no un mejor vecino
    for vecino in vecinos:
      rutaActual = distanciaRuta(matrix, vecino)
      if rutaActual < mejorRuta:
        mejorRuta = rutaActual
        mejorVecino = vecino
    return mejorVecino, mejorRuta

"""
Función que ejecuta el algoritmo HillClimbing
Recibe como parámetros las coordenadas que deben ser visitadas
Retorna la cantidad de nodos, el valor de la mejor ruta y la mejor ruta
"""
def hill_climbing(coordenadas):
  # Inicializacion de la matriz
  matrix = generar_matriz(coordenadas)

  solucionActual = solucionRandom(matrix)
  rutaActual = distanciaRuta(matrix, solucionActual)

  vecinoss = vecinos(matrix, solucionActual)
  vecino = vecinoss[0]
  mejorVecino, mejorRutaVecino = vecinos(matrix, vecino)
  # Mientras que la ruta actual sea mayor a la mejor ruta...
  while mejorRutaVecino < rutaActual:
    rutaActual = mejorVecino
    rutaActual = mejorRutaVecino
    vecino = vecinos(matrix, solucionActual)[0]
    mejorVecino, mejorRutaVecino = vecinos(matrix, vecino)
  #print("\nMejor ruta: \n", solucionActual)
  #print("\nDistancia de mejor ruta: ", rutaActual)
  return rutaActual, solucionActual
