#let alg-counter = counter("alg-num")

#let bloque-algoritmo = (titulo, parametros, codigo) => {
  alg-counter.step()                           // incrementa el contador
  // el valor se muestra dentro de un contexto
  [
    #line(length: 100%)
    *Algoritmo #context alg-counter.display("1"):  #titulo (#parametros)*
    #line(length: 100%)
    #codigo
    #line(length: 100%)
  ]
}

#let teo-counter = counter("teo-num")

#let bloque-teorema(titulo: none, contenido) = {
  teo-counter.step()
  block(
    fill: rgb("#f9f9f9"),     // Fondo gris muy claro
    stroke: 0.5pt + black,    // Borde negro fino
    inset: 12pt,              // Margen interior
    radius: 4pt,              // Bordes redondeados
    width: 100%,              // Ancho completo
    breakable: false          // Intenta no romper el cuadro entre páginas
  )[
    // Cabecera del Teorema
    *Teorema #context teo-counter.display("1"):  #titulo* \
    #contenido
  ]
}

#let lem-counter = counter("lem-num")

#let bloque-lemma(contenido) = {
  lem-counter.step()
  block(
    fill: rgb("#f9f9f9"),     // Fondo gris muy claro
    stroke: 0.5pt + black,    // Borde negro fino
    inset: 12pt,              // Margen interior
    radius: 4pt,              // Bordes redondeados
    width: 100%,              // Ancho completo
    breakable: false          // Intenta no romper el cuadro entre páginas
  )[
    *Lemma #context lem-counter.display("1"):* \
    #contenido
  ]
}

#let def-counter = counter("def-num")

#let bloque-definicion(titulo, contenido) = {
  def-counter.step()
  block(
    fill: rgb("#f9f9f9"),     // Fondo gris muy claro
    stroke: 0.5pt + black,    // Borde negro fino
    inset: 12pt,              // Margen interior
    radius: 4pt,              // Bordes redondeados
    width: 100%,              // Ancho completo
    breakable: false          // Intenta no romper el cuadro entre páginas
  )[
    *Definición #context def-counter.display("1"):  #titulo* \
    #contenido
  ]
}