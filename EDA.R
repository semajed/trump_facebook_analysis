#### EDA FOR AN OBJECTIVE ANALYSIS OF TRUMP'S FACEBOOK ACTIVITY ####
tfb = read.csv("trump_fb_analysis.csv")

### Big picture perspective of the data
str(tfb)

## Explore the spread of numeric reactions
total_reactions = sum(tfb$num_reactions, na.rm=TRUE)
total_comments = sum(tfb$num_comments, na.rm=TRUE)
total_shares = sum(tfb$num_shares, na.rm=TRUE)
total_likes = sum(tfb$num_likes, na.rm=TRUE)
total_loves = sum(tfb$num_loves, na.rm=TRUE)
total_wows = sum(tfb$num_wows, na.rm=TRUE)
total_hahas = sum(tfb$num_hahas, na.rm=TRUE)
total_sads = sum(tfb$num_sads, na.rm=TRUE)
total_angrys = sum(tfb$num_angrys, na.rm=TRUE)

sum_nums = c("total_reactions" = total_reactions, "total_comments" = total_comments, "total_shares" = total_shares, "total_likes" = total_likes, "total_loves"=total_loves, "total_wows"=total_wows, "total_hahas"=total_hahas, "total_sads"=total_sads, "total_angrys" = total_angrys)

barplot(sum_nums,col=c("green","blue"))

#### EXPLORE THE DATES and REACTIONS ####
dtimes = as.Date(tfb$status_published, format="%m/%d/%Y")
head(dtimes)
tail(dtimes)
plot(dtimes, tfb$num_reactions)
plot(dtimes, tfb$num_comments)
plot(dtimes, tfb$num_likes)



