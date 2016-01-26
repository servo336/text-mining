function(input, output, session) {
  # Define a reactive expression for the document term matrix
  terms <- reactive({
    # Change when the "update" button is pressed...
    input$update
    # ...but not for anything else
    isolate({
      withProgress({
        setProgress(message = "Processing corpus...")
        getTermMatrix(input$selection)
      })
    })
  })
  
  # Make the wordcloud drawing predictable during a session
  wordcloud_rep <- repeatable(wordcloud)
  
  output$wordcloud <- renderPlot({
    v <- terms()
    
    #Word Cloud
    wordcloud_rep(names(v), v, scale=c(4,0.5),
                  min.freq = input$freq, max.words=input$max,
                  colors=brewer.pal(8, "Dark2"))
    
    
  })
  
  
  
  output$termplot <- renderPlot({
  
    v <- terms()  
    
    # Bar Plot
    x <- input$max
    barplot(v[1:x], las = 2, names.arg =names(v)[1:x],
           col ="lightblue", main = paste(x," Most Frequent Words"),
         ylab = "Word frequencies")
    
  
  })
  
    
  
}