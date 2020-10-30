
rm(list = ls())
install_load <- function (package1, ...)  {   
  packages <- c(package1, ...)
  for(package in packages){
    if(package %in% rownames(installed.packages()))
      do.call('library', list(package))
    else {
      install.packages(package,repos="https://mirrors.tuna.tsinghua.edu.cn/CRAN")
      do.call("library", list(package))
    }
  } 
}

install_load("optparse","ggplot2","gplots","reshape2")

library("optparse")
option_list = list(
  make_option(c("-f", "--file"), type="character", default=NULL, 
              help="dataset file name", metavar="character"),
  make_option(c("-o", "--out"), type="character", default="phlyaDatam.pdf", 
              help="output file name [default= %default]", metavar="character")
); 

opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);


if (is.null(opt$file)){
  print_help(opt_parser)
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
}

library(ggplot2)
library(gplots)
library(reshape2)

phlyaData <- read.table(opt$file,sep = "\t",header = T)
phlyaData[is.na(phlyaData)] <- 0
colNam <- as.matrix(colnames(phlyaData))
rowNam <- as.matrix(phlyaData[,1])
getsymbol <- function(x,y){
  symlist <- unlist(strsplit(x,y))
  sym <- symlist[length(symlist)]
  sym
}

phlyaData <- phlyaData[,-1]
phlyaData$oranism <- rowNam

phlyaDatam <- melt(phlyaData)
colnames(phlyaDatam) <- c("oranism","type","count")
varlab <- apply(as.matrix(phlyaDatam$type), 1, getsymbol,y="_")
phlyaDatam$code <- varlab
colmap <- function(x){
  if(x=="U"){y="green"}
  if(x=="C"){y="orange"}
  if(x=="R"){y="black"}
  if(x=="S"){y="blue"}
  if(x=="A"){y="yellow"}
  if(x=="D"){y="cyan"}
  if(x=="W"){y="plum"}
  if(x=="V"){y="magenta"}
  if(x=="I"){y="hotpink"}
  if(x=="M"){y="hotpink"}
  if(x=="other"){y="darkorchid"}
  if(x=="X"){y="white"}
  y
}

colormap <- apply(as.matrix(varlab),1,colmap)

pdf(opt$out,width = 25,height = 10)
p <- ggplot(phlyaDatam, aes(x=type, y=oranism)) +
  geom_point(aes(size=count),colour=colormap,fill=colormap, shape=21) + scale_size_area(max_size=40, guide=FALSE) +
  theme_bw() +
  theme(axis.text.x=element_text(face="bold",size=10,angle=90,hjust = 1),axis.text.y=element_text(face="bold",size=10,hjust = 0))
p
dev.off()

