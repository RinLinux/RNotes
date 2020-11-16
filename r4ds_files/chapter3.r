
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
# year          month             day           dep_time    sched_dep_time   dep_delay          arr_time    sched_arr_time   arr_delay       
# Min.   :2013   Min.   : 1.000   Min.   : 1.00   Min.   :   1   Min.   : 106   Min.   : -43.00   Min.   :   1   Min.   :   1   Min.   : -86.000  
# 1st Qu.:2013   1st Qu.: 4.000   1st Qu.: 8.00   1st Qu.: 907   1st Qu.: 906   1st Qu.:  -5.00   1st Qu.:1104   1st Qu.:1124   1st Qu.: -17.000  
# Median :2013   Median : 7.000   Median :16.00   Median :1401   Median :1359   Median :  -2.00   Median :1535   Median :1556   Median :  -5.000  
# Mean   :2013   Mean   : 6.549   Mean   :15.71   Mean   :1349   Mean   :1344   Mean   :  12.64   Mean   :1502   Mean   :1536   Mean   :   6.895  
# 3rd Qu.:2013   3rd Qu.:10.000   3rd Qu.:23.00   3rd Qu.:1744   3rd Qu.:1729   3rd Qu.:  11.00   3rd Qu.:1940   3rd Qu.:1945   3rd Qu.:  14.000  
# Max.   :2013   Max.   :12.000   Max.   :31.00   Max.   :2400   Max.   :2359   Max.   :1301.00   Max.   :2400   Max.   :2359   Max.   :1272.000  
# NA's   :8255                  NA's   :8255      NA's   :8713                  NA's   :9430      
# carrier              flight       tailnum             origin              dest              air_time        distance         hour      
# Length:336776      Min.   :   1   Length:336776      Length:336776      Length:336776      Min.   : 20.0   Min.   :  17   Min.   : 1.00  
# Class :character   1st Qu.: 553   Class :character   Class :character   Class :character   1st Qu.: 82.0   1st Qu.: 502   1st Qu.: 9.00  
# Mode  :character   Median :1496   Mode  :character   Mode  :character   Mode  :character   Median :129.0   Median : 872   Median :13.00  
# Mean   :1972                                                            Mean   :150.7   Mean   :1040   Mean   :13.18  
# 3rd Qu.:3465                                                            3rd Qu.:192.0   3rd Qu.:1389   3rd Qu.:17.00  
# Max.   :8500                                                            Max.   :695.0   Max.   :4983   Max.   :23.00  
# NA's   :9430                                  
#      minute        time_hour                  
#  Min.   : 0.00   Min.   :2013-01-01 05:00:00  
#  1st Qu.: 8.00   1st Qu.:2013-04-04 13:00:00  
#  Median :29.00   Median :2013-07-03 10:00:00  
#  Mean   :26.23   Mean   :2013-07-03 05:22:54  
#  3rd Qu.:44.00   3rd Qu.:2013-10-01 07:00:00  
#  Max.   :59.00   Max.   :2013-12-31 23:00:00  

# dep_time缺失值有8255个

# 4. 为什么 NA ^ 0 的值不是 NA ？为什么 NA | TRUE 的值不是 NA ？
# 为什么 FALSE & NA 的值不是 NA ？你能找出一般规律吗？（NA * 0 则是精妙的反例！）

# 任何数的0次幂都是1；任何值与TRUE取或运算都是TRUE；FALSE取与运算都是FALSE



