install.packages('foreign')
install.packages('dplyr')
install.packages('ggplot2')
install.packages('readxl')
install.packages('plotly')
install.packages('dygraphs')
install.packages('xts')
install.packages('corrplot')

library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)
library(plotly)
library(dygraphs)
library(xts)
library(corrplot)

setwd('c:\\easy_r')
dataset<-read.csv('useage_2016_gwanakgu.csv')

df_dataset <-data.frame(date=dataset$date,
                        day=dataset$day,
                        useage=dataset$useage)
df_dataset$day<- as.character(df_dataset$day)
df_dataset$date<- as.Date(df_dataset$date)
head(df_dataset)


##01 relationship between day and useage  -요일별로 이용실적 건수에 차이가 있는가?
#결측치 확인
#table(is.na(df_dataset$day))
#table(is.na(df_dataset$useage))
#요일별 이용실적
df_day_useage<- df_dataset %>% 
  group_by(day) %>% 
  summarise(mean_useage= mean(useage, na.rm=T))
df_day_useage
#요일별 HISTOGRAM
g_1<- ggplot(data=df_day_useage, aes(x=day, y=mean_useage, fill=day))+ 
  geom_col()+
  scale_x_discrete(limits= c('월','화','수','목','금','토','일'))+
  scale_fill_discrete(limits= c('월','화','수','목','금','토','일'))
g_1
ggplotly(g_1)


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
ggplotly(g_2)




##03 relationship between weather and useage  -최고기온에 따라 이용실적 차이가 있는가?
#rename the variable of weather data 
weather <- read.csv('wether_2016_seoul.csv')  #2017년, 연습용으로 2016년도 만듦
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
#names(df_all_dataset)
#head(df_all_dataset)
#tail(df_all_dataset)


#relationship between date and highest_tem
df_date_highest_tem <- df_all_dataset %>% 
  select(date, highest_tem)
df_date_highest_tem

g_3<- ggplot(data=df_date_highest_tem, aes(x=date, y=highest_tem))+
  geom_line()+
  ylim(-20,40)
g_3
ggplotly(g_3)


#relationship between date and lowest_tem
df_date_lowest_tem<- df_all_dataset %>% 
  select(date, lowest_tem)
df_date_lowest_tem

g_4<- ggplot(data=df_date_lowest_tem, aes(x=date, y=lowest_tem))+
  geom_line()+
  ylim(-20,40)
g_4
ggplotly(g_4)



#여러 값 표현하기 page 296 
#시계열그래프 - 평균기온, 최고기온, 최저기온
daavg <- xts(df_all_dataset$avg_tem, order.by=df_all_dataset$date)
dahigh <- xts(df_all_dataset$highest_tem, order.by=df_all_dataset$date)
dalow <- xts(df_all_dataset$lowest_tem, order.by=df_all_dataset$date)
dabind <- cbind(daavg, dahigh, dalow)
colnames(dabind) <- c('평균기온','최고기온','최저기온')
head(dabind)
g_5 <- dygraph(dabind) %>% dyRangeSelector()
g_5
#result 
#trend 존재


###############계절별 범주 나누기 전#############
#Correlation Analysis 
# between useage and avgerage temperature 
test_df_all_dataset <- df_all_dataset %>% 
  select(useage, avg_tem) %>% 
  filter(!is.na(useage))
test_df_all_dataset$useage<- as.numeric(test_df_all_dataset$useage)
head(test_df_all_dataset)

cor.test(test_df_all_dataset$useage, test_df_all_dataset$avg_tem)
#result 
#p-value < 0.05,  이용실적과 기온은 상관이 통계적으로 유의하다 (인과X)
#cor 0.433951  .....음...trend 제거하기 위해
#      기온별 혹은 계절별 범주를 두고 분석하는것이 더 유의미함

df_num_dataset <- df_all_dataset %>% 
  select(useage,  highest_tem, lowest_tem) %>% 
  filter(!is.na(useage))
cor_1 <- cor(df_num_dataset)
round(cor_1, 3)
corrplot(cor_1)

##remove the trend 
##시도 seasonality, trend, random 요소로 분해해서 그리기

try <- df_all_dataset %>% 
  select(date, useage, avg_tem) %>% 
  filter(!is.na(useage))
head(try)
plot(try, s.window = 'date')

#기온에 따라 사용실적이 다를까?
out=lm(useage~avg_tem, try)
summary(out)
plot(useage~avg_tem, try)
abline(out, col='red')
g_6 <- ggplot(data=try,aes(x=avg_tem,y=useage))+
  geom_count()+
  geom_smooth(method="lm")
g_6
ggplotly(g_6)
#################################################



#weather temperature 5도씩 범주 나눔, 
#categorise the temperature variable in weaterdataset 
#           to cold, cool, mild, hot 
df_all_dataset <- df_all_dataset %>% 
  mutate(Tem = ifelse(avg_tem <0 , 'cold',
                      ifelse(avg_tem <=15, 'cool',
                             ifelse(avg_tem <=25 ,'mild','hot'))))
head(df_all_dataset)
table(df_all_dataset$Tem)

df_Tem_useage<-df_all_dataset %>%
  filter(!is.na(useage)) %>% 
  group_by(Tem) %>% 
  summarise(sum_useage=sum(useage))

df_Tem_useage
g_7<- ggplot(data= df_Tem_useage, aes(x=Tem, y=sum_useage))+
  geom_col()+
  scale_x_discrete(limits= c('cold', 'cool','mild','hot'))

g_7
ggplotly(g_7)

#Tem 별 useage 그리기
df_Tem_useage$cold

