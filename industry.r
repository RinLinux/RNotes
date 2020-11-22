
library(tidyverse)

industry_data <-  read_csv('industry.csv',col_types = cols(����=col_date()))

l_d <- gather(industry_data, key = industy, value = rate, `��֤50`:`���ز�`)

ggplot(l_d, aes(����, rate, group=industy)) + geom_line(aes(color = industy)) + 
  scale_x_date(date_breaks = "1 month",date_labels = "%B %Y") + theme_bw() + 
  theme(axis.text.x  = element_text(angle=90,vjust=0.5)) 
