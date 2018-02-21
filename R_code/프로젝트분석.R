install.packages('foreign')
install.packages('dplyr')
install.packages('ggplot2')
install.packages('readxl')
install.packages('tidyr')
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)
library(tidyr)

setwd('c:\\easy_r')
dataset<-read.csv('gwanakgu2016.csv')

df_dataset <-data.frame(date=dataset$date,
                         day=dataset$day,
                         useage=dataset$useage)
df_dataset$day<- as.character(df_dataset$day)
df_dataset$date<- as.Date(df_dataset$date)
df_dataset


##01 relationship between day and useage  -요일별로 이용실적 건수에 차이가 있는가?
#결측치 확인
table(is.na(df_dataset$day))
table(is.na(df_dataset$useage))
#요일별 이용실적
df_day_useage<- df_dataset %>% 
  group_by(day) %>% 
  summarise(mean_useage= mean(useage, na.rm=T))
df_day_useage
#막대그래프
g_1<- ggplot(data=df_day_useage, aes(x=day, y=mean_useage, fill=day))+ 
  geom_col()+
  scale_x_discrete(limits= c('월','화','수','목','금','토','일'))+
  scale_fill_discrete(limits= c('월','화','수','목','금','토','일'))
g_1



##02 relationship between date and useage  - 시간에 따라 이용실적 차이가 있는가?
#결측치 제거
df_date_useage <- df_dataset %>% 
  filter(!is.na(useage))
df_date_useage
#산점도 시계열그래프
g_2<- ggplot(data=df_date_useage, aes(x=date, y=useage))+
  geom_point()+
  geom_line()+
  ylim(0,100)
g_2





##03 relationship between weather and useage  -최고기온에 따라 이용실적 차이가 있는가?
#rename the variable of weather data 
weather <- read.csv('wether_2016_seoul_ex.csv')  #2017년, 연습용으로 2016년도 만듦
weather<- rename(weather,
                 date=날짜,
                 avg_tem=평균기온,
                 highest_tem=최고기온,
                 lowest_tem=최저기온,
                 avg_cloud=평균운량,
                 daily_rain=일강수량)
names(weather)

#join the dataset and weather by date
df_weather<- data.frame(date=weather$date,
                        avg_tem=weather$avg_tem,
                        highest_tem=weather$highest_tem,
                        lowest_tem=weather$lowest_tem) 
head(df_weather)
tail(df_weather)

df_weather$date<- as.Date(df_weather$date)
head(df_weather)
tail(df_weather)


df_weather$avg_tem<- as.character(df_weather$avg_tem)
df_weather$highest_tem<- as.character(df_weather$highest_tem)
df_weather$lowest_tem<- as.character(df_weather$lowest_tem)


class(df_weather$date)


#℃ 기호 제거
#for-loop 로 어케하징...?
fuc<- function(x){
  sub('\\℃', '', x)
}
a<-df_weather$avg_tem
b<-df_weather$highest_tem
c<-df_weather$lowest_tem
df_weather$avg_tem<- fuc(a)
df_weather$highest_tem<- fuc(b)
df_weather$lowest_tem<- fuc(c)


df_weather$avg_tem<- as.numeric(df_weather$avg_tem)
df_weather$highest_tem<- as.numeric(df_weather$highest_tem)
df_weather$lowest_tem<- as.numeric(df_weather$lowest_tem)

df_weather


#all_dataset
df_all_dataset<- left_join(df_dataset, df_weather, by='date')
names(df_all_dataset)
head(df_all_dataset)
tail(df_all_dataset)


#relationship between date and highest_tem
df_date_highest_tem <- df_all_dataset %>% 
  select(date, highest_tem)
df_date_highest_tem

g_3<- ggplot(data=df_date_highest_tem, aes(x=date, y=highest_tem))+
  geom_line()+
  ylim(-10,40)
g_3

#relationship between date and lowest_tem
df_date_lowest_tem<- df_all_dataset %>% 
  select(date, lowest_tem)
df_date_lowest_tem

g_4<- ggplot(data=df_date_lowest_tem, aes(x=date, y=lowest_tem))+
  geom_line()+
  ylim(-10,40)
g_4

#overlay g_3 and g_4     ##질문
g_5<- g_3 + g_4
g_5


