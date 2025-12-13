library(tidyverse)
path <- system.file("extdata", package="dslabs")
list.files(path)

# generate full path to a file 
filename <- "murders.csv"
fullpath <- file.path(path, filename)
fullpath

# copy file from dslabs package to my working directory
file.copy(fullpath, getwd())

# check if the file exists
file.exists(filename)

dat <- read_csv(filename)
head(dat)

url <- "https://raw.githubusercontent.com/rafalab/dslabs/master/inst/extdata/murders.csv"
dat <- read_csv(url)

# Download file localy
download.file(url, "copy_murders.csv")


# make temp. filename
tmp_filename <- tempfile()
download.file(url, tmp_filename)
dat <- read_csv(tmp_filename)

# remove temp. file
file.remove(tmp_filename)








