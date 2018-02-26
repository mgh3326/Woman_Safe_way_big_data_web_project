install.packages("ggplot2")        # install
install.packages("ggmap")
install.packages("raster")
install.packages('rgeos')
install.packages('rgdal')
install.packages('maptools')
install.packages("viridis")

library(ggplot2)                    # library
library(ggmap)
library(raster)
library(rgeos)
library(rgdal)
library(viridis)

setwd("c:\\easy_r")                 # set route
#####################################################################

korea <- shapefile('TL_SCCO_SIG.shp')                 # read shapefile - map data
data1 <- read.csv("green1111.csv", header=T,as.is=T)    # read csv
korea <- fortify(korea, region='SIG_CD')              # sort
korea <- merge(korea, data1, by='id')                 # merge
seoul <- korea[korea$id <= 11740, ]                   # extract seoul

# check seoul map
# ggplot() + geom_polygon(data=seoul,
#                         aes(x=long, y=lat, group=group, fill=area))

p<-ggplot() + geom_polygon(data=seoul,
                           aes(x=long, y=lat, group=group, fill=area),
                           color='black')             # store seoul map into p 

p + scale_fill_gradient(low='white', high='#FF007F')+
  ggtitle("2015~2017 서비스 이용건수")# print map & change color

