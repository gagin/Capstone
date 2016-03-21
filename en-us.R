# install.packages("tm")
#setwd("~/kaggle/CourseraSwift/en_US/")
setwd("D:/Dropbox/CourseraSwift/en_US")

library(tm)
library(dplyr)

con <- file("en_US.twitter.txt", "r")
lines <- readLines(con, 10000)
close(con)



vc <- VCorpus(VectorSource(lines)) 

vc <- tm_map(vc, removePunctuation)
vc <- tm_map(vc, stripWhitespace)
vc <- tm_map(vc, removeWords, stopwords('english'))


tdm <- TermDocumentMatrix(vc)

dtm <- DocumentTermMatrix(vc)
a <- colSums(as.matrix(dtm))
head(sort(a, decreasing = T))

#DocumentTermMatrix(vc) %>% as.matrix %>% colSums %>% sort(decr=T) %>% table

DocumentTermMatrix(vc) %>% as.matrix %>% colSums %>% sort(decr=T) %>% table -> terms.freq.table
library(scales)
percent(as.vector(terms.freq.table/sum(terms.freq.table)))
# 63% of words are only in a single document

tdm.nop <- TermDocumentMatrix(vc, control = list(removePunctuation = TRUE))
tm_term_score(tdm,"lol") %>% max

links<-tm_term_score(tdm.nop,"link")
links[links==max(links)]
#131 302
vc[[131]][1]