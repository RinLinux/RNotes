

#### 记录一些有用的shell脚本片段

+ 检查本系统中可以执行的程序

  ```shell
  #!/bin/bash
  # IFS.OLD=$IFS
  IFS=:
  
  for folder in $PATH
  do
  	echo "$folder:"
  	for file in $folder/*
  	do 
  		if [ -x $file ]
  		then
  			echo "	$file"
  		fi
  	done
  done >bin.txt
  ```



+ `md5sum`

+ 目录文件统计

  ```shell
  #!/bin/sh
  
  mypath=$(echo $PATH | sed 's/:/ /g')
  count=0
  
  for directory in $mypath
  do
  	check=$(ls $directory)
  	for item in $check 
  	do
  		count=$[ $count + 1 ]
  	done
  	echo "$directory - $count"
  	count=0
  done
  ```

  + check path

  ```shell
  !/bin/sh
  
  mypath=(echo PATH | sed 's/:/ /g')
  count=0
  
  for directory in mypath
  do
    check=(ls directory)
    for item in check 
    do
      count=[ count + 1 ]
    done
    echo "directory - count"
    count=0
  done
  
  ```


