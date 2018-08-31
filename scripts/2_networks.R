#### Header ####
## Project: editor_networks
## Script purpose: Making networks of all co-occurances of authors in ecology and conservation since 1980
## Date:
## Author: Dave Hemprich-Bennett (hemprich.bennett@gmail.com)
## Notes
##################################################

library(here)
library(bibliometrix)
library(igraph)

setwd(here())

df <- read.csv('data/processed_data/citation_df.csv', row.names = 1, stringsAsFactors = F)


#Convert the dataframe into a network using bibliometrix, and then into an igraph object
auths <-  biblioNetwork(df, analysis = "collaboration", network = "authors", sep = ";")

auth_net <- graph_from_adjacency_matrix(auths, mode = 'undirected')