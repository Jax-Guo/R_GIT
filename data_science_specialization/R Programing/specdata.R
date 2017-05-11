#Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate) 
#across a specified list of monitors. The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. 
#Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 'directory' argument 
#and returns the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA. 
pollutantmean <- function(directory="specdata", pollutant="sulfate", id = 1:10){
  id <- ifelse(id>=100,as.character(id),
               ifelse(id>=10,paste0("0",id),paste0("00",id)))
  # wrong:loc <- paste0("/", directory, "/", id,".csv")
  loc <- paste0(directory, "/", id,".csv")
  filelist <- lapply(loc, read.csv)
  meanlist <- sapply(filelist, 
                     function(x){
                          poll <- na.omit(as.data.frame.list(x)[pollutant])
                          mean(as.matrix(poll),na.rm = T)
                    })
  mean(as.matrix(meanlist))
}

#不知为何，前两个的答案是错的
pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "nitrate", 23)

#Write a function that reads a directory full of files and reports the number of completely observed cases in each data file. 
#The function should return a data frame where the first column is the name of the file and the second column is the number of complete cases.
complete <- function(directory="specdata", id = 1:10){
  id <- ifelse(id>=100,as.character(id),
               ifelse(id>=10,paste0("0",id),paste0("00",id)))
  # wrong:loc <- paste0("/", directory, "/", id,".csv")
  loc <- paste0(directory, "/", id,".csv")
  filelist <- lapply(loc, read.csv)
  cs_count <- sapply(filelist, 
                     function(x){
                        sum(complete.cases(as.data.frame.list(x)))
                    })
  data.frame(id = id,nobs = cs_count)
}
complete()

#Write a function that takes a directory of data files and a threshold for complete cases 
#and calculates the correlation between sulfate and nitrate for monitor locations 
#where the number of completely observed cases (on all variables) is greater than the threshold.
corr <- function(directory="specdata",threshold = 0, id = 1:332){
  id <- ifelse(id>=100,as.character(id),ifelse(id>=10,paste0("0",id),paste0("00",id)))
  # wrong:loc <- paste0("/", directory, "/", id,".csv")
  loc <- paste0(directory, "/", id,".csv")
  filelist <- lapply(loc, read.csv)
  comp <- sapply(filelist, function(x){
                  sum(complete.cases(as.data.frame.list(x)))
                })
  comp_file <- filelist[comp>=threshold]
  corv <- sapply(comp_file, 
                 function(x){
                    cs <- complete.cases(as.data.frame.list(x))
                    x_count <- sum(cs)
                    corr = 0 
                    if(x_count >= threshold){
                      corr = cor(x[cs,"sulfate"],x[cs,"nitrate"])
                    }
                    return(corr)
                })
  return(corv)
}

cr <- corr("specdata", 400)
head(cr)
