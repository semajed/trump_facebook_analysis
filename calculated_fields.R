library(ggplot2)
## function to caclulate sd
get_sd = function(field){
  field1 = as.vector(field)
  sd(field1, na.rm = TRUE)
}

#standard deviations for each numeric field
sd.reactions = get_sd(tfb$num_reactions)
sd.likes = get_sd(tfb$num_likes)
sd.comments = get_sd(tfb$num_comments)
sd.shares = get_sd(tfb$num_shares)
sd.hahas = get_sd(tfb$num_hahas)
sd.angrys = get_sd(tfb$num_angrys)
sd.sads = get_sd(tfb$num_sads)
sd.loves = get_sd(tfb$num_loves)
sd.wows = get_sd(tfb$num_wows)

sd.df = data.frame(sd.reactions,sd.likes,sd.comments,sd.shares,sd.hahas,sd.angrys,sd.sads,sd.loves,sd.wows)


## get just the numeric columns
num_columns = tfb[,6:14]
