read_btl_DK <- function(filename,
                        position.identifer = "GPS_Posn",
                        cruise.identifier = "ReiseNr",
                        station.identifier = "StationNr",
                        bottom.identifier = "Echolote") {
  ## get the data
  bottle <- readLines(filename)
  
  raw.data <- read.table(filename, 
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
      apply(raw.data, # apply function to this object
            1, # apply function across rows in the object
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
  
  ## get metadata 
  # bottle position and ID
  reps <- length(unique(data$statistic)) # number of entries per bottle
  Btl_Posn <- raw.data[,1]
  Btl_Posn <- Btl_Posn[seq(from = 1, to = length(Btl_Posn), by = reps)] # from first colum on raw data take the first entry per bottle
  Btl_ID <- raw.data[,1]
  Btl_ID <- Btl_ID[seq(from = 2, to = length(Btl_ID), by = reps)] # from first colum on raw data take the first entry per bottle
  
  data$Btl_Posn <- rep(Btl_Posn, each = reps)
  data$Btl_ID <- rep(Btl_ID, each = reps)
  
  # bottle data and time
  time <- raw.data[,2]
  time <- time[seq(from = 2, to = length(time), by = reps)]
  month <- raw.data[,2]
  month <- month[seq(from = 1, to = length(month), by = reps)]
  day <- raw.data[,3]
  day <- day[seq(from = 1, to = length(day), by = reps)]
  year <- raw.data[,4]
  year <- year[seq(from = 1, to = length(year), by = reps)]
  time <- paste(year,month,day,time, sep = " ")
  
  data$time <- rep(time, each = reps)
  #data$time <- strptime(data$time, format = "%Y %b %e %H:$M:%", tz = "UTC") # eg 2014 Dec 6 09:11:53
  
  # geographic location
  position <- bottle[grep(position.identifer, bottle)]
  pos.regex <- ".*= ([-1234567890]*) ([1234567890.]*)([NS]) ([-1234567890]*) ([1234567890.]*)([EW]).*" # defines text to be replaced; in this case as regular expression (i.e. could be any text that fits into this pattern)
  latdeg <- as.numeric(sub(pos.regex, 
                           "\\1", # defines which of the "packages" that have been defined in the brackets is used as substitute
                           position))
  latmin <- as.numeric(sub(pos.regex, "\\2", position))
  latdec <- latdeg+latmin/60
  latdir <- sub(pos.regex, "\\3", position)
  longdeg <- as.numeric(sub(pos.regex, "\\4", position))
  longmin <- as.numeric(sub(pos.regex, "\\5", position))
  longdec <- longdeg+longmin/60
  longdir <- sub(pos.regex, "\\6", position)
  
  #data$longitude <- longdec
  #names(data)[names(data)=="longitude"] <- paste("longitude.deg", longdir, sep = "")
  #data$latitude <- latdec
  #names(data)[names(data)=="latitude"] <- paste("latitude.deg", latdir, sep = "")
  
  # cruise name and station number
  cruise <- bottle[grep(cruise.identifier, bottle)] # get text line containing cruise identifier
  cruise <- sub(".*= (.*)$", "\\1", cruise) # extract cruise name
  station <- bottle[grep(station.identifier, bottle)] # get text line containing station identifier
  station <- sub(".*= (.*)$", "\\1", station) 
  
  # station depth (from echo sounding)
  bottom <- bottle[grep(bottom.identifier, bottle)] # get text line containing cruise identifier
  bottom.m <- sub(".*= (.*) m$", "\\1", bottom) # extract cruise name
  
  # filename
  #data$filename <- filename  
  
  return(list("df" = data,
              "meta" = list("filename" = filename,
                            "cruise" = cruise,
                            "station" = station,
                            "bottom" = bottom.m,
                            "position" = position,
                            "longitude decdeg" = longdec,
                            "longitude decdir" = longdir,
                            "latitude decdeg" = latdec,
                            "latitude decdir" = latdir)))
}