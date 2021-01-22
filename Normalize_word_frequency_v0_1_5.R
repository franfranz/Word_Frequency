####
#
###         N O R M A L I Z E   W O R D   F R E Q U E N C Y  
#    
#  ####     Ver 0.1.5     
   #
   ###      https://github.com/franfranz/Word_Frequency_Toytools
   #
   #

# Quick set of functions to normalize word frequency measures from raw counts

# required packages: tools

# clean workspace
#rm(list = ls())


#   ### I N P U T   R E Q U I R E D     #----
#
#

# ### paths of useful directories
#
# where the code is stored
codewd=("PATH")
# input directory: where your list(s) are stored
inwd=("PATH")
# output directory
outwd=("PATH")


#  ### Input: your files specifications 
#
# please input the file extension of your files
filext=".csv"
#filext=".txt"

# collect the names of your input files
setwd(inwd)
file_names=dir()[grep((filext), dir())]

# or just input the name if you only have one
# yourfile="yourfile"
# file_names=paste0(yourfile, filext)

# please input the separator in your file
thesep=";"

# please insert a header in your input list file and call "Frequency" the column with frequencies
headerpresence=T


#  ### Input: your preferred normalizations - comment the ones you wish to be included in your output file
#
norms=c("per_million", #frequency per million words
        "zipf", # zipf normalization
        "log_per_million"#, #log frequency per million words
        #"logten_per_million", # log10 frequency per million words
        
        #"per_billion", #frequency per million words
        #"zipf_perbillion", # zipf normalization per billion
        #"log_per_billion", #log10 frequency per billion words
        #"logten_per_billion" #log10 frequency per billion words
)


# ### size of corpus (total token count) # size of itwac=1909826282
#
corpussize<-1909826282

#----



#   ### JUST RUN FROM HERE ON    #----
#
#

#   ### Define count functions
#
#

#   normalized per million

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

log_permillion <- function (x) { 
  log_permillion <- log((x/corpussize)*10^6)
  log_permillion <- round(log_permillion, 3)
  return(log_permillion)
}

logten_permillion <- function (x) { 
  logten_permillion <- log10((x/corpussize)*10^6)
  logten_permillion <- round(logten_permillion, 3)
  return(logten_permillion)
}


#  normalized per billion

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

log_perbillion <- function (x) { 
  log_perbillion <- log((x/corpussize)*10^9)
  log_perbillion <- round(log_perbillion, 3)
  return(log_perbillion)
}

logten_perbillion <- function (x) { 
  logten_perbillion <- log10((x/corpussize)*10^9)
  logten_perbillion <- round(logten_perbillion, 3)
  return(logten_perbillion)
}




#   ### Apply the functions to the frequency measures in your files
#
#

# import files 

for (myfile in file_names){
  listname=tools::file_path_sans_ext(myfile)
  
  if (filext==".csv"){
    dat=read.csv(myfile, headerpresence, sep=thesep)
  } else if (filext== ".txt"){
    dat=read.table(myfile, headerpresence)
  } else {
    print ("Please input a .csv or a .txt file")
  }
 
summary(dat)

dat$raw_freq=dat$Frequency

# add +1 to raw counts of word frequencies
dat$word_freq=dat$raw_freq+1

# apply the desired functions and create a column with results

if ("per_million" %in% norms==T ){
  dat$fpmw=mapply(permillion, dat$word_freq)
}

if ("zipf" %in% norms==T ){
  dat$Zipf=mapply(zipffreq, dat$word_freq)
}

if ("log_per_million" %in% norms==T ){
  dat$fpmw_log=mapply(log_permillion, dat$word_freq)
}

if ("logten_per_million" %in% norms==T ){
  dat$fpmw_log10=mapply(logten_permillion, dat$word_freq)
}

if ("per_billion" %in% norms==T ){
  dat$fpbw=mapply(perbillion, dat$word_freq)
}

if ("zipf_perbillion" %in% norms==T ){
  dat$Zipf_pbw=mapply(zipffreq_perbillion, dat$word_freq)
}

if ("log_per_billion" %in% norms==T ){
  dat$fpbw_log=mapply(log_perbillion, dat$word_freq)
}

if ("logten_per_billion" %in% norms==T ){
  dat$fpbw_log10=mapply(logten_perbillion, dat$word_freq)
}

dat$raw_freq=NULL
dat$word_freq=NULL

# output files
setwd(outwd)
outfilename=paste0(listname, "_norm_freq.csv")
write.csv(dat, outfilename, row.names = F)
setwd(inwd)
   
}



#   ## SHORTCUT TO ZIPF #-----
#
#   If your input is not in a file 
#   or you prefer to get it from a df/ insert it manually
#

#   # Input: FREQUENCIES 
#
#  any vector of word frequencies (raw count)

# just define a numeric vector of frequencies 
#word_freq=c(36235, 1020, 52398,  25306031)
#word_list=c("word1", "word2", "word3", "word4")
#dat_s=as.data.frame(cbind(word_list, word_freq ))
#dat_s$word_freq=as.numeric(dat_s$word_freq)

# define corpussize
#corpussize = 1909826282 # size of itwac

#   ### Normalize
#

#   normalize freq per million occurrencies
#dat_s$fpmw=((dat_s$word_freq*10^6)/corpussize)
#dat_s$fpmw=round(dat_s$fpmw,3)

#   normalize per billion
#dat_s$fpbw=((dat_s$word_freq*10^9)/corpussize)
#dat_s$fpbw=round(dat_s$fpbw,3)

#   define function for zipf 
#zipffreq3 <- function (x) { 
#  zipffreq3 <- (log10(x))+3
#  zipffreq3 <- round(zipffreq3, 3)
#  return(zipffreq3)
#}

#   ### Apply function and create a column with zipf frequency
#

# apply zipf on the fpmw or fpbw
#dat_s$zipf=mapply(zipffreq3, dat_s$fpmw)
#dat_s$zipf_pbw=mapply(zipffreq3, dat_s$fpbw)


#----


