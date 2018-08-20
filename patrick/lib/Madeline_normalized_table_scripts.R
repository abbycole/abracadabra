#this is how I made the normalized table
#set working directory
setwd("~/KnightsLab/abracadabra/data/raw_burst_output")

#In tonya.pdf, comment = "" is incorrect, should just be ' '
otu <- read.table("tax.txt",
                  comment='',
                  header = TRUE,
                  sep = "\t",
                  as.is = TRUE,
                  check.names = FALSE,
                  row=1)
colnames(otu)
row.names(otu)

colSums(otu[,1:(ncol(otu)-1)])
for(i in 1:(ncol(otu)-1)){
  otu[,i] <- otu[,i]/sum(otu[,i])
}
colSums(otu[,1:ncol(otu)-1])

#print the normalized table (hopefully)
sink("Normalized_tax.txt")
cat("#OTUID")
write.table(otu,
            sep="\t",
            quote = F,
            col.names = NA)
sink()