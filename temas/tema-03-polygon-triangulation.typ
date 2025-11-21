#import "../parts/macros.typ" : *

== Tema 3: Polygon Triangulation

=== Triangulación
Sea $P$ un polígono simple con $n$ vértices. Una *triangulación* es una descomposición de $P$ en triángulos disjuntos mediante un conjunto maximal de diagonales que no se intersectan.
#bloque-definicion("Diagonal", [Segmento de línea abierto que conecta dos vértices de $P$ y yace completamente en el interior de $P$.])

#bloque-teorema([
  Todo polígono simple admite una triangulación, y cualquier triangulación de un polígono simple con $n$ vértices consiste en exactamente $n - 2$ triángulos.
])

=== 3-Coloring y Guardias
- El *dual graph* de un polígono simple triangulado (donde cada cara es un nodo y son adyacentes si comparten una arista) es un árbol.

#bloque-lemma("Los vértices de un polígono simple triangulado siempre pueden ser 3-coloreados.")
#bloque-teorema([Para un polígono simple triangulado y 3-coloreado, una de las clases de color es usada por a lo más $floor(n/3)$ vértices. Colocar cámaras en estos vértices es suficiente para vigilar todo el polígono.])

=== Particionado en Polígonos Monótonos
Para triangular un polígono general, una estrategia eficiente es dividirlo primero en piezas más simples llamadas polígonos monótonos.

#bloque-definicion([$y$-monotone], [Un polígono simple es $y$-monotone si cualquier línea horizontal lo intersecta en un conjunto conectado (o no lo intersecta en absoluto).
- Un polígono $y$-monotone tiene un vértice superior, un vértice inferior y dos cadenas $y$-monotone entre ellos.
])
==== Tipos de Vértices
Para el algoritmo de barrido (sweep-line), clasificamos los vértices según sus vecinos y el ángulo interior:
- *Start*: Ambos vecinos están debajo. Ángulo interior $< pi$.
- *End*: Ambos vecinos están arriba. Ángulo interior $< pi$.
- *Split*: Ambos vecinos están debajo. Ángulo interior $> pi$.
- *Merge*: Ambos vecinos están arriba. Ángulo interior $> pi$.
- *Regular*: Uno vecino arriba y otro abajo.

==== Sweep Line Algorithm
El objetivo es particionar $P$ en polígonos $y$-monotone eliminando los vértices *Split* y *Merge* mediante diagonales.
- *Status ($T$)*: Árbol binario de búsqueda con las aristas que intersectan la línea de barrido y tienen el polígono a su derecha.
- *Helper*: Para una arista $e$, el `helper(e)` es el vértice $v$ más bajo por encima de la línea de barrido tal que el segmento horizontal entre $e$ y $v$ está dentro de $P$.

#bloque-algoritmo("HandleEvents", "v, T", [
// Dependiendo del tipo de vértice v:

Si v es Start: Insertar la arista incidente CCW (counter-clockwise) en T helper(arista) ← v

Si v es End: Eliminar la arista incidente CW (clockwise) de T

Si v es Split: Buscar en T la arista e directamente a la izquierda de v Dibujar diagonal entre v y helper(e) helper(e) ← v Insertar arista incidente CCW en T con helper = v

Si v es Merge: Eliminar arista incidente CW de T Buscar en T la arista e directamente a la izquierda de v // (Nota: lógica simplificada, ver manejo de helpers previos) helper(e) ← v

Si v es Regular: Si el polígono está a la derecha de las aristas incidentes: Reemplazar arista superior por inferior en T helper(nueva arista) ← v Si el polígono está a la izquierda: Buscar arista e directamente a la izquierda de v helper(e) ← v

])

#bloque-teorema([Un polígono simple con $n$ vértices puede ser particionado en piezas $y$-monotone en tiempo $O(n log n)$.])

=== Triangulating a Monotone Polygon
Una vez que tenemos polígonos monótonos, podemos triangularlos eficientemente.
- Se procesan los vértices ordenados por coordenada $y$ (merge de la cadena izquierda y derecha).
- Se utiliza una pila ($S$) para mantener los vértices de la cadena "cóncava" actual que necesitan ser conectados.

#bloque-algoritmo("TriangulateMonotonePolygon", "P", [
```
Ordenar vértices u_1...u_n por y-coordinate Stack S S.push(u_1); S.push(u_2)

Para j = 3 hasta n-1: Si u_j y S.top() están en cadenas diferentes: Mientras S no esté vacío: v ← S.pop() Si S no está vacío, dibujar diagonal (u_j, v) S.push(u_j) S.push(u_j)

Si u_j y S.top() están en la misma cadena:
    v ← S.pop()
    Mientras S no vacía y u_j "ve" a S.top():
        v ← S.pop()
        Dibujar diagonal (u_j, v)
    S.push(v)
    S.push(u_j)

// Procesar último vértice u_n con el resto de la pila Dibujar diagonales desde u_n a todos en S (excepto el primero y último)
```
])

=== Complejidad Final
- *Partitioning:* $O(n log n)$ debido al ordenamiento de eventos y operaciones en el BST ($T$).
- *Triangulating Monotone:* $O(n)$ (Teorema 3).
- *Total:* Un polígono simple con $n$ vértices puede ser triangulado en tiempo $O(n log n)$.