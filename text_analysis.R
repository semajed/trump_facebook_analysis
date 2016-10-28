require(devtools)
require(ggplot2)
require(wordcloud)
require(RColorBrewer)
require(tm)
require(SnowballC)
require(sentimentr)

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

class_emo = classify_emotion(status_messages, algorithm="bayes", prior=1.0)


try.error = function(x)
{
  y = NA
  try_error = tryCatch(tolower(x), error=function(e) e)
  if (!inherits(try_error, "error"))
    y = tolower(x)
  return(y)
}