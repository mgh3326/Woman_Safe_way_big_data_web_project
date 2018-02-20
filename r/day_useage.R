gwanakgu201603<-read_xlsx('gwanakgu.xlsx', sheet=1)
gwanakgu201603
gwanakgu201603<-rename(gwanakgu201603,
                       date=gwanakgu201603.date,
                       day= gwanakgu201603.day,
                       useage=gwanakgu201603.useage)
gwanakgu201603
class(gwanakgu201603$day)
table(gwanakgu201603$day)
gwanakgu201603$day<- ifelse(gwanakgu201603$day=='',NA, gwanakgu201603$day)
table(is.na(gwanakgu201603$day))
table(gwanakgu201603$day)
qplot(gwanakgu201603$day)


class(gwanakgu201603$useage)
summary(gwanakgu201603$useage)
qplot(gwanakgu201603$useage)
table(is.na(gwanakgu201603$useage))

day_useage<- gwanakgu201603 %>%
  filter(!is.na(useage)) %>%
  group_by(day) %>%
  summarise(mean_useage=mean(useage))

day_useage
ggplot(data=day_useage, aes(x=day, y=mean_useage))+geom_col()
