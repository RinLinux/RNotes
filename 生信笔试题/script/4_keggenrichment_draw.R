
library(ggplot2)
rm(list = ls())
enrich = read.delim("../data/kegg_pathway_enrichment.txt",header=TRUE, sep = "\t")
enrich <- enrich[1:20,]
enrich$RichFactor <- with(enrich, Input.number/Background.number)
enrich <- enrich[order(-enrich$RichFactor),]
enrich$X.Term <- factor(enrich$X.Term,levels = enrich$X.Term)
p = qplot(RichFactor, X.Term, data=enrich, color=P.Value, size=Input.number,
          xlab="Rich Factor", ylab="KEGG Terms", main="Stastistics of Pathway Enrichment")
p = p + scale_color_gradient("Pvalue", low="green",  high="red")
p = p + scale_size_continuous("Gene_number")
p = p + guides(color=guide_colorbar(order=2), size=guide_legend(order=1))
ggsave("../analysis/4_kegg_top20.jpg",dpi=300,p)
