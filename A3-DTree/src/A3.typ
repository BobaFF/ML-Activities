#set text(font: "New Computer Modern")
#set document(author: "Francesco Furno", title: "Mitchell's Book: Ex. 3.2 DTs")
#set page(numbering: "1/1")
#align(center,
  [
    #line(length: 100%)
    #text(smallcaps("Mitchell's Book: Ex. 3.2 DTs"), 20pt)\
    #v(4pt)
  #text(("Machine Learning 2024-25 Course Activity"), 14pt, style: "italic")\
    #v(1pt)
  #text(("Furno Francesco - francesco.furno@studenti.unipd.it - 2139507 "), 12pt, style: "italic")\
    #v(1pt)
  November 4st, 2024
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


Consider the following set of training examples:
#align(center,
  table(
    table.header([*Instance*], [*Classification*], [$bold(a_1)$], [$bold(a_2)$]),
  columns: (15%, 20%, 10%, 10%),
  "1", "+", "T", "T",
  "2", "+", "T", "T",
  "3", "-", "T", "F",
  "4", "+", "F", "F",
  "5", "-", "F", "T",
  "6", "-", "F", "T"
  )
)
+ What is the entropy of this collection of training examples with respect to the target function classification?

+ What is the information gain of $a_2$ relative to these training examples?

= Entropy
In this collection, there are 6 instances:
- 3 positive elements $=> P_+ = 3/6 = 1/2 $

- 3 negative elements $=> P_- = 3/6 = 1/2 $

The entropy with respect to the classification value is:
$ E("S") = & - (log_2(P_+)_ times P_+ + log_2(P_-) times P_- ) \ = & -(log_2(1/2) times 1/2 + log_2(1/2) times 1/2) \ = & -(-1 times 1/2 - 1 times 1/2) \ = & -(-2/2) = 1 $

We could have concluded that the entropy is 1 without calculation because the instances are perfectly balanced: there are an equal number of positive and negative elements. When the elements are perfectly distributed between the classes, the entropy function reaches its maximum value, indicating maximum uncertainty:
#align(center, figure(image("img/entropy.png", width: 40%), caption: "Entropy function"))

= Information Gain of $a_2$
To find the Information Gain of $a_2$ we need to calculate the entropy for each possible value of this attribute.
$a_2$ has two possible values: *T* and *F*.

Let's start with $bold(upright(T))$. There are 4 instances where $a_2 = bold(upright(T))$. 
#align(center,
  table(
    table.header([*Instance*], [*Classification*], [$bold(a_1)$], [$bold(a_2)$]),
  columns: (15%, 20%, 10%, 10%),
  "1", "+", "T", "T",
  "2", "+", "T", "T",
  "5", "-", "F", "T",
  "6", "-", "F", "T"
  )
)
In total:
- 2 positive elements $=> P_+ = 2/4 = 1/2$

- 2 negative elements $=> P_- = 2/4 = 1/2$

$ E(a_(2 - bold(upright(T)))) & = -(log_2(1/2) times 1/2 + log_2(1/2) times 1/2) \ & = 1 $

This is because the instances are perfectly balanced between the classifications.

\

Let's analyze *F*. There are 2 instances where $a_2 = bold(upright(F))$. 
#align(center,
  table(
    table.header([*Instance*], [*Classification*], [$bold(a_1)$], [$bold(a_2)$]),
  columns: (15%, 20%, 10%, 10%),
  "3", "-", "T", "F",
  "4", "+", "F", "F",
  )
)
In total:
- 1 positive element $=> P_+ =  1/2$

- 1 negative element1 $=> P_- = 1/2$

$ E(a_(2 - bold(upright(F)))) & = -(log_2(1/2) times 1/2 + log_2(1/2) times 1/2) \ & = 1 $

Again, the instances are perfectly balanced between the classifications.


\

*Information Gain*\
$ G(S, a_2) & = E(S) - (4/6 times E(a_(2 - bold(upright(T)))) + 2/6 times E(a_(2 - bold(upright(F))))) \ & = 1 -(4/6 times 1 + 2/6 times 1) \ & = 1 - (1) \ & = 0 $

The Information Gain of $a_2$ is 0 because, for both possible values (*T* and *F*), the instances are perfectly balanced in the classification *+* and *-*. This means that $a_2$ does not provide any additional information to reduce the uncertainty of the classification.