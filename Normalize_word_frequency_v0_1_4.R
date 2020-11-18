####
#
###         N O R M A L I Z E   W O R D   F R E Q U E N C Y  
#    
#  ####     Ver 0.1.4     
   #
   ###      ffranzon@sissa.it
   #
   #

# Quick set of functions to normalize word frequency measures from raw counts


# clean workspace
#rm(list = ls())

#   ### set paths of useful directories
#
#

# where the code is stored
codewd=("path")
# input directory
inwd=("path")
# output directory
outwd=("path")


#   ### Input 
#
#

#   # Input: SIZE
#
# size of corpus (total token count)

#ITA # size of itwac=1909826282
corpussize<-1909826282


#   # Input: FREQUENCIES 
#
#  any vector of word frequencies (raw count)

# just define the vector
#word_freq=c(36235, 1020, 52398,  25306031, 65521116, 216788)

# the vector is the column from a df
setwd(inwd)
#dat=read.table("yourfile.txt", T)
#dat=read.csv("yourfile.csv", T, sep=";")
summary(dat)

dat$raw_freq=dat$Frequency
#word_freq=dat$frequency

# add +1 to raw counts of word frequencies
dat$word_freq=dat$raw_freq+1


#   ### Normalize
#

#   normalize freq per million occurrencies

dat$fpmw=((dat$word_freq*10^6)/corpussize)
dat$fpmw=round(dat$fpmw,3)

#   normalize per billion
dat$fpbw=((dat$word_freq*10^9)/corpussize)
dat$fpbw=round(dat$fpbw,3)


#   ### Define count functions
#
#
# 

#   normalize per million

permillion<- function(x){
  permillion<-(x/corpussize)*10^6
  permillion <- round(permillion, 3)
  return(permillion)
}

zipffreq <- function (x) { 
  zipffreq <- (log10(((x/corpussize)*10^6)))+3
  zipffreq <- round(zipffreq, 3)
  return(zipffreq)
}

logten_permillion <- function (x) { 
  logten_permillion <- log10((x/corpussize)*10^6)
  logten_permillion <- round(logten_permillion, 3)
  return(logten_permillion)
}

log_permillion <- function (x) { 
  log_permillion <- log((x/corpussize)*10^6)
  log_permillion <- round(log_permillion, 3)
  return(log_permillion)
}


#  normalize per billion

perbillion<- function(x){
  perbillion<-(x/corpussize)*10^9
  perbillion <- round(perbillion, 3)
  return(perbillion)
}

zipffreq_perbillion <- function (x) { 
  zipffreq_perbillion <- (log10(((x/corpussize)*10^9)))+3
  zipffreq_perbillion <- round(zipffreq_perbillion, 3)
  return(zipffreq_perbillion)
}

logten_perbillion <- function (x) { 
  logten_perbillion <- log10((x/corpussize)*10^9)
  logten_perbillion <- round(logten_perbillion, 3)
  return(logten_perbillion)
}

log_perbillion <- function (x) { 
  log_perbillion <- log((x/corpussize)*10^9)
  log_perbillion <- round(log_perbillion, 3)
  return(log_perbillion)
}


#   ### Apply the function for the desired measure
#
#

#word_freq_zipf=mapply(zipffreq, word_freq)
#word_freq_zipf


#   ## SHORTCUT TO ZIPF


#apply zipf on the fpmw or fpbw
zipffreq3 <- function (x) { 
  zipffreq3 <- (log10(x))+3
  zipffreq3 <- round(zipffreq3, 3)
  return(zipffreq3)
}


#quick check: does the shortcut work
dat$zipf_frequency=mapply(zipffreq, dat$word_freq)
dat$Zipf_bil=mapply(zipffreq3, dat$fpbw)
dat$Zipf_mil=mapply(zipffreq3, dat$fpmw)

dat$Zipf_mil==dat$Zipf
dat$zipf_frequency==dat$Zipf_mil



#   ### Visually inspect distributions 
#
#

par(mfrow=c(2,2))
hist(dat$word_freq)
hist(dat$Zipf)
hist(dat$Zipf_mil)
hist(dat$zipf_frequency)




#   ### Output files
#setwd(outwd)
write.csv(wordfrequency, "word_frequency.csv", row.names = F, sep=";")


#setwd(codewd)
