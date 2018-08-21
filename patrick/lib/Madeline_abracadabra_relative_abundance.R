#set working directory to where the .txt file is (to make .tsv to .txt, open it in Excel and save)
setwd("~/GitHub/abracadabra/patrick/")

#now lets make a relative abundance stacked bar chart
metadata <- read.delim("../data/map/temp_map.txt",
                       header=T,
                       sep='\t',
                       check.names=F,
                       comment='')
#this is the normalized table
otu <- read.table("../data/processed_tax/taxonomy_norm_s.txt",
                  comment="",
                  header=TRUE,
                  sep="\t",
                  as.is=TRUE,
                  check.names=F,
                  row=1)
#this can be changed to what level you want
level = 6

#making an empty table for new names
names_split <- array(dim=c(length(otu$taxonomy),level))
#make a list of current otu names
otu_names <- as.character(otu$taxonomy)

#for loops that splits the names in otu_names, makes all the levels as separate strings
for (i in 1:length(otu_names)){
    names_split[i,] <- head(strsplit(otu_names[i], ";", fixed=T)[[1]], n=level)
}
