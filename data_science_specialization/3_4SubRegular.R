#sub gsub
sub("\\.","",names(iris))
gsub("_"," ","this_is_a_underlines")

#grep grepl
grep("set",iris$Species,value = T)
table(grepl("set",iris$Species))

#^[0-9][a-zA-Z]$
#[^?.]$
#^([Gg]ood|[Bb]ad)
#[Bb]ush( +[^ ]+ +){1,5} debate
