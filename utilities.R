
# Check if R package is installed then load library
install_load <- function (package1, ...)  {   
  packages <- c(package1, ...)
  for(package in packages){
    if(package %in% rownames(installed.packages()))
      do.call('library', list(package))
    else {
      install.packages(package,repos="https://mirrors.tuna.tsinghua.edu.cn/CRAN")
      do.call("library", list(package))
    }
  } 
}
install_load("optparse","ggplot2","gplots","reshape2")