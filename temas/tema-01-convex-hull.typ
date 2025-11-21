#import "../parts/macros.typ" : bloque-algoritmo

== Tema 1: Convex Hull

El _convex hull_ $ cal(C H) (P)$ de un conjunto de puntos $P$ en el plano es el polígono convexo más pequeño que contiene a todos los puntos de $P$.

#bloque-algoritmo("GrahamScan", "P", [
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
])

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
