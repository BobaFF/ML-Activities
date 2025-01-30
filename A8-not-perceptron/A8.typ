#import "@preview/fletcher:0.5.2" as fletcher: diagram, node, edge, shapes
#set text(font: "New Computer Modern")
#set document(author: "Francesco Furno", title: "Perceptron implementation of the not operator")
#set page(numbering: "1/1")
#align(center,
  [
    #line(length: 100%)
    #text(smallcaps("Perceptron implementation of the not operator"), 20pt)\
    #v(4pt)
  #text(("Machine Learning 2024-25 Course Activity"), 14pt, style: "italic")\
    #v(1pt)
  #text(("Furno Francesco - francesco.furno@studenti.unipd.it - 2139507 "), 12pt, style: "italic")\
    #v(1pt)
  November 24, 2024
  #line(length: 100%)
  
  ]
)


= NOT operator
The NOT operator can be implemented as a Perceptron with a single connection.

The input is a single binary variable, $x in {0,1}$. Which value should we assign to the weights? 

The boolean function NOT returns the opposite value of the input:

- $"input" = 1 => "output " = -1$

- $"input" = 0 => "output " = 1$

where $-1 = italic("False") "and" 1 = italic("True")$.

With $a = x_0 = 1$, the weights should be:
  
- $ w_0 = 0.5$

- $ w_1 = -1$, since we are interested in the opposite value of $x_1$

Thanks to this configuration, we can map $italic("not"(0)) = 1 "and" italic("not")(1) = -1$:
#align(center, figure(diagram(
  node((0.55,-1), [$x_0 = 1$], shape: circle, name: <x0>),
  node((0,0), [$x_1$],fill: gray.lighten(70%), stroke: black + 0.5pt, outset: 5pt, shape: circle, name: <x1>),
  node((2,0), [$bold(sum)$], stroke: black + 0.5pt, outset: 5pt, shape: circle, name:<sum>),
  node((5,0), [#image("step.png", height: 1em)], stroke: black + 0.5pt, outset: 5pt, shape: circle, name:<sign>),
  node((9,0), "", stroke: black + 0.5pt, outset: 5pt, shape: circle, name:<output>),
  edge(<x0>, <sum>, "-", $w_0 = 0.5$),
  edge(<x1>, <sum>, "-", $w_1 = -1 "    "$),
  edge(<sum>, <sign>, "->", $italic("net")$),
  edge( <sign>, <output>, "->", $o = italic("sign(net)")$)
  

)))

where $italic("net") = sum_(i = 0)^n w_i x_i space "and" o = sigma(italic("net")) = italic("sign(net)") $.

\
Example, $x = 1$ 
 $ italic("sign"("net")) &= italic("sign")(w_0 dot 1 + w_1 dot 1) \ &= italic("sign")(0.5 dot 1 +  (-1) dot 1) \ &= italic("sign")(-0.5) = -1 $

 Example, $x = 0$
 $ italic("sign"("net")) &= italic("sign")(w_0 dot 1 + w_1 dot 0) \ &= italic("sign")(0.5 dot 1 +  (-1) dot 0) \ &= italic("sign")(0.5) = 1 $