##apply函数使用汇总
#####Example_1

  **`split`**函数能够分解类型更加复杂的对象，我们看下面的例子：我加载了一个叫datasets（数据集）的包，然后观察里面的airquality（空气质量）数据框，你可以看到数据的前6行，数据大概有100行。我们可以看到有Ozone、 Solar.R、 Wind、Tem等的测量值，比如我只想计算Ozone、Solar.R、 Wind和Tem在一个月内的平均值。那么我需要做的是，把这个数据框按月分组，然后利用apply函数或者是colMeans函数来计算不同变量的列均值。

```R
library(datasets)
head(airquality)
s <- split(airquality,airquality$Month)
class(s)
lapply(s, function(x) colMeans(x[,c("Ozone", "Solar.R", "Wind", "Temp")]))
lapply(s, function(x) colMeans(x[,c("Ozone", "Solar.R", "Wind", "Temp")],na.rm=TRUE))
```
#####Example_2
  在array上，沿margin方向，依次调用 FUN 。返回值为vector。margin表示数组引用的第几维下标（即array[index1, index2, ...]中的第几个index），1对应为1表示行，2表示列，c(1,2)表示行列。margin=1时， apply(a, 1, sum) 等效于下面的操作

```R
a <- array(c(1:24), dim=c(2,3,4))
result=c()
for (i in c(1:dim(a)[1])) {
    result <- c(result, sum(a[i,,]))
}
```
  经实测，只能用在二维及以上的array上，不能用在vector上（如果要应用于vector，请使用 lapply 或 sapply ）。以matrix为例，如下

```R
> m <- matrix(c(1:10), nrow=2)
> m
  [,1] [,2] [,3] [,4] [,5]
[1,]    1    3    5    7    9
[2,]    2    4    6    8   10
> apply(m, 1, sum)
[1] 25 30
> apply(m, 2, sum)
[1]  3  7 11 15 19
```
 Example_3
  一维array的例子（即vector）

```R
> v <- c(1:5)
> ind <- c('a','a','a','b','b')
> tapply(v, ind)
[1] 1 1 1 2 2
> tapply(v, ind, sum)
a b 
6 9 
> tapply(v, ind, fivenum)
$a
[1] 1.0 1.5 2.0 2.5 3.0

$b
[1] 4.0 4.0 4.5 5.0 5.0
```
  二维array的例子（即matrix）

```R
> m <- matrix(c(1:10), nrow=2)
> m
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    3    5    7    9
[2,]    2    4    6    8   10
> ind <- matrix(c(rep(1,5), rep(2,5)), nrow=2)
> ind
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    1    1    2    2
[2,]    1    1    2    2    2
> tapply(m, ind)
 [1] 1 1 1 1 1 2 2 2 2 2
> tapply(m, ind, mean)
1 2 
3 8 
> tapply(m, ind, fivenum)
$`1`
[1] 1 2 3 4 5

$`2`
[1]  6  7  8  9 10
```
 Example_4
by

  by(dataframe, INDICES, FUN, ..., simplify=TRUE)
  by 可以当成dataframe上的 tapply 。 indices 应当和dataframe每列的长度相同。返回值是 by 类型的object。若simplify=FALSE，本质上是个list。

```R
> df <- data.frame(a=c(1:5), b=c(6:10))
> ind <- c(1,1,1,2,2)
> res <- by(df, ind, colMeans)
 > res
ind: 1
a b 
2 7 
------------------------------------------------------------ 
ind: 2
  a   b 
4.5 9.5 
> class(res)
[1] "by"
> names(res)
[1] "1" "2"
```
 Example_5
  在 list 上逐个元素调用 FUN 。可以用于dataframe上，因为dataframe是一种特殊形式的list。例

    > lst <- list(a=c(1:5), b=c(6:10))
    > lapply(lst, mean)
    $a
    [1] 3
    
    $b
    [1] 8
    
    > lapply(lst, fivenum)
    $a
    [1] 1 2 3 4 5
    
    $b
    [1]  6  7  8  9 10
  比 lapply 多了一个 simplify 参数。如果 simplify=FALSE ，则等价于 lapply 。否则，在上一种情况的基础上，将 lapply 输出的list简化为vector或matrix。例

    > lst <- list(a=c(1:5), b=c(6:10))
    > sapply(lst, mean)
    a b 
    3 8 
    > sapply(lst, fivenum)
      a  b
    [1,] 1  6
    [2,] 2  7
    [3,] 3  8
    [4,] 4  9
    [5,] 5 10
 Example_6
tapply实现crosstable功能
  以一个例子演示。原始数据为按年份year、地区loc和商品类别type进行统计的销售量。我们要制作两个销售总量的crosstable，一个以年份为行、地区为列，一个以年份为行，类别为列。

    > df <- data.frame(year=kronecker(2001:2003, rep(1,4)), loc=c('beijing','beijing','shanghai','shanghai'), type=rep(c('A','B'),6), sale=rep(1:12))
    > df
      year      loc type sale
    1  2001  beijing     A   1
    2  2001  beijing     B   2
    3  2001 shanghai     A   3
    4  2001 shanghai     B   4
    5  2002  beijing     A   5
    6  2002  beijing     B   6
    7  2002 shanghai     A   7
    8  2002 shanghai     B   8
    9  2003  beijing     A   9
    10 2003  beijing     B  10
    11 2003 shanghai     A  11
    12 2003 shanghai     B  12
    > tapply(df$sale, df[,c('year','loc')], sum)
        loc
    year    beijing shanghai
      2001       3        7
      2002      11       15
      2003      19       23
    > tapply(df$sale, df[,c('year','type')], sum)
        type
    year     A  B
      2001  4  6
      2002 12 14
      2003 20 22
 Example_7



```R
x <- iris[,1:4]
names(x) <- c("x1","x2","x3","x4")
aggregate(x1+x2+x3+x4~x1,FUN=sum,data=x)
y <- subset(x, x1==4.4)
sum(y)
with(x, sapply(split((x1 + x2 + x3 + x4), x1), sum)) #  s  stands for  simplify
with(x, lapply(split((x1 + x2 + x3 + x4), x1), sum)) #  l  stands for list
with(x, rapply(split((x1 + x2 + x3 + x4), x1), sum)) #  r  stands  for  recursive
with(x, tapply((x1 + x2 + x3 + x4), INDEX=x1 , sum)) #  t  stands  for  table
with(x, vapply(split((x1 + x2 + x3 + x4), x1), sum, FUN.VALUE=1))
with(x, by((x1 + x2 + x3 + x4), x1, sum))

```

   
​            

```R
urls <- c("http://stat.ethz.ch/R-manual/R-devel/library/base/html/connections.html","http://en.wikipedia.org/wiki/Xz")
x1=lapply(urls,readLines)
x2=sapply(urls,readLines)
x3=mapply(con=urls,readLines)
x4=vapply(urls, function(i)  list(readLines(i)), list(1))
```
Example_8
​    theMatrix <- matrix(1:9, nrow = 3) 
    ##### 对行进行累加运算
​    apply(theMatrix, 1, sum)   
    ##### 对列进行累加运算
​    apply(theMatrix, 2, sum)　  
    ##### same as
rowSums(theMatrix) 

colSums(theMatrix)  

```R
# apply
theMatrix[2, 1] <- NA  
apply(theMatrix, 1, sum)  
apply(theMatrix, 1, sum, na.rm = TRUE)

# lapply sapply
theList <- list(A = matrix(1:9, 3), B = 1:8, c = matrix(1:4, 2))  
lapply(theList, sum)
sapply(theList, sum)

# mapply
firstList <- list(A = matrix(1:16, 4), B = matrix(1:9, 3))  
secondList <- list(A = matrix(1:9, 3), B = matrix(1:16, 8))
simpleFunc <- function(x, y) {  
  # NROW函数返回对象的行数
  NROW(x) + NROW(y) 
}
mapply(simpleFunc, firstList, secondList) 
```

 Example_9
#### 使用tapply,sapply(lapply)函数可以快速实现功能和有效减少代码量

tapply(x,f,g)  -- x为向量，f为因子列，g为操作函数，相对数据框进行类似操作可以用by函数
sapply(list,g) -- g为操作函数，返还结果为向量，而lapply返还结果为list形式。常与split结合使用
数据为1001路公交车不同站点上车人数统计

线路名称	车牌号	到达站点	上车人数
1001	粤BM8475	14	11
1001	粤BM8475	13	3
1001	粤BM8475	12	10
1001	粤BM8475	10	5
1001	粤BM8475	8	1
1001	粤BM8475	14	11
1001	粤BM8475	13	3
1001	粤BM8475	12	10
1001	粤BM8475	10	5
1001	粤BM8475	8	1
1001	粤BM8476	14	11
1001	粤BM8476	13	3
1001	粤BM8476	12	10
1001	粤BM8476	10	5
1001	粤BM8476	8	1
1001	粤BM8476	14	11
1001	粤BM8476	13	3
1001	粤BM8476	12	10
1001	粤BM8476	10	5
1001	粤BM8476	8	1
##### 统计不同站点的上车人数

    (Freq <- tapply(data[,4], data[,3], sum))
      1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16 
    120 257 325 164 174 186 205  80 118 267 259 130  77 541 704 133 

# 按照车牌号分类，分别统计不同站点上车人数

    data <- split(data, data$车牌号)   ## 对数据按照车牌号分组，拆成列表
    Freq <- sapply(data, function(data){
        ## 按照车牌号统计不同站点上车人数
        tapply(data$上车人数, data$到达站点, sum)
    })  
    ## 查看结果
    Freq[1] 
    $粤BM8475
     1   2   3   4   5   7   8   9  10  12  13  14  15 
    14  34  12   6  15   2   4  39   7  34   3  27   1

# R code run

    mydata <- read.table("clipboard",header=T)
    class(mydata)
    dim(mydata)
    head(mydata)
    data <- mydata
    
    (Freq <- tapply(data[,4], data[,3], sum))
    
    data <- split(data, data$车牌号)
    Freq <- sapply(data, function(data){
      tapply(data$上车人数, data$到达站点, sum)
    })  
    Freq[1] 
    class(Freq)
    data.frame(Freq)