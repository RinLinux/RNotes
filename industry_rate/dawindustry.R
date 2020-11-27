library(reshape2)
library(ggplot2)


industry_data <-  read.csv('Industry-data.csv',header = T,sep=",",fileEncoding = 'utf-8')

class(industry_data)
dim(industry_data)
industry_data

time=as.character(industry_data[,1])
startd=time[1]
endd=time[length(time)]
startd=as.character(as.Date(startd, "%Y/%m/%d")) 
endd=as.character(as.Date(endd, "%Y/%m/%d")) 

mydata <- melt(industry_data,id="日期")
colnames(mydata) <- c("time","industry","rate")


p = ggplot(data = mydata,aes(x=time,y=rate,group =industry,color=industry))+
     #geom_point()+
     geom_line()+
     xlab("日期")+
     ylab("强度值")+
     theme_bw() +
     theme(panel.grid.major=element_line(colour=NA),
           panel.background = element_rect(fill = "transparent",colour = NA),
           plot.background = element_rect(fill = "transparent",colour = NA),
           panel.grid.minor = element_blank(),
           #text = element_text(family = "GB1"),
           axis.text.x  = element_text(angle=90,vjust=0.5))


ggsave('Industry Rate.pdf', p, width = 10, height = 6, family="GB1")





