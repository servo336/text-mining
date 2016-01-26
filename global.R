library(tm)
library(wordcloud)
library(memoise)

# The list of scientists biographies
biographies <<- list("Albert Einstein" = "einstein",
               "Charles Darwin" = "darwin",
               "Isaac Newton" = "newton")

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(bio) {
  # Careful not to let just any name slip in here; a
  # malicious user could manipulate this value.
  if (!(bio %in% biographies))
    stop("Unrecognize biodata")
  
  text <- readLines(sprintf("./%s.txt", bio),
                    encoding="UTF-8")
  
  docs = Corpus(VectorSource(text))
  docs = tm_map(docs, content_transformer(tolower))
  docs = tm_map(docs, removePunctuation)
  docs = tm_map(docs, removeNumbers)
  docs = tm_map(docs, removeWords, stopwords("english"))   # *Removing "stopwords" 
  docs = tm_map(docs, stripWhitespace)   # *Stripping whitespace   
  docs = tm_map(docs, PlainTextDocument) 
  
  myDTM = TermDocumentMatrix(docs,control = list(minWordLength = 1))
  m = as.matrix(myDTM)
  sort(rowSums(m), decreasing = TRUE)
  
  
})
