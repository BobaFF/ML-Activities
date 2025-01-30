#import "@preview/fletcher:0.5.2" as fletcher: diagram, node, edge, shapes
#set text(font: "New Computer Modern")
#set document(author: "Francesco Furno", title: "Alpaydin's Book: Ex. 11.14.3 NN")
#set page(numbering: "1/1")
#align(center,
  [
    #line(length: 100%)
    #text(smallcaps("Alpaydin's Book: Ex. 11.14.3 NN"), 20pt)\
    #v(4pt)
  #text(("Machine Learning 2024-25 Course Activity"), 14pt, style: "italic")\
    #v(1pt)
  #text(("Furno Francesco - francesco.furno@studenti.unipd.it - 2139507 "), 12pt, style: "italic")\
    #v(1pt)
  December 18, 2024
  #line(length: 100%)
  
  ]
)
#let n(coordinates, text, name, label) = {
  if label == 0 {
    node(coordinates, [#strong(text)], name: name, fill: red.lighten(70%), stroke: black + 0.5pt, outset: 5pt)
  } else if label == 1 {
    node(coordinates, [#strong(text)], name: name, fill: green.lighten(70%), stroke: black + 0.5pt, outset: 5pt)
  } else {
    node(coordinates, [#strong(text)], name: name, shape: circle, fill: gray.lighten(70%), stroke: black + 0.5pt, outset: 5pt)
  }
}

#let e(name1, name2, sign) = {
  if sign == 1 {
    edge(name1, name2, "->", [True])
  }
  else {
     edge(name1, name2, "->", [False])
  }
}

#let simple_table(header, args) = {
  show table.cell.where(y: 0): strong
  set table(
    stroke: (x, y) =>  if y == 0 and x > 0 {
      (bottom: 0.7pt + black, left: 0.7pt + black)
    } else if y == 0  {
      (bottom: 0.7pt + black)
    } else if y>0 and x > 0 {
      (left: 0.7pt + black)
    },
    align: (x, y) => (
      if x > 0 { center }
      else { left }
    )
  )
  align(center, block(table(
    align: center,
    inset: 0.6em,
    columns: header.len() * (auto, ),
    table.header(..header),
    ..args
  ), width: 70%))
}
= Exercise 11.14.3
Show the perceptron that calculates the parity of its three inputs.

= Parity function
Let's see what is a parity function. There exist two types of it:
- *even parity*: outputs 1 when the number of values set to 1 is even. For example: 
  - $1, 0, 1 => 1$
  - $1, 0, 0 => 0$
  
- *odd parity*: outputs 1 when the number of values set to 1 is odd. For example:
  - $1, 0, 1 => 0$
  - $1, 1, 1 => 1$
  

Now, let's consider three inputs, $A, B, C$ and the _odd parity_ function. 
#figure(simple_table(($bold(A)$, $bold(B)$, $bold(C)$, $bold("Parity"(A, B, C))$), (
  "0", "0", "0", "0",
  "0", "0", "1", "1",
  "0", "1", "0", "1",
  "0", "1", "1", "0",
  "1", "0", "0", "1",
  "1", "0", "1", "0",
  "1", "1", "0", "0",
  "1", "1", "1", "1",
)), caption: [$"Parity"(A, B, C)$ truth table])

Note that the _even parity_ function can be obtained as $not "Parity"(A, B, C)$.

== Relation between Parity and XOR



The XOR function is strictly related to the parity function. The XOR function directly computes the _odd parity_ of its input.\
#figure(simple_table(($bold(A)$, $bold(B)$, $C$, $bold(A xor B)$, $bold(A xor B xor C)$), (
  "0", "0", "0", "0", "0",
  "0", "0", "1", "0", "1",
  "0", "1", "0", "1", "1",
  "0", "1", "1", "1", "0",
  "1", "0", "0", "1", "1",
  "1", "0", "1", "1", "0",
  "1", "1", "0", "0", "0",
  "1", "1", "1", "0", "1",
)), caption: [$A xor B xor C$ truth table])


Hence, 
- the _odd parity_ of ($A, B, C$) can be seen as $(A xor B xor C)$.\

- the _even parity_ of ($A, B, C$) can be seen as $not(A xor B xor C)$

== Perceptron implementation? Not with a single layer
We already saw that the _odd parity_ function can be seen as a combination of two XOR functions. Is it possible to implement a perceptron for the _odd parity_ function? Not with a single layer, in fact, there is no hyperplane that linearly separates the positive and negative values in the XOR function. 
#align(center, figure(diagram(
  edge((-0, 1.5),(-0, -0.75),  "-", "dotted"),
  edge((1, 1.5),(1, -0.75),  "-", "dotted"),
  edge((-1, 1), (2, 1), "-", "dotted"),
  edge((-1, 0), (2, 0), "-", "dotted"),
  node((0,0), [$bold(+)$],fill: gray.lighten(70%), stroke: black + 0.5pt, outset: 5pt, shape: circle, name: <1>),
  node((1,0), [$bold(-)$],fill: white.lighten(70%), stroke: black + 0.5pt, outset: 5pt, shape: circle, name: <1>),
  node((0,1), [$bold(-)$],fill: white.lighten(70%), stroke: black + 0.5pt, outset: 5pt, shape: circle, name: <1>),
  node((1,1), [$bold(+)$],fill: gray.lighten(70%), stroke: black + 0.5pt, outset: 5pt, shape: circle, name: <1>),

  node((-0.75, 0), $B = 1$),
  node((-0.75, 1), $B = 0$),
  node((0, 1.75), $A = 0$),
  node((1, 1.75), $A = 1$),

), caption: [Visual representation of $A xor B$]))

Since the XOR function, which forms the basis of the parity function, is not linearly separable, it is impossible to construct a hyperplane that separates the positive and negative values of the parity function in a three-dimensional space. Consequently, a single-layer perceptron cannot implement the parity function for three inputs.

== XOR perceptron
