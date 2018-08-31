#### Header ####
## Project: editor_networks
## Script purpose: Making networks of all co-occurances of authors in ecology and conservation since 1980
## Date:
## Author: Dave Hemprich-Bennett (hemprich.bennett@gmail.com)
## Notes
##################################################

library(here)
library(bibliometrix)

setwd(here())

df <- read.csv('data/processed_data/citation_df.csv', row.names = 1, stringsAsFactors = F)


auths <-  biblioNetwork(df, analysis = "co-occurrences", network = "authors", sep = ";")

net=networkPlot(auths, normalize="association", weighted=T, n = 30, Title = "Author Co-occurrences", type = "circle", size=T,edgesize = 5,labelsize=0.7)
