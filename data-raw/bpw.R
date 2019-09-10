library(readr)

bpw <- read_csv("data-raw/bpw.csv")
usethis::use_data(bpw, overwrite = TRUE)
