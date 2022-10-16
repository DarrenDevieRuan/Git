library(bigrquery)
library(devtools)
library(bigrquery)
library(dplyr)
library(readxl)
library(lubridate)
library(readr)

Dat<-seq(as.Date(Sys.Date()-27), as.Date(Sys.Date()-27), by="days")
class(Dat)
Day<-format(Dat,format="%d")
Month<-format(Dat,format="%m")
Year<-format(Dat,format="%Y")
Date<-paste(Year,Month,Day,sep="")
StartMonth<-paste(Year,Month,"01",sep="")

EndMonth<-gsub("-","",ceiling_date(Sys.Date()-30, "month") - days(1))
#KALAPA

library(bigrquery)
library(devtools)
library(bigrquery)
library(dplyr)
library(readxl)
library(lubridate)
library(readr)

Dat<-seq(as.Date(Sys.Date()-30), as.Date(Sys.Date()-30), by="days")
class(Dat)
Day<-format(Dat,format="%d")
Month<-format(Dat,format="%m")
Year<-format(Dat,format="%Y")
Date<-paste(Year,Month,Day,sep="")
StartMonth<-paste(Year,Month,"01",sep="")

EndMonth<-gsub("-","",ceiling_date(Sys.Date()-30, "month") - days(1))

KALAPA_BI<-read_excel(paste("E:/Reconliiation/RISK_2/Reconsile/",paste(Year,Month,sep=""),"/KALAPA/","Data Kalapa Rateplus thang ",gsub("0","",Month),".xlsx",sep=""),sheet="KALAPA RATEPLUS")

KALAPA_BI<-filter(KALAPA_BI,KALAPA_BI$`DICH VU`=="KALAPA")

MOBILE_TO_ID_BI<-filter(KALAPA_BI,KALAPA_BI$`NAME CHECK`=="MOBILE_TO_ID")
ID_TO_MOBILE_BI<-filter(KALAPA_BI,KALAPA_BI$`NAME CHECK`=="ID_TO_MOBILE")


KALAPA_DT<-read_excel(paste("E:/Reconliiation/RISK_2/Reconsile/",paste(Year,Month,sep=""),"/KALAPA","/Easy Credit-September-Total charged queries",".xlsx",sep=""))


j<-match("API",KALAPA_DT$`Client ID`,0)

KALAPA_DT<-KALAPA_DT[-c((j-1):nrow(KALAPA_DT)),]

unique(KALAPA_DT$API)


MOBILE_TO_ID_DT<-filter(KALAPA_DT,KALAPA_DT$API=="/mobile2id/get")

ID_TO_MOBILE_DT<-filter(KALAPA_DT,KALAPA_DT$API=="/id2mobile/get")

ID_TO_MOBILE_BI$QUERY_PARAMETER<-paste("id=",ID_TO_MOBILE_BI$`Identity Card`,sep="")
DT_ID_TO_MOBILE<-setdiff(ID_TO_MOBILE_DT$`Query Parameter`,ID_TO_MOBILE_BI$QUERY_PARAMETER)
DT_ID_TO_MOBILE<-filter(ID_TO_MOBILE_DT,ID_TO_MOBILE_DT$`Query Parameter` %in% DT_ID_TO_MOBILE)

ID_TO_MOBILE_CHUNG<-intersect(ID_TO_MOBILE_DT$`Query Parameter`,ID_TO_MOBILE_BI$QUERY_PARAMETER)

ID_TO_MOBILE_CHUNG<-filter(ID_TO_MOBILE_DT,ID_TO_MOBILE_DT$`Query Parameter` %in% ID_TO_MOBILE_CHUNG)



MOBILE_TO_ID_BI$QUERY_PARAMETER<-paste("mobile=",MOBILE_TO_ID_BI$`Phone Number`,sep="")
DT_MOBILE_TO_ID<-setdiff(MOBILE_TO_ID_DT$`Query Parameter`,MOBILE_TO_ID_BI$QUERY_PARAMETER)
DT_MOBILE_TO_ID<-filter(MOBILE_TO_ID_DT,MOBILE_TO_ID_DT$`Query Parameter` %in% DT_MOBILE_TO_ID)

MOBILE_TO_ID_CHUNG<-intersect(MOBILE_TO_ID_DT$`Query Parameter`,MOBILE_TO_ID_BI$QUERY_PARAMETER)

MOBILE_TO_ID_CHUNG<-filter(MOBILE_TO_ID_DT,MOBILE_TO_ID_DT$`Query Parameter` %in% MOBILE_TO_ID_CHUNG)


write_xlsx(DT_ID_TO_MOBILE,paste("E:/Reconliiation/RISK_2/Reconsile/",paste(Year,Month,sep=""),"/KALAPA","/KALAPA_ID_TO_MOBILE_",paste(Year,Month,sep=""),".xlsx",sep=""))

write_xlsx(DT_MOBILE_TO_ID,paste("E:/Reconliiation/RISK_2/Reconsile/",paste(Year,Month,sep=""),"/KALAPA","/KALAPA_MOBILE_TO_ID_",paste(Year,Month,sep=""),".xlsx",sep=""))

