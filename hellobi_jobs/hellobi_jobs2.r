
# S4 class

rm(list = ls())

setwd("/Users/zhenglin/code/R_code/hellobi_jobs")
library("RCurl")
library("XML")
library("magrittr")

initialize <- list(
  i = 0,
  fullinfo = data.frame(),
  headers  = c(
    "Referer"="https://www.hellobi.com/jobs/search",
    "User-Agent"="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.79 Safari/537.36"
  )
)

setClass("GetData",
         slots = c(
           i="numeric",
           fullinfo="data.frame",
           headers="character"
         ),
         prototype = initialize
)


GetData <- new('GetData')

setGeneric('hellobi',
           function(object) {
             standardGeneric('hellobi')
           }
)

setMethod('hellobi', 'GetData',
          function(object) {
            d      <- debugGatherer()
            handle <- getCurlHandle(debugfunction=d$update,followlocation=TRUE,cookiefile="",verbose = TRUE)
            while (object@i < 10){
              object@i = object@i+1
              url <- sprintf("https://www.hellobi.com/jobs/search?page=%d",object@i)
              tryCatch({
                content    <- getURL(url,.opts=list(httpheader=object@headers),.encoding="utf-8",curl=handle) %>% htmlParse()
                job_item   <- content %>% xpathSApply(.,"//div[@class='job_item_middle pull-left']/h4/a",xmlValue)
                job_links  <- content %>% xpathSApply(.,"//div[@class='job_item_middle pull-left']/h4/a",xmlGetAttr,"href")
                job_info   <- content %>% xpathSApply(.,"//div[@class='job_item_middle pull-left']/h5",xmlValue,trim = TRUE)
                job_salary <- content %>% xpathSApply(.,"//div[@class='job_item-right pull-right']/h4",xmlValue,trim = TRUE)
                job_origin <- content %>% xpathSApply(.,"//div[@class='job_item-right pull-right']/h5",xmlValue,trim = TRUE)
                myreslut   <-  data.frame(job_item,job_links,job_info,job_salary,job_origin,stringsAsFactors = FALSE)
                object@fullinfo  <- rbind(object@fullinfo,myreslut)
                cat(sprintf("第【%d】页已抓取完毕！",object@i),sep = "\n")
              },error = function(e){
                cat(sprintf("第【%d】页抓取失败!",object@i),sep = "\n")
              })
              Sys.sleep(runif(1))
            }
            cat("all page is OK!!!")
            return (object@fullinfo)
          }
)
# 执行类中的方法：
mydata1 <- hellobi(GetData)
