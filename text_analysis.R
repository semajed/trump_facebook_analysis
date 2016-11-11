library(devtools)
library(ggplot2)
library(wordcloud)
library(RColorBrewer)
library(tm)
library(SnowballC)
library(sentimentr)
library(qdap)

library(sentiment)

try.error = function(x)
{
  y = NA
  try_error = tryCatch(tolower(x), error=function(e) e)
  if (!inherits(try_error, "error"))
    y = tolower(x)
  return(y)
}

tfb = read.csv("trump_fb_analysis.csv")

status_messages = lapply(tfb$status_message, as.character)

head(status_messages)
str(status_messages)
class(status_messages)

status_messages = gsub("[[:punct:]]", "", status_messages)
status_messages = gsub("[[:digit:]]", "", status_messages)
status_messages = gsub("http\\w+", "", status_messages)
status_messages = gsub("[ \t]{2,}", "", status_messages)
status_messages = gsub("^\\s+|\\s+$", "", status_messages)

status_messages = sapply(status_messages, try.error)
status_messages = status_messages[!is.na(status_messages)]
names(status_messages) = NULL

### Word clouds ###
recent_100 = wordcloud(status_messages[1:100], colors=c("red","blue"))
tail_cloud = wordcloud(tail(status_messages,n=100),colors=c("blue","red"))

## learning the tm library ##
sub_status_messages = status_messages[1:100]

sub_text_all = paste(sub_status_messages, collapse = " ")

text_source = VectorSource(sub_text_all)
corpus = Corpus(text_source)
corpus = tm_map(corpus, stripWhitespace)
corpus = tm_map(corpus, removeWords, stopwords("english"))

dtm = DocumentTermMatrix(corpus)
dtm2 = as.matrix(dtm)

frequency = colSums(dtm2)
frequency = sort(frequency, decreasing=TRUE)
head(frequency)

words = names(frequency)




