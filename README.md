# Spectral Clustering of the Kangaroo Rat (Dipodomys Spectabilis) Mating Networks Using Eigenvectors

<p align="center">
  <img src="Kangaroo-rat.jpg" width="350" height="250"/>
   <br>
  <em><small>Source: The Kangaroo Rat (Dipodomys spectabilis) https://en.wikipedia.org/wiki/Kangaroo_rat#/media/File:Kangaroo-rat.jpg</small></em>
</p>


This repository contains a short script that uses simple linear algebra for spectral clustering of mating networks of the Kangaroo Rat. The script can be used for education purposes to perform spectral clustering of networks using eigenvectors step by step. 

The data used and contained in this repository was collected by Jan A. Randall as part of his study that can be found [here](https://link.springer.com/article/10.1007/BF00172173). 
> The mating system of a nocturnal, desert rodent, the banner-tailed kangaroo rat (Dipodomys spectabilis) was studied through direct observation, live-trapping, and radiotelemetry over a 13-month period from August 1986 to August 1987. Mating behavior varied from exclusive matings between male and female neighbors to competitive mate searching and direct male competition. In summer matings and early in a November to May breeding season, males located receptive females and mated exclusively with them without disturbance from other males. As the operational sex ratio changed in favor of males, multiple males converged on an estrous female's territory and competed for access to her. However, an older, experienced male usually monopolized the matings of the same one to two close female neighbors for the entire breeding period, and females mated with the same male neighbor over several estrous cycles. Monopolization of females by neighbor males was facilitated by female relaxation of individual territorial defense. Dominant males spent considerable time in the territories of the females they monopolized before and during mating. This relaxation in territorial defense was seen in dyadic encounters in which females tolerated all males but allowed significantly more contact by neighbor than stranger males. Neighbor recognition, therefore, seems important in coordinating the mating interactions of this solitary rodent.

I downloaded the data from [The Animal Social Structure Network Repository](https://github.com/bansallab/asnr)

### More Details

I use the `igraph` R package to read in the data and visualize it. In the graph attached below we can see that there are 6 main clusters which are separate. 

<p align="center">
  <img src="Networks.png", height = "450", weight = "500"/>
   <br>
  <em><small>The Network</small></em>
</p>



  
The goal of this script is to use simple linear alegbra and find the clusters. If you follow the code you will see that the main clusters can be discovered by checking the eigenvectors with the smallest non-zero eigen values. The clusters can be extracted by checking the sign of the values in those vectors. The final clusters can be found as a list in the `clusters` variable. 

Additionally I use the `igraph::cluster_leading_eigen()` to check if my computations were correct. I can then plot the clusters.

<p align="center">
  <img src="NetworksClusters.png", height = 450, weight = "500"/>
   <br>
  <em><small>The Clustered Netwrok</small></em>
</p>


