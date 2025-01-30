#import "@preview/fletcher:0.5.2" as fletcher: diagram, node, edge, shapes
#set text(font: "New Computer Modern")
#set document(author: "Francesco Furno", title: "Mitchell's Book: Ex. 3.1 DTs")
#set page(numbering: "1/1")
#align(center,
  [
    #line(length: 100%)
    #text(smallcaps("Mitchell's Book: Ex. 3.1 DTs"), 20pt)\
    #v(4pt)
  #text(("Machine Learning 2024-25 Course Activity"), 14pt, style: "italic")\
    #v(1pt)
  #text(("Furno Francesco - francesco.furno@studenti.unipd.it - 2139507 "), 12pt, style: "italic")\
    #v(1pt)
  November 21, 2024
  #line(length: 100%)
  
  ]
)
#set heading(numbering: "1.")
#show outline.entry.where(level: 1): it => {strong(it)}
#outline(title: "Table of contents", indent: 1em)

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
= Exercise 3.1 from Mitchell's book
Give decision trees to represent the following boolean functions:
+ $A and not B$

+ $A or [ B and C ]$
+ $A xor B$
+ $[ A and B] or [C and D]$



== $A and not B$
$A and not B$ is a very simple boolean function: for this reason, logical reasoning is sufficient to compute its decision tree.\

The following is the truth table for this particular boolean function:
#figure(simple_table(($bold(A)$, $bold(B)$, $bold(not B)$, $bold(A and not B)$), (
  "0", "0", "1", "0",
  "0", "1", "0", "0",
  "1", "0", "1", "1",
  "1", "1", "0", "0",
)), caption: [$A and not B$ truth table])

We can easily observe that the behavior of the function is strictly related to $A$. In fact,  the function is always $0$ when $A = 0$. Regarding $B$, we can see that the function is always $0$ when $B = 1$.

Let's choose label $A$ for the root node. The computed DT is the following:
#align(center, figure(diagram(
  n((1, 0), "A", <a>, -1),
  
  n((0,1), "B", <b>, -1),
  n((2,1), "False", <12>, 0),
  n((-0.5,2), "False", <21>, 0),
  n((0.5,2), "True", <22>, 1),
  e(<a>, <b>, 1),
  e(<a>, <12>, 0),
  e(<b>, <21>, 1),
  e(<b>, <22>, 0),
),  caption: [DT-1 of $A and not B$] ),)

When $A$ is False, we can immediately conclude that the value of the function is False. Otherwise, we need to check the value of $B$ to make a final conclusion.

If we choose $B$ as label for the root node, the computed DT is the following:
#align(center, figure(diagram(
  n((1, 0), "B", <a>, -1),
  
  n((2,1), "A", <b>, -1),
  n((0,1), "False", <12>, 0),
  n((1.5,2), "True", <21>, 1),
  n((2.5,2), "False", <22>, 0),
  e(<a>, <b>, 0),
  e(<a>, <12>, 1),
  e(<b>, <21>, 1),
  e(<b>, <22>, 0),
),  caption: [DT-2 of $A and not B$] ),)

DT-1 and DT-2 have the same performance over the boolean function $A and not B$.

== $A or [ B and C ]$
$A or [ B and C ]$ is a simple boolean function: for this reason, logical reasoning is sufficient to compute its decision tree.\

The following is the truth table for this boolean function:
#figure(simple_table(($bold(A)$, $bold(B)$, $bold(C)$, $bold(B and C )$, $bold(A or [ B and C ])$), (
  "0", "0", "0", "0", "0",
  "0", "0", "1", "0", "0",
  "0", "1", "0", "0", "0",
  "0", "1", "1", "1", "1",
  "1", "0", "0", "0", "1",
  "1", "0", "1", "0", "1",
  "1", "1", "0", "0", "1",
  "1", "1", "1", "1", "1",
)), caption: [$A or [ B and C ]$ truth table])

Again, we can easily observe that the behavior of the function is strictly related to $A$. In fact,  the function is always $1$ when $A = 1$. Regarding $B$ and $C$, we cannot make strong conclusions independently, so we understand that the most "important" variable here is $A$, which will serve as the label for the root node.\

The computed DTs are the following, both with the same performance:
#grid(columns: 2, column-gutter: 3em, [
  #align(center, figure(diagram(
  n((1, 0), "A", <a>, -1),
  n((0,1), "True", <21>, 1),
  n((2,1), "B", <b>, -1),
  n((1,2), "C", <23>, -1),
    n((0.5,3), "True", <31>, 1),
    n((1.5,3), "False", <32>, 0),
  n((3,2), "False", <24>, 0),
  e(<a>, <21>, 1),
  e(<a>, <b>, 0),
  e(<b>, <23>, 1),
    e(<23>, <31>, 1),
    e(<23>, <32>, 0),
  e(<b>, <24>,0),
),  caption: [DT-1 of $A or [ B and C ]$] ),)
], [
  #align(center, figure(diagram(
  n((1, 0), "A", <a>, -1),
  n((0,1), "True", <21>, 1),
  n((2,1), "C", <b>, -1),
  n((1,2), "B", <23>, -1),
    n((0.5,3), "True", <31>, 1),
    n((1.5,3), "False", <32>, 0),
  n((3,2), "False", <24>, 0),
  e(<a>, <21>, 1),
  e(<a>, <b>, 0),
  e(<b>, <23>, 1),
    e(<23>, <31>, 1),
    e(<23>, <32>, 0),
  e(<b>, <24>,0),
),  caption: [DT-2 of $A or [ B and C ]$] ),)
])

As we can see, we can choose both $B$ or $C$ as label for the second node of the second level. In fact, when $A = 0$:

- for $B = 0$, the function produces 2 negative outputs,

- for $B = 1$, the function produces 1 positive output and 1 negative output,

- for $C = 0$, the function produces 2 negative output,

- for $C = 1$, the function produces 1 positive output and 1 negative output;
in fact, $B$ and $C$ have the same _Information Gain_ for $A = 0$.

== $A xor B$
$A xor B$ is another simple boolean function: for this reason, logical reasoning is sufficient to compute its decision tree. However, we can use also some tools as _Entropy_ and _Information Gain_.\

The following is the truth table for this particular boolean function:
#figure(simple_table(($bold(A)$, $bold(B)$, $bold(A xor B)$), (
  "0", "0", "0",
  "0", "1", "1", 
  "1", "0", "1", 
  "1", "1", "0", 
)), caption: [$A xor B$ truth table])

Here, we can observe that the behavior of the function is related to $A$ and $B$ in the same way:
- for $A = 0$, the function produces 1 positive output and 1 negative output (entropy = 1),

- for $A = 1$, the function produces 1 positive output and 1 negative output (entropy = 1);
$B$ behaves in the same way,
in fact $A$ and $B$ have the same Information Gain.

Entropy quantifies the uncertainty of a dataset. In the case of $A xor B$, when we fix either $A$ or $B$, the outputs are split evenly between positive and negative, leading to an entropy of 1, which indicates maximum uncertainty.

Information Gain is used to decide the best variable to split the data, aiming to reduce entropy. Since $A "and" B$ provide the same Information Gain for the XOR function, either variable can be chosen as the root without affecting the decision tree's performance.


The computed DTs are the following, both with the same performance:
#grid(columns: 2, column-gutter: 4.5em, [#align(center, figure(diagram(
  n((1, 0), "A", <a>, -1),
  n((0,1), "B", <b1>, -1),
  n((2,1), "B", <b2>, -1),
  n((-0.5,2), "False", <21>, 0),
  n((0.5,2), "True", <22>, 1),
  n((1.5,2), "True", <23>, 1),
  n((2.5,2), "False", <24>, 0),
  e(<a>, <b1>, 1),
  e(<a>, <b2>, 0),
  e(<b1>, <21>, 1),
  e(<b1>, <22>,0),
  e(<b2>, <23>, 1),
  e(<b2>, <24>,0),
),  caption: [DT-1 of $A xor B$]))],
[#align(center, figure(diagram(
  n((1, 0), "B", <a>, -1),
  n((0,1), "A", <b1>, -1),
  n((2,1), "A", <b2>, -1),
  n((-0.5,2), "False", <21>, 0),
  n((0.5,2), "True", <22>, 1),
  n((1.5,2), "True", <23>, 1),
  n((2.5,2), "False", <24>, 0),
  e(<a>, <b1>, 1),
  e(<a>, <b2>, 0),
  e(<b1>, <21>, 1),
  e(<b1>, <22>,0),
  e(<b2>, <23>, 1),
  e(<b2>, <24>,0),
),  caption: [DT-2 of $A xor B$] ))]
)


== $[ A and B] or [C and D]$
$[ A and B] or [C and D]$ is a simple boolean function: for this reason, logical reasoning is sufficient to compute its decision tree.\


The following is the truth table for this boolean function:
#{
  show figure: set block(breakable: true)
  figure(simple_table(($bold(A)$, $bold(B)$, $bold(C)$, $bold(D)$, $bold(A and B)$, $bold(C and D)$, $bold([A and B] or [ C and D ])$), (
  "0", "0", "0", "0", "0", "0", "0",
"0", "0", "0", "1", "0", "0", "0",
"0", "0", "1", "0", "0", "0", "0",
"0", "0", "1", "1", "0", "1", "1",
"0", "1", "0", "0", "0", "0", "0",
"0", "1", "0", "1", "0", "0", "0",
"0", "1", "1", "0", "0", "0", "0",
"0", "1", "1", "1", "0", "1", "1",
"1", "0", "0", "0", "0", "0", "0",
"1", "0", "0", "1", "0", "0", "0",
"1", "0", "1", "0", "0", "0", "0",
"1", "0", "1", "1", "0", "1", "1",
"1", "1", "0", "0", "1", "0", "1",
"1", "1", "0", "1", "1", "0", "1",
"1", "1", "1", "0", "1", "0", "1",
"1", "1", "1", "1", "1", "1", "1"

)), caption: [$[ A and B] or [C and D]$ truth table])
}

First of all we should check $A$:

- if $A = 0$, we can skip $B$ and evaluate $C and D$,

- if $A = 1$, we should check $B$:
  - if $B = 0$, we need to evaluate $C and D$,
  
  - if $B = 1$, we conclude that the function outputs True whatever $C "and" D$ are.

If $B = 0 "or" A = 0$, we need to evaluate $C "and" D$. We can start from C, again:

- if $C = 0$, we can skip $D$ and conclude that the function outputs False whatever $ D$ is,

- if $C = 1$, we need to evaluate $D$:
  - if $D = 0$, we conclude that the function outputs False,
  
  - if $D = 1$, we conclude that the function outputs True.


The computed DT is the following:
#align(center, figure(diagram(
n((0, 0), "A", <a>, -1),
  n((-2,1), "B", <b>, -1),
  n((-3.5,2), "True", <31>, 1),
  n((-1.5,2), "C", <32>, -1),
    n((-0.5,3), "False", <42>, 0),
    n((-2.5,3), "D", <41>, -1),
      n((-3,4), "True", <51>, 1),
      n((-2,4), "False", <52>, 0),
  n((2,1), "C", <c>, -1),
    n((1.5,2), "D", <33>, -1),
      n((1,3), "True", <43>, 1),
      n((2,3), "False", <44>, 0),
  n((3.5,2), "False", <34>, 0),

e(<a>, <b>, 1),
  e(<b>, <31>, 1),
  e(<b>, <32>, 0),
    e(<32>, <41>, 1),
      e(<41>, <51>, 1),
      e(<41>, <52>, 0),
    e(<32>, <42>, 0),
e(<a>, <c>, 0),
  e(<c>, <33>, 1),
    e(<33>, <43>, 1),
    e(<33>, <44>, 0),
  e(<c>, <34>, 0),
),  caption: [DT of $[ A and B] or [C and D]$] ),)