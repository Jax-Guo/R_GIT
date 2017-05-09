install.packages("swirl")
library(swirl)
rm(list=ls())

install_course_zip("~/Downloads/swirl_courses-master.zip", multi=TRUE, which_course="R Programming")
install_course_zip("C:/Users/I330700/Downloads/swirl_courses-master.zip", multi=TRUE)
swirl()