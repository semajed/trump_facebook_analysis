

#### EDA FOR AN OBJECTIVE ANALYSIS OF TRUMP'S FACEBOOK ACTIVITY ####
tfb = read.csv("trump_fb_analysis.csv")

tfb300 = tfb[1:300,]

##change format of the dates
tfb$status_published = as.Date(tfb$status_published, "%m/%d/%Y")
tfb300$status_published = as.Date(tfb300$status_published, "%m/%d/%Y")

## subset data based on release of multiple reactions for facebook
reactions_released_tfb = tfb[tfb$status_published>"2016-02-25",]

## subset data based on trump's announcement for presidency
trump_announce_tfb = tfb[tfb$status_published>"2015-06-16",]
before_announcement = tfb[tfb$status_published<"2015-06-16",]

before_numposts = nrow(before_announcement)
after_numposts = nrow(trump_announce_tfb)


before_numdays = difftime("2015-06-13", "2009-04-19", unit=c("days"))
after_numdays = difftime("2016-10-17", "2015-06-13", unit=c("days"))

my_matrix = matrix(c(before_numposts, after_numposts, before_numdays, after_numdays),nrow=2, ncol=2)
before_rate = 1119/2246
after_rate = 3039/492

diff_rate = after_rate - before_rate
per_inc_rate = (diff_rate/before_rate)*100


before_reactions = before_announcement$num_reactions
before_sum = sum(before_reactions, na.rm = TRUE)
after_reactions = trump_announce_tfb$num_reactions
after_sum = sum(after_reactions, na.rm = TRUE)

diff_sum = after_sum - before_sum
per_inc_sum = (diff_sum/before_sum)*100




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
qplot(dtimes, tfb$num_reactions)

## dates and reactions latest 300
dtimes = as.Date(tfb300$status_published, format="%m/%d/%Y")
head(dtimes)
tail(dtimes)
qplot(dtimes, tfb300$num_reactions)

## dates and reactions post facebook reaction release
qplot(reactions_released_tfb$status_published, reactions_released_tfb$num_reactions)

boxplot(reactions_released_tfb$num_reactions)
boxplot(reactions_released_tfb$num_likes)
boxplot(reactions_released_tfb$num_loves)
boxplot(reactions_released_tfb$num_hahas)
boxplot(reactions_released_tfb$num_wows)
boxplot(reactions_released_tfb$num_angrys)
boxplot(reactions_released_tfb$num_sads)


## dates and reactions post trump announcement
qplot(trump_announce_tfb$status_published, trump_announce_tfb$num_reactions)
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



### Trump announce analysis, linear model
qplot(trump_announce_tfb$status_published, trump_announce_tfb$num_reactions)
qplot(trump_announce_tfb$status_published, trump_announce_tfb$num_likes)
qplot(trump_announce_tfb$status_published, trump_announce_tfb$num_shares)
qplot(trump_announce_tfb$status_published, trump_announce_tfb$num_comments)

fit = lm(trump_announce_tfb$num_reactions~trump_announce_tfb$status_published)
co = coef(fit)
abline(co, col="red")


## look at highest reactions messages
tfb_ordered = tfb[order(tfb$num_reactions),]
tfb_most = tail(tfb_ordered)

most_reactions = tfb[which.max(tfb$num_reactions),]
most_comments = tfb[which.max(tfb$num_comments),]
most_shares = tfb[which.max(tfb$num_shares),]
most_angrys = tfb[which.max(tfb$num_likes),]


date_freq = as.Date(tfb$status_published, format="%m/%d/%Y")
date_freq_asFact = as.factor(date_freq)
counted = count(date_freq_asFact)
qplot(counted$x, counted$freq)

fit = lme(counted$x~counted$freq)
co = coef(fit)
abline(co, col="red")







