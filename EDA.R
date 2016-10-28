#### EDA FOR AN OBJECTIVE ANALYSIS OF TRUMP'S FACEBOOK ACTIVITY ####
tfb = read.csv("trump_fb_analysis.csv")

##change format of the dates
tfb$status_published = as.Date(tfb$status_published, "%m/%d/%Y")

## subset data based on release of multiple reactions for facebook
reactions_released_tfb = tfb[tfb$status_published>"2016-02-25",]

## subset data based on trump's announcement for presidency
trump_announce_tfb = tfb[tfb$status_published>"2015-06-16",]

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

## dates and reactions full data set
dtimes = as.Date(tfb$status_published, format="%m/%d/%Y")
head(dtimes)
tail(dtimes)
plot(dtimes, tfb$num_reactions)

## dates and reactions post facebook reaction release
plot(reactions_released_tfb$status_published, reactions_released_tfb$num_reactions)

## dates and reactions post trump announcement
plot(trump_announce_tfb$status_published, trump_announce_tfb$num_reactions)
### TODO: FIND LINEAR TREND OF THE ABOVE GRAPH

## Subset data - this slice is based on the date of the facebook reactions
total_likes2 = sum(reactions_released_tfb$num_likes, na.rm=TRUE)
total_loves2 = sum(reactions_released_tfb$num_loves, na.rm=TRUE)
total_wows2 = sum(reactions_released_tfb$num_wows, na.rm=TRUE)
total_hahas2 = sum(reactions_released_tfb$num_hahas, na.rm=TRUE)
total_sads2 = sum(reactions_released_tfb$num_sads, na.rm=TRUE)
total_angrys2 = sum(reactions_released_tfb$num_angrys, na.rm=TRUE)

sum_nums2_with_likes = c("total_likes" = total_likes, "total_loves"=total_loves, "total_wows"=total_wows, "total_hahas"=total_hahas, "total_sads"=total_sads, "total_angrys" = total_angrys)

barplot(sum_nums2_with_likes,col=c("red","blue"))

sum_nums2_no_likes = c("total_loves"=total_loves, "total_wows"=total_wows, "total_hahas"=total_hahas, "total_sads"=total_sads, "total_angrys" = total_angrys)

barplot(sum_nums2_no_likes,col=c("red","blue"))




