#import "../parts/macros.typ" : bloque-algoritmo

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

#bloque-algoritmo("FindIntersections", "S", [
```
Q ← ∅                  // Cola de eventos (BST)
T ← estructura vacía   // Estado del sweep-line (BST)

// Insertar todos los endpoints en la cola de eventos
for cada segmento s en S:
    para cada endpoint p de s:
        si p no está en Q:
            insertar p en Q
            L(p) ← ∅          // Segmentos que empiezan en p
            U(p) ← ∅          // Segmentos que terminan en p
            C(p) ← ∅          // Intersecciones encontradas en p
        si p es extremo inferior de s:
            L(p).agregar(s)
        si p es extremo superior de s:
            U(p).agregar(s)

mientras Q no esté vacía:
    p ← Q.nextEvent()        // Extrae siguiente evento
    Q.deleteEvent(p)
    handleEvent(p)           // Procesa el evento
```
])

#bloque-algoritmo("handleEvent", "p", [
```
si |L(p) ∪ U(p) ∪ C(p)| > 1:
  reportar intersección en p

eliminar de T todos los segmentos en L(p) ∪ C(p)
insertar en T todos los segmentos en U(p) ∪ C(p)

si U(p) ∪ C(p) está vacío:
    b_left  ← vecino izquierdo de p en T
    b_right ← vecino derecho de p en T
    findNewEvent(b_left, b_right, p)
de lo contrario:
    s_left  ← segmento más a la izquierda en U(p) ∪ C(p)
    s_right ← segmento más a la derecha en U(p) ∪ C(p)

    b_left  ← vecino izquierdo de s_left en T
    b_right ← vecino derecho de s_right en T

    findNewEvent(b_left, s_left, p)
    findNewEvent(b_right, s_right, p)
```
])

#bloque-algoritmo("findNewEvent", "s, s', p", [
```
si s y s' no se intersectan:
        return

    x ← punto de intersección entre s y s'

    // Ignorar intersecciones que ocurran antes del sweep
    si x está por debajo de la sweep-line o a la derecha de p:
        si x no está en Q:
            Q.insert(x)

        // Clasificar intersección relativa a cada segmento
        si x está dentro de s:
            C(x).agregar(s)
        si x está dentro de s':
            C(x).agregar(s')
```
])