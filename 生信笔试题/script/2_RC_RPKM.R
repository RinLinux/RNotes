

library(dplyr)

rm(list = ls())
RC_RPKM <- read.table("../data/RC_RPKM.txt",header = TRUE,sep = "\t",stringsAsFactors = FALSE)
RC_RPKM_ge10 <- RC_RPKM[(apply(select(RC_RPKM,ends_with("RC")), 1, function(x){all(x>10)})),]
write.table(RC_RPKM_ge10,"../analysis/RC_RPKM_ge10.txt",quote = FALSE,sep = "\t",row.names = FALSE)




