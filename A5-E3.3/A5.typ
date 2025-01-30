#set text(font: "New Computer Modern")
#set document(author: "Francesco Furno", title: "Mitchell's Book: Ex. 3.3 DTs")
#set page(numbering: "1/1")
#align(center,
  [
    #line(length: 100%)
    #text(smallcaps("Mitchell's Book: Ex. 3.3 DTs"), 20pt)\
    #v(4pt)
  #text(("Machine Learning 2024-25 Course Activity"), 14pt, style: "italic")\
    #v(1pt)
  #text(("Furno Francesco - francesco.furno@studenti.unipd.it - 2139507 "), 12pt, style: "italic")\
    #v(1pt)
  November 19, 2024
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


*True or false*: If decision tree $D 2$ is an elaboration of tree $D 1$, then $D 1$ is _more-general-than_ $D 2$. Assume $D 1$ and $D 2$ are decision trees representing arbitrary boolean functions, and that $D 2$ is an elaboration of $D 1$ if ID3 could extend $D 1$ into $D 2$. If true, give a proof; if false, a counterexample.

= _More-general-than_ definition
The definition of _more-general-than_ from the book is the following:
\

Given two hypotheses $h_j$ and $h_k$, $h_j$ is _more-general-than-or-equal-to_ $h_k$ if and only if any instance that satisfies $h_k$ also satisfies $h_i$.
\
We can write it as: $ h_j >=#[]_(g) space h_k$ if and only if
$ ((h_k (x) = 1) => (h_j (x) = 1), forall x in X) $

= Examples of $D 1$ & $D 2$
Let $D 1$ be a simple boolean decision tree, based on a single feature $x$. The behavior of the tree is represented by the following function:
$ f_(D 1)(x) = cases(1 space space  &"if" x=1, 0 &"otherwise") $
\

Now, consider $D 2$, an elaboration of $D 1$: $D 2$ is a decision tree based on two features, $x$ and $y$. The behavior of the tree is defined by the following function:
$ f_(D 2)(x, y) = cases(0 space space &"if" x = 0 "and" y = 0, 1 &"otherwise") $
== Truth table
#align(center, table(
  table.header(h_cell("x"), h_cell("y"), h_cell("D1"), h_cell("D2")),
  columns: 4*(7%,),
  [1], [1], [*1*], [*1*],
  [1], [0], [*1*], [*1*],
  [0], [1], [*0*], [*1*],
  [0], [0], [*0*], [*0*],
))
We can observe that:
- $D 1$ makes decisions based on the value of $x$, ignoring $y$.

- $D 2$ is more specific because it considers both $x$ and $y$; for example it splits when $x = 1$ and $y = 0$.

We can say that $D 2$ is an _elaboration_ of $D 1$ because it extends it: in fact $D 2$ has the same feature $x$ that is part of $D 1$, plus an additional feature $y$. Therefore, $D 2$ is a more detailed version of $D 1$ and $forall x in X$ the property $D 1$ _more-general-than_ $D 2$ holds.
= Example of $D 2'$
Now, let's consider $D 2'$, an elaboration of $D 1$: $D 2'$ is a decision tree based again on two features $x$ and $y$. The behavior of the tree is represented by the following function:
$ f_(D 2')(x, y) = cases(1 space space  &"if" x=1 "and" y=1 , 0 &"otherwise") $
In this way, $D 2'$ makes a split when the input $x = 1$ and $y = 1$.
== Truth table
#align(center, table(
  table.header(h_cell("x"), h_cell("y"), h_cell("D1"), h_cell("D2'")),
  columns: 4*(7%,),
  [1], [1], [*1*], [*1*],
  [1], [0], [*1*], [*0*],
  [0], [1], [*0*], [*0*],
  [0], [0], [*0*], [*0*],
))

= True or False?

Now, can we say that $D 1$ is _more-general-than_ $D 2'$? *No*. In fact, we can see that the property of _more-general-than-or-equal-to_ does not hold $forall x in X$. For example, with features $x = 1 "and" y = 0$, $D 1$ returns True, while $D 2'$ returns False; hence, they label the features differently.

This shows that the property _more-general-than_ does not always hold when one decision tree is an elaboration of another.


