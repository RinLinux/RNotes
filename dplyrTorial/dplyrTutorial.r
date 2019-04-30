
setwd("~/Study/notes4R/dplyrTorial")
rm(list = ls())

library(dplyr)
library(downloader)

url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/msleep_ggplot2.csv"
filename <- "msleep_ggplot2.csv"
if (!file.exists(filename)) download(url,filename)
msleep <- read.csv("msleep_ggplot2.csv")
head(msleep)
sleepData <- select(msleep, name, sleep_total)

