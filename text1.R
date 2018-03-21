Test1 <- read.csv("Z:/COMMON/Surya/Test1.csv")

library(plyr)
library(SnowballC)
library(tm)kkkk
library(RColorBrewer)
library(wordcloud)
df <- data.frame(dd)
textdata1 <- df[df$d, ]
textdata1$d = gsub("[[:punct:]]", "", textdata1$d)
textdata1$d = gsub("[[:digit:]]", "", textdata1$d)
textdata1$d = gsub("http\\w+", "", textdata1$d)
textdata1$d = gsub("[ \t]{2,}", "", textdata1$d)
textdata1$d = gsub("^\\s+|\\s+$", "", textdata1$d)
try.error = function(x)
{
  y = NA
  try_error = tryCatch(tolower(x), error=function(e) e)
  if (!inherits(try_error, "error"))
    y = tolower(x)
  return(y)
}
textdata1$d = sapply(textdata1$d, try.error)

textdata1$d = removeWords(textdata1$d, stopwords("en"))
#textdata1$d = stripWhitespace(textdata1$d)
#textdata1$d[4]
library(tidyverse)
library(tokenizers)
textdata1$words <- tokenize_words(textdata1$d)
class(textdata1$words)
#textdata1$words2<-ldply(textdata1$words,data.frame)

length(textdata1$words[5])
tab <- table(textdata1$words[5][[1]])

#FOR getting the frequency and count on a loop
for(i in 1:15825)
{
textdata1$freq[[i]]<-table(textdata1$words[[i]])
textdata1$freq[[i]]<-data_frame(word=names(textdata1$freq[[i]]),count = as.numeric(textdata1$freq[[i]]))
}


#table(operacionsdf[[1]])
#fd<-data.frame
textdata1$LOAN_NO<-as.list(textdata1$LOAN_NO)
#converting first the Loan No column to list(for later appending it to the freq list) 
textdata1$LOAN_NO <- lapply(textdata1$LOAN_NO, data.frame, stringsAsFactors = FALSE)
#Then covering each inside list to a dataframe 
textdata1$freq <- lapply(textdata1$freq, data.frame, stringsAsFactors = FALSE)

#BINDING LIST the two lists(LOAN NO and Frequency)
textdata1$both<-lapply(1:length(textdata1$LOAN_NO),function(i) append(textdata1$LOAN_NO[[i]],textdata1$freq[[i]]))

#returns a list of the data frames. So if you just need to save each element of the list as a data frame in your directory just do d below.
operacionsdf <- lapply(textdata1$both, data.frame, stringsAsFactors = FALSE)
library(erer)
write.list(z = operacionsdf, file = "file22.csv")