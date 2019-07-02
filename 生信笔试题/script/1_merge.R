library(dplyr)
library(purrr)
library(stringr)


setwd("../data/Quantitative_results_for_each_sample")
rm(list = ls())
sample_list <- list.files(path = ".",pattern = "txt")
datatable <- lapply(sample_list, function(x){
  y = read.table(x,sep = "\t",stringsAsFactors = FALSE,header = TRUE)
  name = str_c(str_extract(x,"\\w"),"_",colnames(y)[2:5])
  colnames(y) <- c("Gene name",name)
  y
  })
setwd("../../script")
mergefile <- reduce(datatable,full_join,by="Gene name")
write.table(mergefile,file = "../analysis/merge.txt",quote = FALSE,sep = "\t",row.names = FALSE)
