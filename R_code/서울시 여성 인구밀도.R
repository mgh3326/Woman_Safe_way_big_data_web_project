library(devtools)
devtools::install_github("cardiomoon/Kormaps")
library(foreign)
library(devtools)
require(Kormaps)
require(tmap)

qtm(kormap1)

library(kormaps2014)

#인코딩
option(encoding='UTF-8')

Encoding(names(korpopmap1))<-"UTF-8"
Encoding(names(korpopmap2))<-"UTF-8"
Encoding(areacode$code)<-"UTF-8"
Encoding(names(korpopmap1))<-"UTF-8"
areacode <- changeCode(areacode)
areacode

korpopmap1
tm_shape(korpopmap1) +
  tm_fill('총인구_명', thres.poly = 0) +
  tm_facets('name', free.coords=TRUE, drop.shape=TRUE) +
  tm_layout(legend.show = FALSE, title.position = c('center','center'), title.size = 2, fontfamily='AppleGothic')

tm_shape(korpopmap1) +
  tm_fill("총인구_명", thres.poly = 0) +
  tm_facets("name", free.coords=TRUE, drop.shapes=TRUE) +
  tm_layout(legend.show = FALSE, title.position = c("center", "center"), title.size = 2,fontfamily="AppleGothic")


qtm(korpopmap1,"총인구_명")+tm_layout(fontfamily="AppleGothic")

colnames(korpopmap1@data)



#서울시 여성지도
#' Select subdata of map
#'
#' @param map an object of class Shape(SpatialPolygonsDataFrame)
#' @param area a string of area looking for
#'
#' @return Subdata of class Shape of which code matched with area
submap <- function(map,area){
  code<-area2code(area)
  if(length(code)>0) {
    code1=paste0("^",code)
    temp=Reduce(paste_or,code1)
    mydata<-map[grep(temp,map$code),]
  }
}

#' Returns whether x is integer(0)
#'
#' @param x a numeric vector
is.integer0 <- function(x) { is.integer(x) && length(x) == 0L}

#' Paste '|' between vectors
#' @param ... one or more R objects, to be converted to character vectors.
paste_or <- function(...) {
  paste(...,sep="|")
}

#' Seek area from data areacode and returns the code
#'
#' @param area a string looking for
#'
#' @return a code if the area is found, else returns NA
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



#submap() 함수는 지도 중에서 원하는 지역만 골라서 지도를 그릴 수 있도록 해줍니다.
Seoul2=submap(korpopmap2,"서울")
names(korpopmap2)
class
qtm(Seoul2,"내국인_계_명")+tm_layout(fontfamily="AppleGothic")
qtm(Seoul2,"외국인_계_명")+tm_layout(fontfamily="AppleGothic")
qtm(Seoul2,"내국인_여자_명")+tm_layout(fontfamily="AppleGothic")
qtm(Seoul2,"내국인_남자_명")+tm_layout(fontfamily="AppleGothic")
qtm(Seoul2,"외국인_여자_명")+tm_layout(fontfamily="AppleGothic")
qtm(Seoul2,"외국인_남자_명")+tm_layout(fontfamily="AppleGothic")

#연습 
Seoul55=submap(korpopmap2,'서울')
qtm(Seoul55)

?submap





#areacode
#class(korpopmap2)
#korpopmap4 <- as.data.frame(korpopmap2)
#korpopmap4
#korpopmap2$
  
#as.specialpolygons.data.frame(korpopmap4)

#korpopmap2

#changeCode(korpopmap2)
#?SpatialPolygonsDataFrame