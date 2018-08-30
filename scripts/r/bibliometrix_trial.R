#### Header ####
## Project: editor_networks
## Script purpose: beginner exploratory analysis of a single dataset, from SCOPUS, on 2,000 recent papers
## Date: 30/08/18
## Author: Dave Hemprich-Bennett (hemprich.bennett@gmail.com)
## Notes: based on tutorial at http://htmlpreview.github.io/?https://github.com/massimoaria/bibliometrix/master/vignettes/bibliometrix-vignette.html
##################################################
library(here)
library(ggplot2)
library(bibliometrix)

setwd(here())

#Load the bib file, convert it to dataframe
D <- readFiles('data/raw_data/scopus.bib')
M <- convert2df(D, dbsource = "scopus", format = "bibtex")

#Get exploratory results
results <- biblioAnalysis(M, sep = ";")

options(width=100)
S <- summary(object = results, k = 10, pause = FALSE)

#Calculate author dominance rankings
DF <- dominance(results, k = 10)
DF

# Create a co-citation network
NetMatrix <- biblioNetwork(M, analysis = "co-citation", network = "references", sep = ".  ")
# Plot the network
net=networkPlot(NetMatrix, n = 30, Title = "Co-Citation Network", type = "fruchterman", size=T, remove.multiple=FALSE, labelsize=0.7,edgesize = 5)


#Keyword co-occurence matrix
NetMatrix <- biblioNetwork(M, analysis = "co-occurrences", network = "keywords", sep = ";")

# Plot the network
net=networkPlot(NetMatrix, normalize="association", weighted=T, n = 30, Title = "Keyword Co-occurrences", type = "fruchterman", size=T,edgesize = 5,labelsize=0.7)
