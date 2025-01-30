#set text(font: "New Computer Modern")
#set document(author: "Francesco Furno", title: "Mitchell's Book: Ex. 4.3 DTs")
#set page(numbering: "1/1")
#align(center,
  [
    #line(length: 100%)
    #text(smallcaps("Mitchell's Book: Ex. 4.3 NN"), 20pt)\
    #v(4pt)
  #text(("Machine Learning 2024-25 Course Activity"), 14pt, style: "italic")\
    #v(1pt)
  #text(("Furno Francesco - francesco.furno@studenti.unipd.it - 2139507 "), 12pt, style: "italic")\
    #v(1pt)
  November 25, 2024
  #line(length: 100%)
  
  ]
)
#show outline.entry.where(level: 1): it => {strong(it)}
//#outline(title: "Table of contents", indent: 1em)


#let tab-colors = (
  pari: white,
  dispari: luma(215),
  head: black.lighten(20%)
)
#let h_cell(t) = (table.cell(fill: tab-colors.head, text(fill: white,  weight: "bold", t)))
#show table.cell.where(y: 0): set text(weight: "bold", fill: white)
#set table(fill: (_, row) => 
      if row == 0 {
        tab-colors.head
      }
      else if calc.odd(row) {
        tab-colors.dispari
      } else {tab-colors.pari},
)


Consider two perceptrons defined by the threshold expression $ w_0 + w_1 x_1 + w_2 x_2 > 0$.
Perceptron A has weight values
$  w_0 = 1, space w_1 = 2, space w_2 = 1 $
and perceptron B has the weight values
$  w_0 = 0, space w_1 = 2, space w_2 = 1 $

*True or false?* Perceptron A is _more-general-than_ perceptron B.

= _More-general-than_ definition
The definition of _more-general-than_ from the book is the following:
\

Given two hypotheses $h_j$ and $h_k$, $h_j$ is _more-general-than-or-equal-to_ $h_k$ if and only if any instance that satisfies $h_k$ also satisfies $h_j$.
\

We can write it as: $ h_j >=#[]_(g) space h_k$ if and only if
$ ((h_k (x) = 1) => (h_j (x) = 1), forall x in X) $

= Input examples
Let's consider all the possible inputs for perceptrons A and B. If we find an input where B outputs 1 and A outputs 0 we can say that A is not _more-general-than_ B.

== 1. $bold(x_1 = 1"," x_2 = 1)$
*Perceptron A:*\
The treeshold expression is the following:
$ w_0 + w_1 dot 1 + w_2 dot 1 =   1 + 2 dot 1 + 1 dot 1 & = 4 $
hence the step function is activated.

*Perceptron B:*\
The treeshold expression is the following:
$ w_0 + w_1 dot 1 + w_2 dot 1 =   0 + 2 dot 1 + 1 dot 1 & = 3 $
hence the step function is activated.

Until now, we can say that Perceptron A is _more-general-than_ Perceptron B.

== 2. $bold(x_1 = 1"," x_2 = 0)$
*Perceptron A:*\
The treeshold expression is the following:
$ w_0 + w_1 dot 1 + w_2 dot 0 =   1 + 2 dot 1 + 1 dot 0 & = 3 $
hence the step function is activated.

*Perceptron B:*\
The treeshold expression is the following:
$ w_0 + w_1 dot 1 + w_2 dot 0 =   0 + 2 dot 1 + 1 dot 0 & = 2 $
hence the step function is activated.

Until now, we can say that Perceptron A is _more-general-than_ Perceptron B.

== 3. $bold(x_1 = 0"," x_2 = 1)$
*Perceptron A:*\
The treeshold expression is the following:
$ w_0 + w_1 dot 0 + w_2 dot 1 =   1 + 2 dot 0 + 1 dot 1 & = 2 $
hence the step function is activated.

*Perceptron B:*\
The treeshold expression is the following:
$ w_0 + w_1 dot 0 + w_2 dot 1 =   0 + 2 dot 0 + 1 dot 1 & = 1 $
hence the step function is activated.

Until now, we can say that Perceptron A is _more-general-than_ Perceptron B.

== 4. $bold(x_1 = 0"," x_2 = 0)$
*Perceptron A:*\
The treeshold expression is the following:
$ w_0 + w_1 dot 0 + w_2 dot 0 =   1 + 2 dot 0 + 1 dot 0 & = 1 $
hence the step function is activated.

*Perceptron B:*\
The treeshold expression is the following:
$ w_0 + w_1 dot 0 + w_2 dot 0 =   0 + 2 dot 0 + 1 dot 0 & = 0 $
hence the step function is *not activated*.

= Conclusion: True
We can say that Perceptron A is _more-general-than_ Perceptron B, because for all the inputs where B outputs 1 $=>$ A outputs 1. 

We cannot say the opposite, in fact Perceptron B is _more-general-than_ A is *False* because there is one case where A outputs 1 $arrow.r.double.not$ B outputs 1.

