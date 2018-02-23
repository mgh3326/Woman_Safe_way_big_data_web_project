loc<-read.csv("°æÂû¼­3.csv",header=T)
center<-c(mean(loc$LON),mean(loc$LAT))
police<-get_map(center,zoom=11,maptype="roadmap")
police.map<-ggmap(police)+geom_point(data=loc,aes(x=LON,y=LAT),size=3,alpha=0.7)+geom_text(data=loc, aes(x=LON,y=LAT+0.005,label=¿ª¸í),size=3)          

