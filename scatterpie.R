

rm(list = ls())
library(ggplot2)
# mtcars$cyl <- factor(mtcars$cyl) # converts to a categorical variable
# mtcars$gear <- factor(mtcars$gear) # converts to a categorical variable
# 
# p <- ggplot(data=mtcars, aes(x=factor(1), stat="bin", fill=cyl)) + geom_bar(position="fill") # Stacked bar chart
# p <- p + ggtitle("Cylinders by Gears") + xlab("") + ylab("Gears") # Adds titles
# p <- p + facet_grid(facets=. ~ gear) # Side by side bar chart
# p <- p + coord_polar(theta="y") # side by side pie chart
# p
# 
# PhlyaStistic <- read.table("out_DIR.00_12_PhlyaStisticExcel-plot.txt",sep = "\t",header = T)
# fml_org <- read.csv("fml_org.csv",header = T)
# fml_pro <- read.csv("fml_pro.csv",header = T)
# PhlyaStistic[is.na(PhlyaStistic)] <- 0
# PhlyaStistic$radius <-0.005 * PhlyaStistic$count
# cols <- colnames(PhlyaStistic)[6:15]
# p <- ggplot() + geom_scatterpie(aes(y=phyla_number, x=phyla_pro_number,group=protein_fmly,r=radius),data=PhlyaStistic,cols = cols,color = NA) + coord_equal()
# 
# p = p + scale_y_continuous(breaks =fml_org$phyla_number,labels =fml_org$fml_ecCHar) + scale_x_continuous(breaks = fml_pro$phyla_pro_number,labels = fml_pro$protein_fmly)
# 
# p = p + theme_bw()
# pdf("PhlyaStistic.pdf",width = 20,height = 18)
# p + theme(axis.text.x=element_text(face="bold",size=10,angle=90,hjust = 1),axis.text.y=element_text(face="bold",size=10,hjust = 0))
# dev.off()

library(dplyr)
PhlyaStistic_test <- read.table("out_DIR.00_12_PhlyaStisticExcel.txt",sep = "\t",header = T)
fml_new_org <- read.table("out_DIR.00_12_1_PhlyaStisticExcel.txt",header = T,sep = "\t")
fml_new_pro <- read.csv("out_DIR.00_12_2_PhlyaStisticExcel.txt",header = T,sep = "\t")

#color:
# U: #00FF00
# C: #FF6600
# A: #0000FF
# S: #9900FF
# D: #FF0000
# W: #66FFFF
# R: #FFFF00
# I: #996633
# M: #006666
# other: #969696
#  A C D I M other R S U W 
colors <- c("#0000FF","#FF6600","#FF0000","#996633","#006666","#969696","#FFFF00","#9900FF","#00FF00","#66FFFF","#969696")
PhlyaStistic_test[is.na(PhlyaStistic_test)] <- 0
PhlyaStistic_test <- PhlyaStistic_test %>% 
  mutate(count = U + C + S + A + D + W + R + I + M + other)
cols <- colnames(PhlyaStistic_test)[2:11]
PhlyaStistic_test$radius <-0.005 * PhlyaStistic_test$count
p <- ggplot() + geom_scatterpie(aes(y=phyla_number, x=proFml_numbr,group=protein_fmly,r=radius),data=PhlyaStistic_test,cols = cols,color = NA) + coord_equal() + scale_fill_manual(values=colors)

p = p + scale_y_continuous(breaks =fml_new_org$phyla_number,labels =fml_new_org$phyla___name) + scale_x_continuous(breaks = fml_new_pro$proFml_numbr,labels = fml_new_pro$protein_fmly)

p = p + theme_bw()
pdf("PhlyaStistic-new.pdf",width = 20,height = 18)
p + theme(axis.text.x=element_text(face="bold",size=10,angle=90,hjust = 1),axis.text.y=element_text(face="bold",size=10,hjust = 0))
dev.off()
