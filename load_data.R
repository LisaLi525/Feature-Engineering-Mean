# load_data.R
source("setup.R")

options(java.parameters = "-Xmx8g")
library("RJDBC")
drv <- JDBC("oracle.jdbc.OracleDriver", classPath="path/to/ojdbc6.jar")
con.oracle <- dbConnect(drv, "db_username", "db_password", "db_url")

query <- paste("YOUR SQL QUERY HERE", sep="")
pcp_tran_level_web_query <- dbGetQuery(con.oracle, query)
