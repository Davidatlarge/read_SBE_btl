filename <- "example_data/EMB.btl"

# get the data
bottle <- readLines(filename)

data <- read.table(filename, 
                   sep = "", 
                   dec = ".",  
                   skip = grep("Btl_Posn", bottle)+1, 
                   header = FALSE, 
                   stringsAsFactors = FALSE,
                   fill = TRUE, # one or more files have "samples per bin" values missing, this fills the blanks
                   na.strings = c("", "NA") # defines values as NA
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

# get the column names for the data table
column.names <- bottle[grep("Btl_Posn", bottle)] # return the line with the column names but in one string with multiple whitespaces
column.names <- scan(text = column.names, what = "") # read the single string into a vector of strings by multiple whitespaces ("")
if(any(grepl("FlECO-AFLTurbWETntu0", column.names))) { # test if x is a part of y; in the .btl ther is nos space between the two parameters
  column.names <- scan(text = gsub("FlECO-AFLTurbWETntu0", "FlECO-AFL TurbWETntu0", column.names), what = "") # replace "FlECO-AFLTurbWETntu0" with "FlECO-AFL TurbWETntu0" and separate it by ""
} 
column.names <- column.names[3:length(column.names)] # remove the first two entries int column names, i.e. Btl_Posn and Date

names(data) <- column.names
names(data)[ncol(data)] <- "statistic" # this column is not named

# get metadata

