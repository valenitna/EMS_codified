
options(java.parameters = "-Xmx1024m")

library(XLConnect)
library(rTwChannel)
library(igraph)
library(networkD3)
library(htmlwidgets)



source("main_data_channel.r")


date_events=readRDS("date_events.rds")
codified_df=readRDS("codified_dfx.rds")

codified_df_full=channel_analytic(codified_df,use_channel_dates = TRUE,Ntop=100,naming="DISIT",graph_analisys=TRUE,corpus_analisys=FALSE)
codified_df_native=channel_analytic(codified_df,use_channel_dates = TRUE,Ntop=100,only_original_tweet =TRUE,naming="DISIT",graph_analisys=TRUE,corpus_analisys=TRUE)
saveRDS(codified_df_full,"an_codified_full.rds")
saveRDS(codified_df_native,"an_codified_native.rds")


######################################################################################################################################################################################

######################################################################################################################################################################################
# [1] "channel_stat"              "daily_stat"                "table_hash"                "table_message"             "table_mentions"            "table_links"              
# [7] "table_authors"             "table_authors_retweeter"   "retweeted_authors"         "favorited_authors"         "favorite_message"          "rank_message_retweeted"   
# [13] "top_message"               "top_authors"               "top_hash"                  "top_mentions"              "top_authors_retweeter"     "topfull_authors_retweeted"
# [19] "topfull_message_retweeted" "graph_retweet"             "graph_mentions"            "channel_data"              "account_stats"             "channel_corpus"           
# [25] "word_freq_matr"           
# 
######################################################################################################################################################################################


codified_df_full=readRDS("an_codified_full.rds")
res=main_data_channel(codified_df_full,name="cod_full",native=F,corpus=F,filterdegree = 10);


codified_df_native=readRDS("an_codified_native.rds")
res=main_data_channel(codified_df_native,name="cod_native",native=T,corpus=T,filterdegree = 10);

########################################################################################################################################################

names_stream=c('CODtos',"CODlig","CODsar","CODer","CODcal","CODsic")

########################################################################################################################################################

      
idx=grep("#allertameteotos",codified_df$message,ignore.case = T)
codified_TOS=codified_df[idx,]
write.csv(codified_TOS,"full_codified_TOS.csv")
codified_full_TOS=channel_analytic(codified_TOS,use_channel_dates = TRUE,Ntop=11,naming="DISIT",graph_analisys=TRUE,corpus_analisys=TRUE)
codified_native_TOS=channel_analytic(codified_TOS,use_channel_dates = TRUE,only_original_tweet = TRUE,Ntop=11,naming="DISIT",graph_analisys=TRUE,corpus_analisys=TRUE)

saveRDS(codified_full_TOS,"codified_full_TOS.rds")

res=main_data_channel(codified_full_TOS,name="TOS_full",native=F,corpus=T)
res=main_data_channel(codified_native_TOS,name="TOS_native",native=T,corpus=T)



idx=grep("#allertameteolig",codified_df$message,ignore.case = T)
codified_LIG=codified_df[idx,]
write.csv(codified_LIG,"full_codified_LIG.csv")
codified_full_LIG=channel_analytic(codified_LIG,use_channel_dates = TRUE,Ntop=11,naming="DISIT",graph_analisys=TRUE,corpus_analisys=TRUE)
codified_native_LIG=channel_analytic(codified_LIG,use_channel_dates = TRUE,only_original_tweet = TRUE,Ntop=11,naming="DISIT",graph_analisys=TRUE,corpus_analisys=TRUE)

saveRDS(codified_full_LIG,"codified_full_LIG.rds")
res=main_data_channel(codified_full_LIG,name="LIG_full",native=F,corpus=T,filterdegree = 5)
res=main_data_channel(codified_native_LIG,name="LIG_native",native=T,corpus=T,filterdegree = 5)


idx=grep("#allertameteosar",codified_df$message,ignore.case = T)
codified_SAR=codified_df[idx,]
write.csv(codified_SAR,"full_codified_SAR.csv")
codified_full_SAR=channel_analytic(codified_SAR,use_channel_dates = TRUE,Ntop=11,naming="DISIT",graph_analisys=TRUE,corpus_analisys=TRUE)
codified_native_SAR=channel_analytic(codified_SAR,use_channel_dates = TRUE,only_original_tweet = TRUE,Ntop=11,naming="DISIT",graph_analisys=TRUE,corpus_analisys=TRUE)

saveRDS(codified_full_SAR,"codified_full_SAR.rds")
res=main_data_channel(codified_full_SAR,name="SAR_full",native=F,corpus=T,filterdegree = 5)
res=main_data_channel(codified_native_SAR,name="SAR_native",native=T,corpus=T,filterdegree = 5)



idx=grep("#allertameteoer",codified_df$message,ignore.case = T)
codified_ER=codified_df[idx,]
write.csv(codified_ER,"full_codified_ER.csv")
codified_full_ER=channel_analytic(codified_ER,use_channel_dates = TRUE,Ntop=11,naming="DISIT",graph_analisys=TRUE,corpus_analisys=TRUE)
codified_native_ER=channel_analytic(codified_ER,use_channel_dates = TRUE,only_original_tweet = TRUE,Ntop=11,naming="DISIT",graph_analisys=TRUE,corpus_analisys=TRUE)

saveRDS(codified_full_ER,"codified_full_ER.rds")

res=main_data_channel(codified_full_ER,name="ER_full",native=F,corpus=T,filterdegree = 5)
res=main_data_channel(codified_native_ER,name="ER_native",native=T,corpus=T,filterdegree = 5)


idx=grep("#allertameteocal",codified_df$message,ignore.case = T)
codified_CAL=codified_df[idx,]
write.csv(codified_CAL,"full_codified_CAL.csv")
codified_full_CAL=channel_analytic(codified_CAL,use_channel_dates = TRUE,Ntop=11,naming="DISIT",graph_analisys=TRUE,corpus_analisys=TRUE)
codified_native_CAL=channel_analytic(codified_CAL,use_channel_dates = TRUE,only_original_tweet = TRUE,Ntop=11,naming="DISIT",graph_analisys=TRUE,corpus_analisys=TRUE)

saveRDS(codified_full_CAL,"codified_full_CAL.rds")

res=main_data_channel(codified_full_CAL,name="CAL_full",native=F,corpus=T,filterdegree = 5)
res=main_data_channel(codified_native_CAL,name="CAL_native",native=T,corpus=T,filterdegree = 5)

idx=grep("#allertameteosic",codified_df$message,ignore.case = T)
codified_SIC=codified_df[idx,]
write.csv(codified_SIC,"full_codified_SIC.csv")
codified_full_SIC=channel_analytic(codified_SIC,use_channel_dates = TRUE,Ntop=11,naming="DISIT",graph_analisys=TRUE,corpus_analisys=TRUE)
codified_native_SIC=channel_analytic(codified_SIC,use_channel_dates = TRUE,only_original_tweet = TRUE,Ntop=11,naming="DISIT",graph_analisys=TRUE,corpus_analisys=TRUE)

saveRDS(codified_full_SIC,"codified_full_SIC.rds")

res=main_data_channel(codified_full_SIC,name="SIC_full",native=F,corpus=T,filterdegree = 5)
res=main_data_channel(codified_native_SIC,name="SIC_native",native=T,corpus=T,filterdegree = 5)

