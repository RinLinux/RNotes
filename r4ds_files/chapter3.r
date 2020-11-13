
# --------------------------------------------------------
# Topic: R for Data Science, Chapter3
# Author: Linzheng
# Date:Fri Nov 13 15:17:38 2020
# Mail: mixfruitszu@gmail.com
# --------------------------------------------------------

library(nycflights13)
library(tidyverse)

# 1. Find all flights that:
# a. Had an arrival delay of two or more hours
filter(flights, arr_delay > 120 | dep_delay > 120)

# b. Flew to Houston (IAH or HOU)
filter(flights, dest %in% c('IAH',"HOU"))

# c. Were operated by United, American, or Delta
filter(flights, carrier %in% c("UA","AA","DL") )

# d. Departed in summer (July, August, and September)
filter(flights, month %in% c(7,8,9))

# e. Arrived more than two hours late, but didn’t leave late
filter(flights, arr_delay > 120, dep_delay <=0)

# f. Were delayed by at least an hour, but made up over 30 minutes in flight
filter(flights, dep_delay > 60, dep_delay - arr_delay < 30)

# g. Departed between midnight and 6 a.m. (inclusive)
filter(flights, dep_time<=600 | dep_time == 2400)


# 2. Another useful dplyr filtering helper is between(). What does it
# do? Can you use it to simplify the code needed to answer the
# previous challenges?
filter(flights, between(month,7,9))
filter(flights, !between(dep_time, 601, 2359))


# 3. How many flights have a missing dep_time? What other variables are missing? What might these rows represent?
filter(flights, is.na(dep_time))
nrow(filter(flights, is.na(dep_time)))


# 4. Why is NA ^ 0 not missing? Why is NA | TRUE not missing?
# Why is FALSE & NA not missing? Can you figure out the general
# rule? (NA * 0 is a tricky counterexample!)


