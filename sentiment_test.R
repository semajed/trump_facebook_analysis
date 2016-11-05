library(sentimentr)

try.error = function(x)
{
  y = NA
  try_error = tryCatch(tolower(x), error=function(e) e)
  if (!inherits(try_error, "error"))
    y = tolower(x)
  return(y)
}

tfb = read.csv("trump_fb_analysis.csv")

status_messages = lapply(tfb$status_message[1:100], as.character)
status_messages = gsub("[[:punct:]]", "", status_messages)
status_messages = gsub("[[:digit:]]", "", status_messages)
status_messages = gsub("http\\w+", "", status_messages)
status_messages = gsub("[ \t]{2,}", "", status_messages)
status_messages = gsub("^\\s+|\\s+$", "", status_messages)

status_messages = sapply(status_messages, try.error)
status_messages = status_messages[!is.na(status_messages)]
names(status_messages) = NULL

analysis = classify_emotion(status_messages, algorithm = "bayes", verbose=TRUE)
head(analysis)
tail(analysis)

sen = sentiment(status_messages)
plot(sen$sentiment)
