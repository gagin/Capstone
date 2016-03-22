library(tm)
library(dplyr)
library(ggplot2)
library(scales)

con <- file("en_US/en_US.twitter.txt", "r")
texts <- readLines(con)
close(con)
lines.count<-length(texts)
cat("Lentgh is", lines.count, "\n")

lines.count<-4444

BigramTokenizer <-
        function(x)
                unlist(lapply(ngrams(words(x), 2), paste, collapse = " "), use.names = FALSE)
portion <- 1000
slot <- 0
freqs <- list()

con <- file("en_US/en_US.twitter.txt", "r")
while(portion*slot < lines.count)
{
        slot <- slot + 1
        
        en.twitter.lines <- readLines(con, portion)


        en.twitter.lines %>% VectorSource %>% VCorpus -> vc
# Do separately, so stopwords would be removed before tokenization
        vc <- vc %>%
        tm_map(tolower) %>%
        tm_map(removePunctuation) %>%
        tm_map(stripWhitespace) %>%
        tm_map(removeWords, stopwords("en")) %>%
        tm_map(PlainTextDocument)
tdm.en.twitter <-
        TermDocumentMatrix(vc,control=list(tokenize=BigramTokenizer))
tdm.en.twitter %>% as.matrix %>% rowSums %>% sort(decr=T) -> freqs[[slot]]
cat ("Processed ", portion*slot, " out of ", lines.count, "\n")
}
close(con)
f2<-unlist(freqs)
f3<-data.frame(x = f2, y = names(f2), stringsAsFactors = FALSE)

all.bigrams <- unique(names(f2))

bigram.
        
for(i in seq(all.bigrams)) {
        
