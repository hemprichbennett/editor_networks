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
library(ggplot2)

setwd(here())

df <- read.csv('data/processed_data/citation_df.csv', row.names = 1, stringsAsFactors = F)


#Convert the dataframe into a network using bibliometrix, and then into an igraph object
auths <-  biblioNetwork(df, analysis = "collaboration", network = "authors", sep = ";")

auth_net <- graph_from_adjacency_matrix(auths, mode = 'undirected')

#A trial, give the nodes a value indicating if they're a Bennett, Caravaggi or Bond

V(auth_net)$dummy <- 'non'

desired_names <- c('BENNETT', 'CARAVAGGI', 'BOND')
V(auth_net)$dummy[grep(paste(desired_names,collapse="|"), V(auth_net)$name)] <- 'badass'

V(auth_net)$dummy <- as.factor(V(auth_net)$dummy)

assortativity_nominal(auth_net, V(auth_net)$dummy, directed=F)
#Low assortivity is detected between our surnames


#how does this vary over time?

dates <- c()
assorts <- c()

for(i in 1:length(unique(df$PY))){
  year <- unique(df$PY)[i]
  
  temp_net <- graph_from_adjacency_matrix(biblioNetwork(df[df$PY == year,], analysis = "collaboration", network = "authors", sep = ";"),  mode = 'undirected')
  
  V(temp_net)$dummy <- 'non'
  
  
  V(temp_net)$dummy[grep(paste(desired_names,collapse="|"), V(temp_net)$name)] <- 'badass'
  
  V(temp_net)$dummy <- as.factor(V(temp_net)$dummy)
  
  score <- assortativity_nominal(temp_net, V(temp_net)$dummy, directed=F)
  
  dates <- c(dates, year)
  assorts <- c(assorts, score)
}

assort_df <- data.frame(dates, assorts)

dummy_plot <- ggplot(assort_df, aes(x = dates, y= assorts))+ 
  xlab('Year')+ ylab('Assortment between Bennetts, Bonds and Caravaggis\nin ecology and conservation publishing')+
  geom_point()+ 
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

jpeg('figures/dummy_plot.jpg', units = 'in', width = 9, height = 9, res=300)
dummy_plot
dev.off()
