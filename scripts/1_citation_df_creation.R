#### Header ####
## Project: editor_networks
## Script purpose: merging together the bib files into a useable df
## Date: 31/08/18
## Author: Dave Hemprich-Bennett (hemprich.bennett@gmail.com)
## Notes
##################################################

library(here)
library(bibliometrix)
setwd(here())

####Load in the files ####

filenames <- paste('data/raw_data/scopus_bibs/', list.files(path = 'data/raw_data/scopus_bibs/', pattern = 'bib'), sep = '')

file_list <- lapply(filenames, readFiles)
files <- lapply(file_list, function(x) convert2df(x, dbsource = "scopus", format = "bibtex"))

df <- do.call(rbind, files)

write.csv(df, 'data/processed_data/citation_df.csv')
