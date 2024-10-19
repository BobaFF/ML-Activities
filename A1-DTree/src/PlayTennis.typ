#set text(font: "New Computer Modern")
#set page(numbering: "1/1")
#align(center,
  [
    #line(length: 100%)
    #text(smallcaps("Play Tennis: Decision Tree - Complete example"), 20pt)\
    #v(4pt)
  #text(("Machine Learning 2024-25 Course Activity"), 14pt, style: "italic")\
    #v(1pt)
  #text(("Furno Francesco - francesco.furno@studenti.unipd.it - 2139507 "), 12pt, style: "italic")\
    #v(1pt)
  November 1st, 2024
  #line(length: 100%)
  
  ]
)
#show outline.entry.where(level: 1): it => {strong(it)}
#outline(title: "Table of contents", indent: 1em)

//#show outline.whe

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
= Abstract
Given the "Play Tennis" dataset provided by the professor during the lecture on October 14th, 2024, Decision Tree - Part I, we aim to build a decision tree using the ID3 algorithm.  During this process, to provide a complete example, we calculated all the possible attributes, even when it was clear which attribute was optimal to choose.
= Dataset
The dataset provided is the following:
#let data = csv("data.csv")
#align(center,
  table(align: center, columns: 6,
  ..data.flatten()
  )
)

Let's start calculating the *Entropy of PlayTennis*. Over 14 days:
- 9 "Yes" $-> P("Yes") = 9/14 $

- 5 "No" $-> P("No") = 5/14 $

$ E("PlayTennis") &= - (log(9/14) times 9/14 + log(5/14) times 5/14 ) \ & approx −(0.643 times (−0.644)+0.357 times (−1.485)) \ &approx 0.414+0.530 \ & approx 0.940 $

Remember that the ID3 algorithm uses the concepts of *Entropy* and *Information Gain*: for each possible node of the tree, we are looking for the attribute wich maximizes the Information Gain.

= Root node
"Let's begin by calculating the Information Gain for all possible attributes at the root node. //The set $S$, at the moment, includes all the values of the dataset. 

*Outlook:*\
There are 3 possible values for the Outlook attribute: "Sunny", "Overcast" and "Rain".

Let's start with the "Sunny" value. There are 5 occurrences of it:

#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D1", "No",
  "D2", "No",
  "D8", "No",
  "D9", "Yes",
  "D11", "Yes",
))

In total:
- 2 occurrences of $"PlayTennis"_"Y" space => 2/5 $

- 3 occurrences of $"PlayTennis"_"N" space => 3/5$


Then:
 
$ E("Outlook"_S) &= - (log(2/5) times 2/5 + log(3/5) times 3/5 ) \ & approx 0.970 $

Let's analyze the "Overcast" value. There are 4 occurrences of it:
#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D3", "Yes",
  "D7", "Yes",
  "D12", "Yes",
  "D13", "Yes",
))
In total:
- 4 occurrences of $"PlayTennis"_"Y" space => 4/4 = 1$

- 0 occurrences of $"PlayTennis"_"N" space => 0$

Then:
 
$ E("Outlook"_O) &= 0 $
This particular Entropy is easy to calculate because the values are not distributed.

Let's analyze the "Rain" value. There are 5 occurrences of it:
#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D4", "Yes",
  "D5", "Yes",
  "D6", "No",
  "D10", "Yes",
  "D14", "No",
))

In total:
- 3 occurrences of $"PlayTennis"_"Y" space => 3/5 $

- 2 occurrences of $"PlayTennis"_"N" space => 2/5$


Then:
 
$ E("Outlook"_R) &= - (log(3/5) times 3/5 + log(2/5) times 2/5) \ & approx 0.970 $
\
So the *Information Gain* from the "Outlook" attribute is: 
$ G("S", "Outlook") &=  0.940 - ( 5/14 times 0.97  + 4/14 times 0 + 5/14 times 0.97 ) \ & approx 0.248 $
\
*Temperature:*\
There are 3 possible values for the Temperature attribute: "Hot", "Mild" and "Cool".

Let's start with the "Hot" value. There are 4 occurrences of it:
#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D1", "No",
  "D2", "No",
  "D3", "Yes",
  "D13", "Yes",
))

In total:
- 2 occurrences of $"PlayTennis"_"Y" space => 2/4 = 1/2$

- 2 occurrences of $"PlayTennis"_"N" space => 2/4 = 1/2$

$ E("Temperature"_H) &= - (log(1/2) times 1/2 + log(1/2) times 1/2 ) \ & approx 1 $
This particular Entropy is easy to calculate because the values are perfectly distributed.

Let's analyze the "Mild" value. There are 6 occurrences of it:
#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D4", "Yes",
  "D8", "No",
  "D10", "Yes",
  "D11", "Yes",
  "D12", "Yes",
  "D14", "No",
))

In total:
- 4 occurrences of $"PlayTennis"_"Y" space => 4/6 = 2/3$

- 2 occurrences of $"PlayTennis"_"N" space => 2/6 = 1/3$

$ E("Temperature"_M) &= - (log(2/3) times 2/3 + log(1/3) times 1/3 ) \ & approx 0.918 $

Let's analyze the "Cool" value. There are 4 occurrences of it:
#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D5", "Yes",
  "D6", "No",
  "D7", "Yes",
  "D9", "Yes",
))

In total:
- 3 occurrences of $"PlayTennis"_"Y" space => 3/4 = 3/4$

- 1 occurrence of $"PlayTennis"_"N" space => 1/4 = 1/4$

$ E("Temperature"_C) &= - (log(3/4) times 3/4 + log(1/4) times 1/4 ) \ & approx 0.811 $

\
So the *Information Gain* from the "Temperature" attribute is: 
$ G("S", "Temperature") &=  0.940 - ( 4/14 times 1 + 6/14 times 0.918 + 4/14 times 0.811 ) \ & = 0.030 $

\
*Humidity:*\
There are 2 possible values for the Humidity attribute: "High" and "Normal".

Let's start with the "High" value. There are 7 occurrences of it:

#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D1", "No",
  "D2", "No",
  "D3", "Yes",
  "D4", "Yes",
  "D8", "No",
  "D12", "Yes",
  "D14", "No"
))

In total:
- 3 occurrences of $"PlayTennis"_"Y" space => 3/7$

- 4 occurrences of $"PlayTennis"_"N" space => 4/7$


Then:
 
$ E("Humidity"_H) &= - (log(3/7) times 3/7 + log(4/7) times 4/7 ) \ & approx 0.985 $

Let's analyze the "Normal" value. There are 7 occurrences of it:
#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D5", "Yes",
  "D6", "No",
  "D7", "Yes",
  "D9", "Yes",
  "D10", "Yes",
  "D11", "Yes",
  "D13", "Yes"
))
In total:
- 6 occurrences of $"PlayTennis"_"Y" space => 6/7$

- 1 occurrence of $"PlayTennis"_"N" space => 1/7$

Then:
 
$ E("Humidity"_N) &= - (log(6/7) times 6/7 + log(1/7) times 1/7 ) \ & approx 0.591 $ 
\
So the *Information Gain* from the "Humidity" attribute is: 
$ G("S", "Humidity") &=  0.940 - ( 7/14 times 0.985 + 7/14 times 0.591 ) \ & = 0.152 $


*Wind:*\
There are 2 possible values for the Wind attribute: "Weak" and "Strong"

Let's start with the "Weak" value. There are 8 occurrences of it:

#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D1", "No",
  "D3", "Yes",
  "D4", "Yes",
  "D5", "Yes",
  "D8", "No",
  "D9", "Yes",
  "D10", "Yes",
  "D13", "Yes",
))

In total:
- 6 occurrences of $"PlayTennis"_"Y" space => 6/8 = 3/4$

- 2 occurrences of $"PlayTennis"_"N" space => 2/8 = 1/4$


Then:
 
$ E("Wind"_W) &= - (log(3/4) times 3/4 + log(1/4) times 1/4 ) \ & approx 0.811 $

Let's analyze the "Strong" value. There are 6 occurrences of it:
#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D2", "No",
  "D6", "No",
  "D7", "Yes",
  "D11", "Yes",
  "D12", "Yes",
  "D14", "No",
))
In total:
- 3 occurrences of $"PlayTennis"_"Y" space => 3/6 = 1/2$

- 3 occurrences of $"PlayTennis"_"N" space => 3/6 = 1/2$

Then:
 
$ E("Wind"_S) &= - (log(1/2) times 1/2 + log(1/2) times 1/2 ) \ & = 1 $ 
So the Information Gain from the attribute "Wind" is: 
$ G("S", "Wind") &=  0.940 - ( 8/14 times 0.811 + 6/14 times 1 ) \ & = 0.048 $

*Conclusion*:\
Let's summarize all the I.G. for all the possible attributes of the root node:
#align(center, table(
  table.header([*Attribute*], [*Information Gain*]),
  columns: (22%, 22%),
  "Outlook", "0.248",
  "Temperature", "0.030",
  "Humidity", "0.152",
  "Wind", "0.048",
))

The root node of the Decision Tree should have the "Outlook" attribute, which is the optimal attribute. The $S$ set is partitioned according to the values that Outlook can take: 
- $N_S$ is the sub-tree where $S_("Outlook = Sunny")$

- $N_O$ is the sub-tree where $S_("Outlook = Overcast")$
- $N_R$ is the sub-tree where $S_("Outlook = Rain")$
#align(center, image("img/1.PNG"))


= $N_S$ - Node "Sunny"
$N_S$ is the sub-tree where $S_("Outlook = Sunny")$.\

We have already calculated the Entropy:  $E("Outlook"_S) &=  0.970$.
\

*Temperature:*\
There are 3 possible values for the Temperature attribute: "Hot", "Mild" and "Cool".

Let's start with the "Hot" value. There are 2 occurrences of it:
#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D1", "No",
  "D2", "No"
))

In total:
- 0 occurrences of $"PlayTennis"_"Y" space =>0$

- 2 occurrences of $"PlayTennis"_"N" space => 2/2 = 1$

$ E("Temperature"_(N_S - H)) &= 0 $

Let's analyze the "Mild" value. There are 2 occurrences of it:
#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D8", "No",
  "D11", "Yes",
))

In total:
- 1 occurrence of $"PlayTennis"_"Y" space => 1/2$

- 1 occurrence of $"PlayTennis"_"N" space => 1/2$

$ E("Temperature"_(N_S - M)) &=  0.5 $

Let's analyze the "Cool" value. There is 1 occurrence of it:
#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D9", "Yes",
))

In total:
- 1 occurrence of $"PlayTennis"_"Y" space => 1$

- 0 occurrences of $"PlayTennis"_"N" space => 0$

$ E("Temperature"_(N_S - C)) &= 0 $

\
So the *Information Gain* from the "Temperature" attribute is: 
$ G(S_(O = S), "Temperature") &=  0.970 - ( 2/5 times 0 + 2/5 times 0.5 + 1/5 times 0 ) \ & = 0.770 $

*Humidity:*\
There are 2 possible values for the Humidity attribute: "High", "Normal".

Let's start with the "High" value. There are 3 occurrences of it:

#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D1", "No",
  "D2", "No",
  "D8", "No",
))

In total:
- 0 occurrences of $"PlayTennis"_"Y" space => 0$

- 3 occurrences of $"PlayTennis"_"N" space => 1$


Then:
 
$ E("Humidity"_(N_S - H)) &= 0 $

Let's analyze the "Normal" value. There are 2 occurrences of it:
#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D9", "Yes",
  "D11", "Yes",
))
In total:
- 2 occurrences of $"PlayTennis"_"Y" space => 1$

- 0 occurrences of $"PlayTennis"_"N" space => 0$

Then:
 
$ E("Humidity"_(N_S - N)) &= 0 $ 
\
So the *Information Gain* from the "Humidity" attribute is: 
$ G("S"_(O = S), "Humidity") &=  0.970 - ( 3/5 times 0 + 2/5 times 0 ) \ & = 0.970 $



*Wind:*\
There are 2 possible values for the attribute Wind: "Weak" and "Strong".

Let's start with the "Weak" value. There are 3 occurrences of it:

#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D1", "No",
  "D8", "No",
  "D9", "Yes",
))

In total:
- 1 occurrence of $"PlayTennis"_"Y" space => 1/3$

- 2 occurrences of $"PlayTennis"_"N" space => 2/3$


Then:
 
$ E("Wind"_(N_S - W)) &= - (log(1/3) times 1/3 + log(2/3) times 2/3 ) \ & approx 0.918 $

Let's analyze the "Strong" value. There are 2 occurrences of it:
#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D2", "No",
  "D11", "Yes",
))
In total:
- 1 occurrence of $"PlayTennis"_"Y" space => 1/2$

- 1 occurrence of $"PlayTennis"_"N" space => 1/2$

Then:
 
$ E("Wind"_(N_S - S)) &= 1 $ 
\
So the *Information Gain* from the attribute "Wind" is: 
$ G(S_(O = S), "Wind") &=  0.970 - ( 3/5 times 0.918 + 2/5 times 1 ) \ & = 0.019 $

*Conclusion*:\
Let's summarize all the I.G. for all the possible attributes of the Node $N_S$:
#align(center, table(
  table.header([*Attribute*], [*Information Gain*]),
  columns: (22%, 22%),
  "Temperature", "0.770",
  "Humidity", "0.970",
  "Wind", "0.019",
))

The node $N_S$ should have attribute "Humidity", which is the optimal attribute. The $S_(O = S)$ set is partitioned according to the values that Humidity can take: 
- $N_(S H) $ is the sub-tree where $S_("Outlook = Sunny" and "Humidity = High")$

- $N_(S N) $ is the sub-tree where $S_("Outlook = Sunny" and "Humidity = Normal")$

#align(center, image("img/2.PNG"))
== $N_(S H)$ - Node "Sunny - High"
$N_(S H) $ is the sub-tree where $S_("Outlook = Sunny" and "Humidity = High")$.\
We have already calculated the Entropy:  $E("Outlook"_(S H)) &=  0$.
$S_(O = S and H = H)$ is pure: all the occurrences in this set belong to the class $"PlayTennis" = "No"$. The node $N_(S H)$ is a leaf with the class *No* .

== $N_(S N)$ - Node "Sunny - Normal"
$N_(S N) $ is the sub-tree where $S_("Outlook = Sunny" and "Humidity = Normal")$.\
We have already calculated the Entropy:  $E("Outlook"_(S N)) &=  0$.
$S_(O = S and H = N)$ is pure: all the occurrences in this set belong to the class $"PlayTennis" = "Yes"$. The node $N_(S N)$ is a leaf with the class *Yes* .
#align(center, image("img/3.PNG"))


= $N_O$ - Node "Overcast"
$N_O$ is the sub-tree where $S_("Outlook = Overcast")$.\
We have already calculated the Entropy:  $E("Outlook"_(O)) &=  0$.
$S_(O = O)$ is pure: all the occurrences in this set belong to the class $"PlayTennis" = "Yes"$. The node $N_(S H)$ is a leaf with the class *Yes* .
#align(center, image("img/4.PNG"))

= $N_R$ - Node "Rain"
$N_R$ is the sub-tree where $S_("Outlook = Rain")$.\
We have already calculated the Entropy:  $E("Outlook"_(R)) &=  0.970$.

*Temperature:*\
There are 3 possible values for the Temperature attribute: "Hot", "Mild" and "Cool".

Let's start with the "Hot" value. There are no occurrences for it:

$ E("Temperature"_H) &= emptyset $

Let's analyze the "Mild" value. There are 3 occurrences of it:
#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D4", "Yes",
  "D10", "Yes",
  "D14", "No",
))

In total:
- 2 occurrences of $"PlayTennis"_"Y" space =>  2/3$

- 1 occurrence of $"PlayTennis"_"N" space => 1/3$

$ E("Temperature"_M) &= - (log(2/3) times 2/3 + log(1/3) times 1/3 ) \ & approx 0.918 $

Let's analyze the "Cool" value. There are 2 occurrences of it:
#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D5", "Yes",
  "D6", "No",
))

In total:
- 1 occurrence of $"PlayTennis"_"Y" space => 1/2$

- 1 occurrence of $"PlayTennis"_"N" space => 1/2$

$ E("Temperature"_C) &= 0.5 $
\

So the *Information Gain* from the attribute "Temperature" is: 
$ G(S_(O = "R"), "Temperature") &=  0.970 - (3/5 times 0.918 + 2/5 times 0.5 ) \ & = 0.219 $


*Humidity:*\
There are 2 possible values for the Humidity attribute: "High" and "Normal".

Let's start with the "High" value. There are 2 occurrences of it:

#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D4", "Yes",
  "D14", "No"
))

In total:
- 1 occurrence of $"PlayTennis"_"Y" space => 1/2$

- 1 occurrence of $"PlayTennis"_"N" space => 1/2$


Then:
 
$ E("Humidity"_(N_R - H)) &= 0.5 $

Let's analyze the "Normal" value. There are 3 occurrences of it:
#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D5", "Yes",
  "D6", "No",
  "D10", "Yes",
))
In total:
- 2 occurrences of $"PlayTennis"_"Y" space => 2/3$

- 1 occurrence of $"PlayTennis"_"N" space => 1/3$

Then:
 
$ E("Humidity"_(N_R - N)) &= - (log(2/3) times 2/3 + log(1/3) times 1/3 ) \ & approx 0.918 $ 
\
So the *Information Gain* from the "Humidity" attribute is: 
$ G("S"_(O = R), "Humidity") &=  0.970 - ( 2/5 times 0.5 + 3/5 times 0.918 ) \ & = 0.219 $


*Wind:*\
There are 2 possible values for the attribute Wind: "Weak" and "Strong".

Let's start with the "Weak" value. There are 3 occurrences of it:

#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D4", "Yes",
  "D5", "Yes",
  "D10", "Yes"
))

In total:
- 3 occurrences of $"PlayTennis"_"Y" space => 1$

- 0 occurrences of $"PlayTennis"_"N" space => 0$


Then:
 
$ E("Wind"_(N_(R) - W)) &= 0 $

Let's analyze "Strong" value. There is 2 occurrence of the value "Strong":
#align(center, table(
  table.header([*Day*], [*PlayTennis*]),
  columns: (20%, 20%),
  "D6", "No",
  "D14", "No"
))
In total:
- 0 occurrence of $"PlayTennis"_"Y" space => 0$

- 2 occurrences of $"PlayTennis"_"N" space => 1$

Then:
 
$ E("Wind"_(N_(R) - S)) &= 0 $ 

\
So the *Information Gain* from the attribute "Wind" is: 
$ G(S_(O = "R"), "Wind") &=  0.970 - ( 3/5 times 0 + 2/5 times 0 ) \ & = 0.970 $

*Conclusion*:\
Let's summarize all the I.G. for all the possible attributes of the Node $N_R$:
#align(center, table(
  table.header([*Attribute*], [*Information Gain*]),
  columns: (22%, 22%),
  "Temperature", "0.219",
  "Humidity", "0.219",
  "Wind", "0.970",
))

The node $N_R$ should have attribute "Wind", which is the optimal attribute. The $S_(O = R)$ set is partitioned according to the values that Humidity can take: 
- $N_(R W) $ is the sub-tree where $S_("Outlook = Rain" and "Wind = Weak")$

- $N_(R S) $ is the sub-tree where $S_("Outlook = Rain" and "Wind = Strong")$

#align(center, image("img/5.PNG"))
== $N_(R W)$ - Node "Rain - Weak"
$N_(R W) $ is the sub-tree where $S_("Outlook = Rain" and "Wind = Weak")$\
We have already calculated the Entropy:  $E("Wind"_(R W)) &=  0$.
$S_(O = R and W = W)$ is pure: all the occurrences in this set belong to the class $"PlayTennis" = "Yes"$. The node $N_(R W)$ is a leaf with the class *Yes* 

== $N_(R S)$ - Node "Rain - Strong"
$N_(R S) $ is the sub-tree where $S_("Outlook = Rain" and "Wind = Strong")$\
We have already calculated the Entropy:  $E("Wind"_(R S)) &=  0$.
$S_(O = R and W = S)$ is pure: all the occurrences in this set belong to the class $"PlayTennis" = "No"$. The node $N_(R S)$ is a leaf with the class *No* 

= Complete Decision Tree
#align(center, image("img/6.PNG"))
