
# --------------------------------------------------------
# Topic: R for Data Science, Chapter3
# Author: Linzheng
# Date:Fri Nov 13 15:17:38 2020
# Mail: mixfruitszu@gmail.com
# --------------------------------------------------------

library(nycflights13)
library(tidyverse)

# 1. 找出满足以下条件的所有航班:
# a. 到达时间延误 2 小时或更多的航班。
filter(flights, arr_delay > 120 | dep_delay > 120)

# b. 飞往休斯顿(IAH机场或HOU机场)的航班。
filter(flights, dest %in% c('IAH',"HOU"))

# c. 由联合航空(United)、美利坚航空(American)或三角洲航空(Delta)运营的航班
filter(flights, carrier %in% c("UA","AA","DL") )

# d. 夏季(7月、8月和9月)出发的航班。
filter(flights, month %in% c(7,8,9))

# e. 到达时间延误超过 2 小时，但出发时间没有延误的航班。
filter(flights, arr_delay > 120, dep_delay <=0)

# f. 延误至少 1 小时，但飞行过程弥补回 30 分钟的航班。
filter(flights, dep_delay > 60, dep_delay - arr_delay < 30)

# g. 出发时间在午夜和早上6点之间(包括0点和6点)的航班。
filter(flights, dep_time<=600 | dep_time == 2400)


# 2.  dplyr 中对筛选有帮助的另一个函数是 between()。
# 它的作用是什么?你能使用这个函数 来简化解决前面问题的代码吗?
filter(flights, between(month,7,9))
filter(flights, !between(dep_time, 601, 2359))


# 3 dep_time 有缺失值的航班有多少？其他变量的缺失值情况如何？这样的行表示什么情况？
filter(flights, is.na(dep_time))
nrow(filter(flights, is.na(dep_time)))

summary(flights)
dep_time缺失值有8255个

# 4. Why is NA ^ 0 not missing? Why is NA | TRUE not missing?
# Why is FALSE & NA not missing? Can you figure out the general
# rule? (NA * 0 is a tricky counterexample!)

# 任何数的0次幂都是1；任何值与TRUE取或运算都是TRUE；FALSE取与运算都是FALSE



