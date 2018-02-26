install.packages('foreign')
library(devtools)
devtools::install_github("cardiomoon/Kormaps", force = TRUE)
library(foreign)
require(Kormaps)
require(tmap)



Encoding(names(korpopmap2))<-"UTF-8"
Encoding(areacode$code)<-"UTF-8"
areacode <- kormaps2014::changeCode(areacode)


#?•¨?ˆ˜

submap <- function(map,area){
  code<-area2code(area)
  if(length(code)>0) {
    code1=paste0("^",code)
    temp=Reduce(paste_or,code1)
    mydata<-map[grep(temp,map$code),]
  }
}


is.integer0 <- function(x) { is.integer(x) && length(x) == 0L}

paste_or <- function(...) {
  paste(...,sep="|")
}


area2code <- function(area){
  result<-c()
  for(i in 1:length(area)){
    pos<-grep(area[i],areacode[[2]])
    if(!is.integer0(pos)) temp<-areacode[pos,1]
    else {
      pos<-grep(area[i],areacode[[3]])
      if(!is.integer0(pos)) temp<-areacode[pos,1]
    }
    result=c(result,temp)
  }
  result
}




##?“¸ ?°?´?„°?ŒŒ?¼

getwd()
setwd('c:/easy_r')

green <- read.csv('green2.csv', header = T)
green <- as.data.frame(green)
green$S <- as.integer(green$S)
#green$N <- as.factor(green$N)
#green$code <- as.factor(green$code)
green$codecode <- as.integer(green$code)
#class(green$S)
#class(green$N)
#class(green$code)
#green


##


korpopmap2

korpopmap5 <- korpopmap2
korpopmap5$codecode <- as.integer(korpopmap5$code1)
#korpopmap5$codecode
#class(korpopmap5$codecode)

#greenë³€?ˆ˜?— ?°?´?„°?„£?–´?•¼?•¨

korpopmap5$³²ÀÚ_¸í <- ifelse(korpopmap5$codecode == green$codecode, green$S, NA)
table(is.na(korpopmap5$?‚¨?ž_ëª?))

Seoul2=submap(korpopmap5,"?„œ?š¸")
qtm(Seoul2,"?‚¨?ž_ëª?")+tm_layout(fontfamily="AppleGothic")









