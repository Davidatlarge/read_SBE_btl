library(dplyr)
filename <- "example_data/EMB.btl"

# get the header
bottle <- readLines(filename)
header.end <- grep("Btl_Posn", bottle)+1 # defines the line number where text *END* is found.














# get the data
data <- read.table(filename, 
                   sep="", 
                   dec=".",  
                   skip=header.end, 
                   header = FALSE, stringsAsFactors = FALSE,
                  # col.names=header.df$colnames, 
                   fill=TRUE, # one or more files have "samples per bin" values missing, this fills the blanks
                   na.strings=c("", "NA")# defines values as NA
                  ) 

data <- as.data.frame( # return as a dataframe
  t( # transpose
    apply(data, # apply function to this object
          1, # apply funkction across rows in the object
          function(x) c( # combine the two vectors into one
            rep(NA, sum(is.na(x))), # repeat NA as often as it occurs at the end of the row
            x[1:(length(x)-sum(is.na(x)))] # take from the line the entries from the first to the last that is not NA (NAs are always at the end)
          ) 
    )
  )
)

data <- data[,(max(rowSums(is.na(data)))+1):ncol(data)] # remove rows in the front that contain meta data or NA


###### example snippets
line <- data[4,]
shortline <- line[1:(length(line)-sum(is.na(line)))] # remove the NAs from the line as all an NAs are at the end
linena <- as.data.frame(t(as.data.frame(rep(NA, sum(is.na(line)))))) # make a dataframe with columns filled with NA 
newline <- cbind(linena, shortline) # put the NAs in front of the data values
newline[2,] <- line[1,]
