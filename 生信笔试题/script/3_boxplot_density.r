
rm(list = ls())
library(dplyr)
library(reshape2)
library(ggplot2)

datafile <- read.table("../analysis/merge.txt",header = TRUE,sep = "\t",stringsAsFactors = FALSE)
RC_RPKM_ge10 <- datafile[(apply(select(datafile,ends_with("read.count")), 1, function(x){all(x>10)})),]
Gene_name <- RC_RPKM_ge10$Gene.name
RPKM <- cbind(Gene_name,select(RC_RPKM_ge10,ends_with("rpkm")))
RPKM_melt = melt(RPKM, value.name = "RPKM")
colnames(RPKM_melt) <- c("Gene_name","Sample","RPKM")
p_boxplot <- ggplot(RPKM_melt, aes(x=Sample,y=log10(RPKM))) + geom_boxplot(aes(fill=Sample))+
  labs(title="RPKM Distribution",x="Sample", fill = "Sample") + 
  theme(plot.title = element_text(hjust = 0.5))
ggsave("../analysis/3.1_boxplot.jpg",dpi=300,p_boxplot)

p_density <- ggplot(RPKM_melt, aes(x=log10(RPKM),colour=Sample,fill=Sample)) + geom_density(alpha=0.2) +
  labs(title="RPKM Density Distribution",x="log10(RPKM)",y="Density") + guides(guide_legend(title="Sample")) +
  theme(plot.title = element_text(hjust = 0.5))
ggsave("../analysis/3.2_density.jpg",dpi=300,p_density)

