
# load libraries
library(igraph)

# define functions for later
checkSign <- function(vec){
  if (any(vec >0, na.rm = TRUE) & any(vec < 0, na.rm = TRUE)){
    return(0)
  }else
    return(1)
}

checkNonZero = function(vec){
  return(which(vec != 0))
}

# read in the data
data <- read_graph("kangaroo_rat_randall.graphml", format = "graphml")

# make a graph using the igraph package
graph <- graph_from_adjacency_matrix(as_adjacency_matrix(data), mode = "undirected")
pal <- c("lightblue", "coral1")

# extract ids to label the vertices
ids <- vertex_attr(data, "id") 
V(graph)$label <- ids  

# get the data as an adjacency matrix
matrix <- as_adjacency_matrix(data)
# create a diagonal degree matrix
D <- diag(ncol(matrix))
diag(D) <- rowSums(matrix)
# calculate the Laplacian matrix
L <- D - matrix
# compute the eigen values and eigen vectors
eigenVal <- eigen(L)$values
# get the non zero eigen values' indeces
indexNonZero <- which(eigenVal!=0)
# extract eigenVectors
eigenVector <- eigen(L)$vectors
# get only eigenvectors with non negative eigen values 
eigenVector <- eigenVector[,indexNonZero]
# get the order of the eigenvalues 
eigenValOrder <- order(eigenVal)
# apply it to the eigen vectors
orderedEigenVectors <- eigenVector[,eigenValOrder]

# check if main cluster
mainCluster <- apply(orderedEigenVectors, FUN = checkSign,  MARGIN = 2)
# get the indeces of the new clusters
indexMainCluster <- which(mainCluster == 1)
# get the number of main clusters (totally separated from others)
numberOfMainClusters <- sum(mainCluster)
# get the EigenVectors of these clusters
mainClusterEigenVec <- orderedEigenVectors[, indexMainCluster]
# add names ids as names of rows for each individual
row.names(mainClusterEigenVec) <- vertex_attr(data, "id")  

# cluster individuals as a list
clusters <- apply(mainClusterEigenVec, FUN = checkNonZero,  MARGIN = 2)

# plot

clustersAutomatic <- cluster_leading_eigen(graph)

pdf("Networks.pdf", width = 13, height = 9)
plot(graph, 
     edge.length = 20, 
     edge.color="black", 
     vertex.size = 20,
     vertex.label.cex = 1,
     vertex.color = pal[as.numeric(as.factor(vertex_attr(data, "SEX")))])
legend("topleft",
       bty = "n",
       legend = c("female", "male"),
       fill = pal,
       border = "black")
title("Mating Strategies of a Nocturnal, Desert Rodent - The Banner-tailed Kangaroo Rat ",
      cex.main = 1,
      col.main = "Black")


dev.off()


pdf("NetworksClusters.pdf", width = 13, height = 9)
plot(clustersAutomatic, 
     graph, 
     edge.length = 20, 
     edge.color="black", 
     vertex.size = 20,
     vertex.label.cex = 1)
title("Spectral Clustering: Mating Strategies of a Nocturnal, Desert Rodent - The Banner-tailed Kangaroo Rat ",
      cex.main = 1,
      col.main = "Black")
dev.off()
