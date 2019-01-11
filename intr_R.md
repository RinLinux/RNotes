## 常使用的R函数整理

##### 1 `sink`函数

sink() 函数将输出结果重定向到文件

```R
sink(file = NULL, append = FALSE, type = c("output", "message"),split = FALSE)

e.g.
sink("hello.txt")
cat("hello world")
sink()
```

##### 2 `cat`函数 

函数既能输出到屏幕，也能输出到文件

```R
cat(... , file = "", sep = " ", fill = FALSE, labels = NULL,append = FALSE)

e.g.
cat("hello",file="./test.txt",append=T)
```

#####3 `rm` `ls`函数

`rm()`删除当前环境中的变量

`ls()`显示当前环境中的对象

```R
rm(..., list = character(), pos = -1,envir = as.environment(pos), inherits = FALSE)

e.g
#清空当前环境中所有的变量
rm(list=ls())
```

#####4 `paste`函数

将字符串组合在一起

```R
paste (..., sep = " ", collapse = NULL)

e.g
> labs <- paste(c("X","Y"), 1:10, sep="")
> labs
 # [1] "X1"  "Y2"  "X3"  "Y4"  "X5"  "Y6"  "X7"  "Y8"  "X9"  "Y10"
```

#####5 `mode` `typeof` `class`函数

对象在内存中的存储类型，包括：

<u>基本数据类型</u> 'atomic' mode：numeric（Integer/double）, complex, character和logical；

<u>递归的对象</u>（recursive object）：list或 function。

`typeof()`mode和typeof描述的是数据在内存中的存储类型。

`class()` 是一种<u>抽象类型</u>，或者可以理解为一种<u>数据结构</u>，主要是用来给泛型函数识别参数用。

```R
> d <- data.frame(x=c(1,2))
> mode(d)
# [1] "list"
> class(d)
# [1] "data.frame"
```

#####6 `apply`家族函数

`apply`函数族是R语言中数据处理的一组核心函数，通过使用`apply`函数，我们可以实现对数据的循环、分组、过滤、类型控制等操作。

`apply`函数本身就是解决数据循环处理的问题，为了面向不同的数据类型，不同的返回值，`apply`函数组成了一个函数族，包括了**8**个功能类似的函数。这其中有些函数很相似，有些也不是太一样的。

其中`tappy`和`apply`用于**<u>分组计算</u>** ,`mapply`用于**<u>多参数计算</u>**,`lapply`用于**<u>循环迭代</u>**: 简化版本`sapply`、递归版本`rapply`，`eapply`用于环境空间遍历。最常用的函数是`apply`和`sapply`。

- **`apply`**函数可以对矩阵、数据框、数组(二维、多维)，按行或列进行循环计算，对子元素进行迭代，并把子元素以参数传递的形式给自定义的FUN函数中，并以返回计算结果。

```R
apply(X, MARGIN, FUN, ...)

X为matrix、arrary、data.frame
MARGIN: 按行计算或按按列计算，1表示按行，2表示按列

e.g:1
> x<-matrix(1:12,ncol=3)
> x
#     [,1] [,2] [,3]
#[1,]    1    5    9
#[2,]    2    6   10
#[3,]    3    7   11
#[4,]    4    8   12
> apply(x,1,sum)
 # [1] 15 18 21 24

e.g:2
# 生成data.frame
 > x <- cbind(x1 = 3, x2 = c(4:1, 2:5)); x
#     x1 x2
#[1,]  3  4
#[2,]  3  3
#[3,]  3  2
#[4,]  3  1
#[5,]  3  2
#[6,]  3  3
#[7,]  3  4
#[8,]  3  5
    
# 自定义函数myFUN，第一个参数x为数据
# 第二、三个参数为自定义参数，可以通过apply的'...'进行传入。
> myFUN <- function(x, c1, c2) {
    +   c(sum(x[c1],1), mean(x[c2])) 
    + }
    
# 把数据框按行做循环，每行分别传递给myFUN函数，设置c1,c2对应myFUN的第二、三个参数
> apply(x,1,myFUN,c1='x1',c2=c('x1','x2'))
 #        [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8]
 #   [1,]  4.0    4  4.0    4  4.0    4  4.0    4
 #   [2,]  3.5    3  2.5    2  2.5    3  3.5    4
```

- **`lapply`**函数是一个最基础循环操作函数之一，用来对list、data.frame数据集进行循环，并返回和X长度同样的list结构作为结果集，通过lapply的开头的第一个字母’l’就可以判断返回结果集的类型。

```R
lapply(X, FUN, ...)
```

- **`sapply`**函数是一个简化版的`lapply`，`sapply`增加了2个参数`simplify`和`USE.NAMES`，主要就是让输出看起来更友好，返回值为向量，而不是list对象。

  ```R
  sapply(X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE)
  
  # simplify: 是否数组化，当值array时，输出结果按数组进行分组
  # USE.NAMES: 如果X为字符串，TRUE设置字符串为数据名，FALSE不设置
  
  > x <- cbind(x1=3, x2=c(2:1,4:5))
      
  # 对矩阵计算，计算过程同lapply函数
  > sapply(x, sum)
  # [1] 3 3 3 3 2 1 4 5
      
  # 对数据框计算
  > sapply(data.frame(x), sum)
  x1 x2 
  12 12 
      
  # 检查结果类型，sapply返回类型为向量，而lapply的返回类型为list
  > class(lapply(x, sum))
  # [1] "list"
  > class(sapply(x, sum))
  # [1] "numeric"
  ```

- **`vapply`**函数类似于`sapply`，提供了`FUN.VALUE`参数，用来控制返回值的行名，这样可以让程序更健壮。

  ```R
  vapply(X, FUN, FUN.VALUE, ..., USE.NAMES = TRUE)
  ```

- **`mapply`**也是`sapply`的变形函数，类似多变量的`sapply`，但是参数定义有些变化。第一参数为自定义的FUN函数，第二个参数’…’可以接收多个数据，作为FUN函数的参数调用。

  ```R
  mapply(FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE,USE.NAMES = TRUE)
  
  # MoreArgs: 参数列表
  l1 <- list(a = c(1:10), b = c(11:20))
  l2 <- list(c = c(21:30), d = c(31:40))
  mapply(sum, l1$a, l1$b, l2$c, l2$d)
  ```

  多参数版本的sapply()。第一次计算传入各组向量的第一个元素到FUN，进行结算得到结果；第二次传入各组向量的第二个元素，得到结果；第三次传入各组向量的第三个元素…以此类推。

- **`tapply`**用于分组的循环计算，通过INDEX参数可以把数据集X进行分组，相当于group by的操作。

  ```R
  tapply(X, INDEX, FUN = NULL, ..., simplify = TRUE)
  
  # 通过iris$Species品种进行分组
  > tapply(iris$Petal.Length,iris$Species,mean)
   #    setosa versicolor  virginica 
   #  1.462      4.260      5.552
  
  # 对向量x和y进行计算，并以向量t为索引进行分组，求和
  > set.seed(1)
  # 定义x,y向量
  > x<-y<-1:10;x;y
  # [1]  1  2  3  4  5  6  7  8  9 10
  # [1]  1  2  3  4  5  6  7  8  9 10
      
  # 设置分组索引t
  > t<-round(runif(10,1,100)%%2);t
  # [1] 1 2 2 1 1 2 1 0 1 1
      
  # 对x进行分组求和
  > tapply(x,t,sum)
   #0  1  2
   #8 36 11 
  ```

- **`rapply`**是一个递归版本的`lapply`，它只处理<u>**list**</u>类型数据，对<u>**list**</u>的每个元素进行递归遍历，如果<u>**list**</u>包括子元素则继续遍历。

  ```R
  rapply(object, f, classes = "ANY", deflt = NULL, how = c("unlist", "replace", "list"), ...)
  
  # object:list数据
  # f: 自定义的调用函数
  # classes : 匹配类型, ANY为所有类型
  # deflt: 非匹配类型的默认值
  # how: 3种操作方式，当为replace时，则用调用f后的结果替换原list中原来的元素；当为list时，新建一个list，类型匹配调用f函数，不匹配赋值为deflt；当为unlist时，会执行一次unlist(recursive = TRUE)的操作
  
  e.g
  # 对一个list的数据进行过滤，把所有数字型numeric的数据进行从小到大的排序
  > x=list(a=12,b=1:4,c=c('b','a'))
  > y=pi
  > z=data.frame(a=rnorm(10),b=1:10)
  > a <- list(x=x,y=y,z=z)
      
  # 进行排序，并替换原list的值
  > rapply(a,sort, classes='numeric',how='replace')
  $x
  $x$a
  [1] 12
  
  $x$b
  [1] 1 2 3 4
  
  $x$c
  [1] "b" "a"
  
  
  $y
  [1] 3.141593
  
  $z
               a  b
  1  -1.77804692  1
  2  -1.50146387  2
  3  -0.94906418  3
  4  -0.89203358  4
  5  -0.75635333  5
  6   0.06036062  6
  7   0.10101413  7
  8   1.07798041  8
  9   1.60783523  9
  10  1.73481191 10
  # 只有z$a的数据进行了排序，检查z$b的类型，发现是integer，是不等于numeric的，所以没有进行排序。
  ```

- **`eapply`**对一个环境空间中的所有变量进行遍历。

  ```R
  eapply(env, FUN, ..., all.names = FALSE, USE.NAMES = TRUE)
  
  # 查看所有变量的占用内存大小
  > ls()
  [1] "a"  "l1" "l2" "x"  "y"  "z" 
  > eapply(environment(), object.size)
  $x
  736 bytes
  
  $y
  56 bytes
  
  $z
  1024 bytes
  
  $l1
  544 bytes
  
  $l2
  544 bytes
  
  $a
  2256 bytes
  ```

##### 7 `subset`函数

按照一定的条件筛选数据

用法：

```R
## Default S3 method:
subset(x, subset, ...)

## S3 method for class 'matrix'
subset(x, subset, select, drop = FALSE, ...)

## S3 method for class 'data.frame'
subset(x, subset, select, drop = FALSE, ...)

e.g
numvec = c(2,5,8,9,0,6,7,8,4,5,7,11)
charvec = c("David","James","Sara","Tim","Pierre",
        "Janice","Sara","Priya","Keith","Mark",
        "Apple","Sara")
gender = c("M","M","F","M","M","M","F","F","F","M","M","F")
state = c("CO","KS","CA","IA","MO","FL","CA","CO","FL","CA","WY","AZ")
df = data.frame(numvec=c(numvec), name=c(charvec),gender=c(gender), state=c(state))

subset(df, numvec < 5)
#  numvec   name gender state
#1      2  David      M    CO
#5      0 Pierre      M    MO
#9      4  Keith      F    FL
subset(df, name == "Sara")
#   numvec name gender state
#3       8 Sara      F    CA
#7       7 Sara      F    CA
#12     11 Sara      F    AZ
subset(df, numvec==5, select=c(name, state))
#    name state
#2  James    KS
#10  Mark    CA
subset(df, name != "Sara" & gender == "F" & numvec > 5)
#  numvec  name gender state
#8      8 Priya      F    CO
```

关于数据的筛选操作，有一个更好的R包可以使用`dplyr`.

`subset`函数存在一些风险，在一些情况下会得到非预期的结果，在平常严格的编程需求中可以使用`[`替代

**TODO**:`dplyr`包函数的整理

##### 8 `gl`函数

生成指定水平模式的因子

```R
gl(n, k, length = n*k, labels = seq_len(n), ordered = FALSE)

# n为水平数，k为重复的次数，length为结果的长度

## First control, then treatment:
gl(2, 8, labels = c("Control", "Treat"))
[1] Control Control Control Control Control Control Control Control Treat   Treat   Treat  
[12] Treat   Treat   Treat   Treat   Treat  
Levels: Control Treat
## 20 alternating 1s and 2s
gl(2, 1, 20)
[1] 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2
Levels: 1 2
## alternating pairs of 1s and 2s
gl(2, 2, 20)
 [1] 1 1 2 2 1 1 2 2 1 1 2 2 1 1 2 2 1 1 2 2
Levels: 1 2
```

