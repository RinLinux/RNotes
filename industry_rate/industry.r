
library(tidyverse)

industry_data <-  read_csv('industry.csv',col_types = cols(日期=col_date()))

l_d <- gather(industry_data, key = industy, value = rate,`上证50`:`房地产`)

p <- ggplot(l_d, aes(日期, rate, group=industy)) + geom_line(aes(color = industy)) + 
  scale_x_date(date_breaks = "1 week",date_labels = "%W-%Y") + labs(x='Week-Year', y='Rate')+ theme_bw() + 
  theme(axis.text.x  = element_text(angle=90,vjust=0.5)) 

ggsave('Industry Rate.pdf', p,width = 10, height = 6,family="GB1")
