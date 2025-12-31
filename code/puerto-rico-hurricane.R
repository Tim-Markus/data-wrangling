library(tidyverse)
library(pdftools)
options(digits = 3)

fn <- system.file("extdata", "RD-Mortality-Report_2015-18-180531.pdf", package="dslabs")
system2("open", args = fn)

txt <- pdf_text(fn)
txt

x <- txt[9]
x <- str_split(x, "\n")
x
class(x)
length(x)

s <- x[[1]]
class(s)
length(s)

s <- str_trim(s)
s[1]

header_index <- str_which(s, pattern = "2015")[1]
header_index

all <- str_split(s[header_index], "\\s+", simplify = TRUE)
header <- all[-1]
header
month <- all[1]
month

s
tail_index <- str_which(s, pattern = "Total")
tail_index

n <- str_count(s, pattern = "\\d+")
sum(n == 1)

s <- s[-c(1:header_index, which(n == 1), tail_index:length(s))]
length(s)

s <- str_remove_all(s, "[^\\d\\s]")
s

s <- str_split_fixed(s, "\\s+", n = 6)[,1:5]
s

tab <- s %>%
  as_data_frame() %>%
  setNames(c("day", header)) %>%
  mutate_all(as.numeric)

tab
mean(tab$`2015`)
mean(tab$`2016`)
mean(tab$`2017`[1:19])
mean(tab$`2017`[20:30])

tab_1 <- tab %>% gather(year, deaths, -day) %>%
  mutate(deaths = as.numeric(deaths))
tab_1 %>% tail

tab_1 %>%
  ggplot(aes(day, deaths, color = year)) +
  geom_line() +
  geom_vline(xintercept = 20)



