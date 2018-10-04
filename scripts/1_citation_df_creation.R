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

filenames <- paste('data/raw_data/wos/', list.files(path = 'data/raw_data/wos/', pattern = 'bib'), sep = '')

file_list <- lapply(filenames, readFiles)
files <- lapply(file_list, function(x) convert2df(x, dbsource = "isi", format = "bibtex"))


#Make a vector of all the column names, then a vector of all the column names which are found in every file (there are a few files with redundant
#columns that don't appear elsewhere, killing the rbind)
all_colnames <- unlist(sapply(files, function(x) colnames(x)))
goodcols <- c()
for(i in 1:length(unique(all_colnames))){
  nam <- unique(all_colnames)[i]
  if(length(which(all_colnames == nam)) == length(files)){
    goodcols <- c(goodcols, nam)
  }
}

#now discard any unwanted columns
for(i in 1:length(files)){
  files[[i]] <- files[[i]][,which(colnames(files[[i]]) %in% goodcols)]
}

df <- do.call(rbind, files)

write.csv(df, 'data/processed_data/citation_df.csv')

