= Apuntes INF452 - Geometría Computacional

== Tema 1: Convex Hull

El _convex hull_ $ cal(C H) (P)$ de un conjunto de puntos $P$ en el plano es el polígono convexo más pequeño que contiene a todos los puntos de $P$.

// Pseudocódigo del algoritmo de Graham Scan
// Entrada: Un conjunto de puntos P
// Salida: Lista cal(L) de puntos que forman el convex hull ordenados en sentido antihorario
#line(length: 100%)
*Algoritmo: GrahamScan(P)*
#line(length: 100%)
```
P0 = punto con la coordenada y más baja en P
ordenar P por el ángulo polar con respecto a P0
L = pila vacía
push(L, P0)
push(L, P[1])
push(L, P[2])

for i desde 3 hasta longitud(P) - 1:
    while tamaño(L) > 1 y orientación(segundo_tope(L), tope(L), P[i]) > 0:
        pop(L)
    push(L, P[i])

return L
```
#line(length: 100%)

=== Verificar orientación
Para verificar la orientación de tres puntos $p$, $q$ y $r$, podemos usar el producto cruzado de los vectores $dash(p q)$ y $dash(q r)$.

- Si el resultado es positivo, los puntos hacen un *giro a la izquierda*.
- Si el resultado es negativo, los puntos hacen un *giro a la derecha*.
- Si el resultado es cero, los puntos son *colineales*.

=== Expresión matemática
La orientación se puede calcular usando la siguiente expresión:
$
op("Orientación") (p, q, r) = (q_x - p_x)(r_y - q_y) - (q_y - p_y)(r_x - q_x)
$

Complejidad temporal: $O(n log n)$

== Tema 2: Line Segment Intersection

=== Line Segment
Un *line segment* $s = dash(p q)$ es un subconjunto de una línea recta que está delimitado por dos puntos finales.

Formalmente, para $p$, $q$ en $R^2$, el segmento de línea $dash(p q)$ se define como:
$
  dash(p q) = { (1 - lambda)p + lambda q : lambda ∈ [0, 1] }.
$

=== Problema
Dado un conjunto de segmentos de línea $S = {s_1, s_2, ..., s_n}$ en el plano, encontrar todos los puntos de intersección entre los segmentos en $S$ y a qué segmentos pertenecen.

- Oservación: Dos segmentos *pueden* intersectarse si y solo si sus $y$_-spans_ se solapan y son _adyacentes_ horizontalmente en ese punto.

==== Definición: Sweeping Line
Una *sweeping line* es una línea imaginaria que escanea el plano en alguna dirección determinada, detectando eventos importantes, reduciéndo así la complejidad del problema al tener que computar solo en esos eventos. Esta técnica mantiene:

- *Eventos*: Puntos donde ocurren cambios significativos (intersecciones, inicios y finales de segmentos), aquí es donde se actualiza la estructura de datos.
- *Status*: Estructura de datos que mantiene la información relevante sobre el estado actual de la línea de barrido.

En este caso, la *sweeping line* se mueve de arriba hacia abajo, deteniendose en: inicios de segmentos, finales de segmentos e intersecciones entre segmentos. El status se mantiene como una lista ordenada de segmentos que intersectan la línea de barrido en el orden en que aparecen de izquierda a derecha.

#line(length: 100%)
*Algoritmo: FindIntersections(S)*
#line(length: 100%)
```
```