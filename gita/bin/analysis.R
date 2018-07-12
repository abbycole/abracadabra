
setwd("/Users/Gita Raman/Desktop/MAGIC/Project 1")
metadata <- read.delim("../../../Documents/GitHub/abracadabra/data/map/temp_map.tsv", 
                       header=T,
                        sep='\t',
                         check.names=F,
                         comment='')
otu <- read.table("../../../Documents/GitHub/abracadabra/data/processed_tax/taxonomy_counts_s.txt",
                    comment="",
                    header=TRUE,
                    sep="\t",
                    as.is=TRUE,
                    check.names=F,
                  row=1)

level = 6 # to go to genus level
names_split <- strsplit(rownames(otu), ";")
# code abby supplied to make this work without Tonya's complicated version
# so skip from the collapse part here directly to plotting
otustrings <- sapply(names_split,function(x)paste(x[1:level],collapse = ";"))
otu_L2 <- rowsum(otu,otustrings)

# check counts per species before filtering
range(rowSums(otu_L2))

# what counts are in each person?
range(colSums(otu_L2))

# let's normalize our table!
# Divide each person's species count by the total counts for that person
otu_L2_ra <- sweep(otu_L2, 2, colSums(otu_L2), "/")  

colSums(otu_L2_ra)

#Next up, drop species with low mean relative abundance
otu_L2_limited <- otu_L2[rowMeans(otu_L2_ra)>0.001,]

rowMeans(otu_L2_limited)

# moral of the story is 1) we would keep all 75 genera for analysis, but the goal right now is to plot
# Plotting fewer genera will look nicer (probably) so lets drop to ~30 for plotting

# renormalize for plottin
otu_L2_limited_ra <- sweep(otu_L2_limited, 2, colSums(otu_L2_limited), "/")



library(reshape2)

otu_L2_limited_ra$Genus <- rownames(otu_L2_limited_ra)

melted_otu <- melt(otu_L2_limited_ra)

colnames(melted_otu) <- c("Taxa","SampleID","RelativeAbundance")
       



#plotting
library(ggplot2)
ggplot(melted_otu,
       aes(x = SampleID,
           y = RelativeAbundance,
           fill= Taxa)) +
  geom_bar(stat = "identity",
           position="fill") +
  theme(legend.position ="none")
  scale_x_discrete(labels = NULL)

