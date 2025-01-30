#import "@preview/fletcher:0.5.2" as fletcher: diagram, node, edge, shapes
#set text(font: "New Computer Modern")
#set document(author: "Francesco Furno", title: "Alpaydin's Book: Ex. 11.14.2 NN")
#set page(numbering: "1/1")
#align(center,
  [
    #line(length: 100%)
    #text(smallcaps("Alpaydin's Book: Ex. 11.14.2 NN"), 20pt)\
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
= Exercise 11.14.2
Show the perceptron that calculates NAND of its two inputs.

== $bold(A "NAND" B)$
$A "NAND" B$ is a boolean function that can be rewritten as $not (A and B)$.

The following is the truth table for this boolean function:
#figure(simple_table(($bold(A)$, $bold(B)$, $bold(A and B)$, $bold(not (A and B))$), (
  "0", "0", "0", "1",
  "0", "1", "0", "1",
  "1", "0", "0", "1",
  "1", "1", "1", "0",
)), caption: [$not (A and B)$ truth table])

== Perceptron implementation
We consider two inputs $A$ and $B$. 
We know that the perceptron should return 0 only if both $A$ and $B$ are set to 1, 1 otherwise. 

Note that it is possible to implement a perceptron for the NAND operator because it is a linearly separable function, making it perfectly suited for a perceptron

We set the input layer as follows:
- $x_0$ = 1

- $x_1 = A$

- $x_2 = B$

Now, let's assign the weights. We know that the function should output 0 when $x_1 = 1 and x_2 = 1$, so when their sum is higher than 1.5. Then, the function should output 1 in all the other cases,so  when $x_1 + x_2$ is lower than 1.5. We can set the weights as follows:

- $w_0 = 1.5$

- $w_1 = -1$

- $w_2 = -1$





#align(center, figure(diagram(
  node((0.55,-1), [$x_0 = 1$], shape: circle, name: <x0>),
  node((0,0), [$x_1$],fill: gray.lighten(70%), stroke: black + 0.5pt, outset: 5pt, shape: circle, name: <x1>),
  node((0,+1), [$x_2$],fill: gray.lighten(70%), stroke: black + 0.5pt, outset: 5pt, shape: circle, name: <x2>),
  node((2,0), [$bold(sum)$], stroke: black + 0.5pt, outset: 5pt, shape: circle, name:<sum>),
  node((5,0), [#image("step.png", height: 1em)], stroke: black + 0.5pt, outset: 5pt, shape: circle, name:<sign>),
  node((9,0), "", stroke: black + 0.5pt, outset: 5pt, shape: circle, name:<output>),
  node((1.25, 0.8), $w_2 = -1$),
  edge(<x0>, <sum>, "-", $w_0 = 1.5$),
  edge(<x1>, <sum>, "-", $w_1 = -1 "    "$),
  edge(<x2>, <sum>, "-"),
  edge(<sum>, <sign>, "->", $italic("net")$),
  edge( <sign>, <output>, "->", $o = italic("sign(net)")$)
)))
where $italic("net") = sum_(i = 0)^n w_i x_i space "and" o = sigma(italic("net")) = italic("sign(net)") $.

\
Now, let's consider all the possible values for inputs $x_1$ and $x_2$.

== $bold(x_1 = 0"," x_2 = 0)$
The threshold expression is the following:
 $ italic("sign"("net")) &= italic("sign")(w_0 dot 1 + w_1 dot 0 + w_2 dot 0) \ &= italic("sign")(1.5 dot 1 +  (-1) dot 0 + (-1) dot 0) \ &= italic("sign")(1.5) = 1 $
 
 == $bold(x_1 = 0"," x_2 = 1)$
The threshold expression is the following:
 $ italic("sign"("net")) &= italic("sign")(w_0 dot 1 + w_1 dot 0 + w_2 dot 1) \ &= italic("sign")(1.5 dot 1 +  (-1) dot 0 + (-1) dot 1) \ &= italic("sign")(0.5) = 1 $
 
 == $bold(x_1 = 1"," x_2 = 0)$
The threshold expression is the following:
 $ italic("sign"("net")) &= italic("sign")(w_0 dot 1 + w_1 dot 1 + w_2 dot 0) \ &= italic("sign")(1.5 dot 1 +  (-1) dot 1 + (-1) dot 0) \ &= italic("sign")(0.5) = 1 $

== $bold(x_1 = 1"," x_2 = 1)$
The threshold expression is the following:
 $ italic("sign"("net")) &= italic("sign")(w_0 dot 1 + w_1 dot 1 + w_2 dot 1) \ &= italic("sign")(1.5 dot 1 +  (-1) dot 1 + (-1) dot 1) \ &= italic("sign")(-0.5) = -1 => 0 $

Hence, the perceptron correctly implements the NAND operator. This demonstrates that the NAND operator is linearly separable and can be represented by a single-layer perceptron.
 
