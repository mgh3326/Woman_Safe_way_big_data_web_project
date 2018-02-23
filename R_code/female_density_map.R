install.packages('devtools')
devtools::install_github('cardiomoon/kormaps',force = TRUE)
require(Kormaps)
require(tmap)
install.packages('stringi')
library(stringi)


qtm(kormap1)

tm_shape(korpopmap1) +
  tm_fill("√—¿Œ±∏_∏Ì", thres.poly = 0) +
  tm_facets("name", free.coords=TRUE, drop.shapes=TRUE) +
  tm_layout(legend.show = FALSE, title.position = c("center", "center"), title.size = 2,fontfamily="AppleGothic")


korpopmap1

qtm(korpopmap1,"√—¿Œ±∏_∏Ì")+tm_layout(fontfamily="AppleGothic")


colnames(korpopmap1@data)

str(changeCode(korpopmap1))
