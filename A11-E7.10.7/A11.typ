#set text(font: "New Computer Modern")
#set document(author: "Francesco Furno", title: "Alpaydin's Book: Ex. 7.10.7 Clustering")
#set page(numbering: "1/1")
#align(center,
  [
    #line(length: 100%)
    #text(smallcaps("Alpaydin's Book: Ex. 7.10.7 Clustering"), 20pt)\
    #v(4pt)
  #text(("Machine Learning 2024-25 Course Activity"), 14pt, style: "italic")\
    #v(1pt)
  #text(("Furno Francesco - francesco.furno@studenti.unipd.it - 2139507 "), 12pt, style: "italic")\
    #v(1pt)
  December 10, 2024
  #line(length: 100%)
  
  ]
)
= What are the similarities and diﬀerences between average-link clustering and k-means?
_Average-link clustering_, an hierarchical clustering method, and _k-means_, a partitional clustering method, are two techniques used in Unsupervised Learning to cluster data.

== #underline[Similarities]

=== Unsupervised Learning Methods
_Average-link clustering_ and _k-means_ are both Unsupervised Learning methods: they do not need labeled or classified data to perform clustering.

=== Clustering 
Both _Average-link clustering_ and _k-means_ aim to group similar instances in the same cluster. An element of a cluster should have similar features to the elements of the same group and different features to the elements of the others group.
=== The use of distance
These two clustering methods use distance metrics to evaluate similarities and differences of data points and clusters. _Average-link clustering_ measures the mean similarity between pairs of examples across clusters; _K-means_ minimizes the average distance between examples and the _centroids_, the "center" of the cluster.

== #underline[Differences]

=== Type of Clustering
_Average-link clustering_ is an hierarchical clustering algorithm. Hierarchical clustering uses two approaches:
- Agglomerative: at the beginning each instance is considered as a single cluster; then similar instances are merged in bigger clusters. The _Average-link clustering_ algorithm uses this particular approach.

- Divisive: at the beginning all the instances are considered as one big cluster; then data is split into smaller clusters.

_K-means_, on the other hand, belongs to the family of partitional clustering algorithm, which divide the dataset into random partitions initially. The algorithm aims to minimize an objective function and iteratively adjusts partitions to optimize the clustering result.

=== Number of clusters
In the _Average-link clustering_ algorithm, the number of clusters is not pre-specified. It generates a _dendrogram_, a tree diagram, where the number of clusters can be easily determined on a specifical level of cut of the tree.

To use _k-means_ the number of clusters must be specified beforehand: this algorithm, in fact, finds a $k$ clusters partition
that optimizes a certain criterion  given a
set of instances and a $k$ number.

=== Initialization & sensibility
The _Average-link clustering_ does not require any initialization: it works directly on data, considering the full hierarchy during clustering,and it is very less sensitive to initialization issues.

The _k-means_ algorithm requires the initialization of _k centroids_, which is usually done with random values. Different initializations can lead to different clustering results due to the algorithm's sensitivity to the starting positions of the centroids.

=== Output
The _Average-link clustering_ algorithm generates a tree-like structure, a _dendrogram_, which shows nested clusters at various levels.

The _k-means_ algorithm produces a flat partition of the dataset into _k_ clusters.


=== Clusters shape
_Average-link clustering_ can detect clusters of various shapes because it considers the relationships between all data points during the clustering process.

K-means assumes that clusters are spherical and equally sized: for this reason it is less effective for datasets with irregularly shaped clusters.

=== Computational cost
The _Average-link clustering_ algorithm is computationally more expensive than _k-means _because it requires iterative calculations of distances between all points during the merging process. This makes it less suitable for large datasets.

_K-means_, on the other hand, is designed to be more efficient as it works with a fixed number of clusters and updates the positions of centroids at each iteration. This efficiency makes it preferable for larger datasets, but it may require more iterations to converge an optimal solution.

=== When to use them
The _Average-link clustering_ algorithm should be used when the hierarchy is important or when the shape or the number of clusters is unknown. Due to its high computational costs, it is suitable for small datasets.

The _k-means_  is suitable when the number of clusters is known or can be estimated. It is the right choice if clusters have a spherical shape and the dataset has low noise.