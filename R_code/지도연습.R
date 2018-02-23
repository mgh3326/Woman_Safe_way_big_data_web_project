install.packages('devtools')
install.packages(c('magrittr','leaflet'))
install.packages('ggplot2')
install.packages('ggmap')
install.packages('dplyr','tidyr')
devtools::install_github('cardiomoon/Kormaps2014', force=TRUE)
devtools::install_github("cardiomoon/moonBook2",force=TRUE)


require(Kormaps)
require(tmap)
require(magrittr)
require(leaflet)
library(kormaps2014)
library(moonBook2)
library(ggplot2)
library(ggmap)
library(dplyr)
library(tidyr)
ch_areacode<-changeCode(areacode)
head(ch_areacode)
areacode1=changeCode(areacode)
areacode1


kormap1
kormap2
kormap3

#인코딩 문제 고치기
Encoding(names(korpopmap1))<-"UTF-8"
Encoding(names(korpopmap2))<-"UTF-8"
Encoding(names(korpopmap3))<-"UTF-8"



#내장 인구 데이터를 이용해 한국 지도 그리기
qtm(kormap1)
qtm(korpopmap1,"총인구_명")+tm_layout(fontfamily="NanumGothic")
qtm(korpopmap2,"총인구_명")+tm_layout(fontfamily="NanumGothic")
qtm(korpopmap3,"총인구_명")+tm_layout(fontfamily="NanumGothic")

# ggplot 으로 한국 지도 그리기 위한 전처리
kor <- fortify(korpopmap1, region = "id")
kordf <- merge(kor, korpopmap1@data, by = "id")


# ggplot으로 한국 지도 그리기
ggplot(kordf, aes(x=long.x, y=lat.x, group=group.x, fill=`총인구_명`)) + 
  geom_polygon(color="black") + coord_map() +
  scale_fill_gradient(high = "#132B43", low = "#56B1F7") +
  theme(title=element_text(family="NanumGothic",face="bold"))

# ggplot facet 기능 적용해 보기
# 남녀 인구로 구분
kordfs <- kordf %>% 
  select(id:여자_명) %>% 
  gather(성별,인구,-(id:총인구_명))

# 남녀 인구 한국 지도 시각화
ggplot(kordfs, aes(x=long.x, y=lat.x, group=group.x, fill=`인구`)) + 
  geom_polygon(color="black") + coord_map() +
  scale_fill_gradient(high = "#132B43", low = "#56B1F7") +
  theme(text=element_text(family="NanumGothic",face="bold")) +
  facet_grid(.~ 성별)

Seoul2=submap(korpopmap2,"서울")
qtm(Seoul2,"외국인_계_명")+tm_layout(fontfamily="AppleGothic")



theme_set(theme_gray(base_family="NanumGothic"))

#ggplot(korpopmap1,aes(map_id=code,fill=총인구_명))+
#  geom_map(map=kormap1,colour="black",size=0.1)+
#  expand_limits(x=kormap1$long,y=kormap1$lat)+
#  scale_fill_gradientn(colours=c('white','orange','red'))+
#  ggtitle("2015년도 시도별 인구분포도")+
#  coord_map()




