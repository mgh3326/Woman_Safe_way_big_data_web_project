library(devtools)
devtools::install_github("cardiomoon/Kormaps")

library(foreign)

library(devtools)
require(Kormaps)
require(tmap)

qtm(kormap1)

library(kormaps2014)

#인코딩

korpopmap1

names(korpopmap1)
Encoding(names(korpopmap1))<-"UTF-8"
Encoding(names(korpopmap2))<-"UTF-8"
Encoding(areacode$code)<-"UTF-8"
Encoding(names(korpopmap1))<-"UTF-8"
(korpopmap1)
areacode
areacode <- changeCode(areacode)

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



#함수



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

Seoul2=submap(korpopmap2,"서울")
qtm(Seoul2,"외국인_계_명")+tm_layout(fontfamily="AppleGothic")

areacode

class(korpopmap2)
korpopmap4 <- as.data.frame(korpopmap2)
korpopmap4
korpopmap2$

as.specialpolygons.data.frame(korpopmap4)

korpopmap2

changeCode(korpopmap2)
?SpatialPolygonsDataFrame
