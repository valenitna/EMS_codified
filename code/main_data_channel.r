
main_data_channel=function(x,name,native=F,graph=T,corpus=F,csv=FALSE,filterdegree=2) {
  
  if ( native==F) {name=paste0(name,"_F")}
  if ( native==T) {name=paste0(name,"_N")}
  
  res=list()
  res[[1]]=channel_outputs(x,param="channel_stat",suffix_file=name, na_string="",filecsv =csv)
  res[[2]]=channel_outputs(x,param="daily_stat",suffix_file=name,filecsv =csv)
  res[[3]]=channel_outputs(x,param="table_hash",suffix_file=name,filecsv =csv)
  res[[4]]=channel_outputs(x,param="table_mentions",suffix_file=name,filecsv =csv)
  res[[5]]=channel_outputs(x,param="table_authors",suffix_file=name,filecsv =csv)
  res[[6]]=channel_outputs(x,param="table_links",suffix_file=name,filecsv =csv)
  res[[7]]=channel_outputs(x,param="favorited_authors",suffix_file=name,filecsv =csv)
  res[[8]]=channel_outputs(x,param="retweeted_authors",suffix_file=name,filecsv =csv)
  channel_outputs(x,param="channel_data",suffix_file=name,filecsv =csv)
  res[[9]]=NULL
  res[[10]]=NULL
  
  if ( native ==FALSE) {
    res[[9]]=channel_outputs(x,param="retweeted_authors",suffix_file=name,filecsv =csv)
    res[[10]]=channel_outputs(x,param="table_authors_retweeter",suffix_file=name,filecsv =csv)
  }
  
  res[[11]]=NULL
  
  if ( corpus == T) {
    res[[11]]=channel_outputs(x,param="word_freq_matr",suffix_file=name,filecsv=csv)
  }
  
  if ( graph == T) {
    
    require(networkD3)
    require(htmlwidgets)
    
    
    centrality_mentions=data.frame(users=names(igraph::degree(x$graph_mentions, mode='in')),
                                   indegree=as.numeric(igraph::degree(x$graph_mentions, mode='in')),
                                   outdegree=as.numeric(igraph::degree(x$graph_mentions, mode='out')),
                                   betweenness=as.numeric(igraph::betweenness(x$graph_mentions)),
                                   closeness=as.numeric(igraph::closeness(x$graph_mentions)),
                                   eigenvector=as.numeric(igraph::eigen_centrality(x$graph_mentions)$vector))
    
    writeWorksheetToFile(paste0("mentions_graph_centrality_",name,".xls"), data=centrality_mentions, sheet="mentions_g_par")
    
    
    graph_mentions_codified_full=x$graph_mentions
    V(graph_mentions_codified_full)$size=degree(graph_mentions_codified_full)
    deg <- degree(graph_mentions_codified_full, mode = "in")
    idx <- names(which(deg > filterdegree))
    graph_mentions_codified_full <- induced.subgraph(graph_mentions_codified_full, idx)
    gd <- get.data.frame(graph_mentions_codified_full, what = "edges")
    a=simpleNetwork(gd, fontSize = 12)
    saveWidget(a,paste0("mention_graph_",name,".html"))
    write.graph(x$graph_mentions, file =paste0("mention_graph_",name,".graphml"), format = "graphml")
    
    if ( native ==FALSE) {
      
      centrality_retweet=data.frame(users=names(igraph::degree(x$graph_retweet, mode='in')),
                                    indegree=as.numeric(igraph::degree(x$graph_retweet, mode='in')),
                                    outdegree=as.numeric(igraph::degree(x$graph_retweet, mode='out')),
                                    betweenness=as.numeric(igraph::betweenness(x$graph_retweet)),
                                    closeness=as.numeric(igraph::closeness(x$graph_retweet)),
                                    eigenvector=as.numeric(igraph::eigen_centrality(x$graph_retweet)$vector))
      
      writeWorksheetToFile(paste0("retweet_graph_centrality_",name,".xls"), data=centrality_retweet, sheet="retweet_g_par")
      
      graph_retweet_codified_full=x$graph_retweet
      V(graph_retweet_codified_full)$size=degree(graph_retweet_codified_full)
      deg <- degree(graph_retweet_codified_full, mode = "in")
      idx <- names(which(deg > filterdegree))
      graph_retweet_codified_full <- induced.subgraph(graph_retweet_codified_full, idx)
      
      gd <- get.data.frame(graph_retweet_codified_full, what = "edges")
      a=simpleNetwork(gd, fontSize = 12)
      saveWidget(a,paste0("retweet_graph_",name,".html"))
      write.graph(x$graph_retweet, file =paste0("retweet_graph_",name,".graphml"), format = "graphml")
      
    }
  }
  
  return(res)
  
}


# You have to create a file connection.
# g1.gexf <- igraph.to.gexf(g1)
# f <- file("campnet.gexf")
# writeLines(g1.gexf$graph, con = f)
# close(f)
