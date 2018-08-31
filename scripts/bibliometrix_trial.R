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
D <- readFiles('data/raw_data/scopus_bibs/1944-1995.bib')
M <- convert2df(D, dbsource = "scopus", format = "bibtex")

#Get exploratory results
results <- biblioAnalysis(M, sep = ";")

options(width=100)
S <- summary(object = results, k = 10, pause = FALSE)

#Calculate author dominance rankings
DF <- dominance(results, k = 10)
DF


auths <-  biblioNetwork(M, analysis = "co-occurrences", network = "authors", sep = ";")

# Plot the network
jpeg('figures/example_authors.jpg', units = 'in', width = 9, height = 9, res=300)
net=networkPlot(auths, normalize="association", weighted=T, n = 30, Title = "Author Co-occurrences", type = "circle", size=T,edgesize = 5,labelsize=0.7)
dev.off()




