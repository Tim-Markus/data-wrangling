library(tidyverse)
library(dslabs)
data("gapminder")


# create and insect a tidy data frame
tidy_data <- gapminder %>%
  filter(country %in% c("South Korea", "Germany")) %>%
  select(country, year, fertility)
head(tidy_data)


# plotting tidy data 
tidy_data %>%
  ggplot(aes(year, fertility, color=country)) +
  geom_point()


# import and insect example of original Gapminder data in wide format
path <- system.file("extdata", package="dslabs")
filename <- file.path(path, "fertility-two-countries-example.csv")
wide_data <- read_csv(filename)
select(wide_data, country, `1960`:`1967`)


# snippet of wide data
wide_data %>% select(country, "1960":"1965")

# move the values in the columns 1960 through 2015 into a single column
wide_data %>% pivot_longer(`1960`:`2015`)

# another way to do this - only country isn't being pivoted
wide_data %>% pivot_longer(-country)

# change the default column names
new_tidy_data <- wide_data %>%
  pivot_longer(-country, names_to="year", values_to="fertility")
head(new_tidy_data)

class(tidy_data$year)
class(new_tidy_data$year)

# use the names_transform argument to change the class of the year values to numeric
new_tidy_data <- wide_data %>%
  pivot_longer(-country, names_to="year", values_to="fertility",
               names_transform = list(year=as.numeric))
head(new_tidy_data)

# plot the data as before
new_tidy_data %>% ggplot(aes(year, fertility, color=country)) +
  geom_point()


# convert the tidy data to wide data
new_wide_data <- new_tidy_data %>%
  pivot_wider(names_from=year, values_from=fertility)
select(new_wide_data, country, `1960`:`1967`)
select(new_tidy_data, country, year, fertility)




path <- system.file("extdata", package="dslabs")
fname <- "life-expectancy-and-fertility-two-countries-example.csv"
filename <- file.path(path, fname)

raw_dat <- read_csv(filename)
select(raw_dat, 1:4)

dat <- raw_dat %>% pivot_longer(-country)
head(dat)

# dat %>% separate(name, c("year", "name"), sep="_")
# dat %>% separate(name, c("year", "name"), convert=TRUE)

dat %>% separate(name, c("year", "name"), sep = "_",
                 extra = "merge", convert = TRUE) %>%
  pivot_wider()




dat %>% 
  separate(name, c("year", "name_1", "name_2"), 
           fill = "right", convert = TRUE) %>%
  unite(name, name_1, name_2, sep="_") %>%
  spread(name, value) %>%
  rename(fertility = fertility_NA)


data(us_contagious_diseases)
head(us_contagious_diseases)
dat_wide <- us_contagious_diseases

dat_tidy <- dat_wide %>%
  pivot_longer(-state, names_to = "disease", values_to = "count")

d <- read_csv("resources/times.csv", col_types="dcccc")
head(d)

tidy_data <- d %>%
  pivot_longer(-age_group, names_to = "key", values_to = "value") %>% 
  separate(col  = key, into  = (c("year", "variable_name")), sep = "_") %>% 
  pivot_wider(names_from = variable_name, values_from = value)
head(tidy_data)


stats <- read.csv("resources/stats.csv")
head(stats)

stats %>%
  separate(col = key, into = c("player", "variable_name"), sep = "_", extra = "merge") %>% 
  pivot_wider(names_from = variable_name, values_from = value)

stats %>%
  separate(col = key, into = c("player", "variable_name"), sep = "_") %>% 
  pivot_wider(names_from = variable_name, values_from = value)


library(tidyverse)
library(dslabs)

head(co2)

co2_wide <- data.frame(matrix(co2, ncol = 12, byrow = TRUE)) %>% 
  setNames(1:12) %>%
  mutate(year = as.character(1959:1997))
head(co2_wide)

co2_tidy <- pivot_longer(co2_wide, -year, names_to = "month", values_to = "co2")

co2_tidy %>% ggplot(aes(as.numeric(month), co2, color = year)) + geom_line()




library(dslabs)
data(admissions)
dat <- admissions %>% select(-applicants)

head(dat)
pivot_wider(dat, names_from = admitted, values_from = major)

tmp <- admissions %>%
  pivot_longer(cols = c(admitted, applicants), names_to = "key", values_to = "value")
tmp

tmp2 <- unite(tmp, column_name, c(key, gender))
tmp2







# import US murders data
library(tidyverse)
library(ggrepel)
library(dslabs)
ds_theme_set()
data(murders)
head(murders)

# import US election results data
data(polls_us_election_2016)
head(results_us_election_2016)
identical(results_us_election_2016$state, murders$state)

tab <- left_join(murders, results_us_election_2016, by="state")
head(tab)

tab %>% ggplot(aes(population/10^6, electoral_votes, label = abb)) +
  geom_point() +
  geom_text_repel() +
  scale_x_continuous(trans = "log2") +
  scale_y_continuous(trans = "log2") +
  geom_smooth(method = "lm", se = FALSE)


tab1 <- slice(murders, 1:6) %>% select(state, population)
tab1
tab2 <- slice(results_us_election_2016, c(1:3, 5, 7:8)) %>% select(state, electoral_votes)
tab2

#left_join
left_join(tab1, tab2)
tab1 %>% left_join(tab2)

#right_join
tab1 %>% right_join(tab2)

#inner_join
inner_join(tab1, tab2)

#full_join
full_join(tab1, tab2)

#semi_join
semi_join(tab1, tab2)

#anti-join
anti_join(tab1, tab2)




bind_cols(a = 1:3, b = 4:6)

tab1 <- tab[, 1:3]
tab2 <- tab[, 4:6]
tab3 <- tab[, 7:9]

new_tab <- bind_cols(tab1, tab2, tab3)
head(new_tab)

tab1 <- tab[1:2,]
tab2 <- tab[3:4,]

tab1
tab2

bind_rows(tab1, tab2)




# SET OPERATORS
# intersection
tab1 <- tab[1:5,]
tab2 <- tab[3:7,]
tab1
tab2
intersect(tab1, tab2)

# union
tab1 <- tab[1:5,]
tab2 <- tab[3:7,]
tab1
tab2
union(tab1, tab2)

# set difference
setdiff(1:10, 6:15)
setdiff(6:15, 1:10)
tab1 <- tab[1:5,]
tab2 <- tab[3:7,]
tab1
tab2
setdiff(tab1, tab2)

# set equal
setequal(1:5, 1:6)
setequal(1:5, 5:1)

setequal(tab1, tab2)



library(tidyverse)
library(rvest)

url <- "https://en.wikipedia.org/wiki/Murder_in_the_United_States_by_state"
h <- read_html(url)
class(h)

tab <- h %>% html_nodes("table")
tab <- tab[[2]]
tab

tab <- tab %>% html_table
tab

tab <- tab %>% setNames(c("state", "population", "total", "murders", "gun_murders", "gun_ownership", "total_rate", "murder_rate", "gun_murder_rate"))
head(tab)


h <- read_html("http://www.foodnetwork.com/recipes/alton-brown/guacamole-recipe-1940609")
recipe <- h %>% html_node("h1") %>% html_text()
prep_time <- h %>% html_node(".recipe-meta__item--time") %>% html_text()
ingredients <- h %>% html_node(".o-Ingredients__a-Ingredient") %>% html_text()

guacamole <- list(recipe, prep_time, ingredients)
guacamole


get_recipe <- function(url){
  h <- read_html(url)
  recipe <- h %>% html_node(".o-AssetTitle__a-HeadlineText") %>% html_text()
  prep_time <- h %>% html_node(".m-RecipeInfo__a-Description--Total") %>% html_text()
  ingredients <- h %>% html_nodes(".o-Ingredients__a-Ingredient") %>% html_text()
  return(list(recipe = recipe, prep_time = prep_time, ingredients = ingredients))
}

# read in raw murders data from Wikipedia
url <- "https://en.wikipedia.org/w/index.php?title=Gun_violence_in_the_United_States_by_state&direction=prev&oldid=810166167"
murders_raw <- read_html(url) %>% 
  html_nodes("table") %>% 
  html_table() %>%
  .[[1]] %>%
  setNames(c("state", "population", "total", "murder_rate"))

# inspect data and column classes
head(murders_raw)
class(murders_raw$population)
class(murders_raw$total)


s <- '10"'
cat(s)

s <- "5'"
cat(s)

s <- '5\'10"'
cat(s)

s <- "5'10\""
cat(s)


head(murders_raw)

commas <- function(x) any(str_detect(x, ","))
murders_raw %>% summarize_all(commas)

test_1 <- str_replace_all(murders_raw$population, ",", "")
test_1 <- as.numeric(test_1)
test_1

test_2 <- parse_number(murders_raw$population)
identical(test_1, test_2)

murders_new <- murders_raw %>% mutate_at(2:3, parse_number)
murders_new %>% head
murders_raw %>% head



library(dslabs)
library(tidyverse)
data("reported_heights")

class(reported_heights$height)

x <- as.numeric(reported_heights$height)
head(x)
sum(is.na(x))

reported_heights %>% mutate(new_height = as.numeric(height)) %>%
  filter(is.na(new_height)) %>%
  head(n=10)

not_inches <- function(x, smallest = 50, tallest = 84){
  inches <- suppressWarnings(as.numeric(x))
  inches
  ind <- is.na(inches) | inches < smallest | inches > tallest
  ind
}

problems <- reported_heights %>%
  filter(not_inches(height)) %>%
  .$height
length(problems)

problems

# 10 examples of x'y or x'y" or x'y\"
pattern <- "^\\d\\s*'\\s*\\d{1,2}\\.*\\d*'*\"*$"
str_subset(problems, pattern) %>% head(n=10) %>% cat
str_subset(problems, pattern) %>% length()

# 10 examples of x.y or x,y
pattern <- "^[4-6]\\s*[\\.|,]\\s*([0-9]|10|11)$"
str_subset(problems, pattern) %>% head(n=10) %>% cat
str_subset(problems, pattern) %>% length()

# 10 examples of entries in cm rather than inches
ind <- which(between(suppressWarnings(as.numeric(problems))/2.54, 54, 81))
ind <- ind[!is.na(ind)]
problems[ind] %>% head(n=10) %>% cat
problems[ind] %>% length()


str_subset(reported_heights$height, "cm")

yes <- c("180cm", "70 inches")
no <- c("180", "70''")
s <- c(yes, no)
str_detect(s, "cm") | str_detect(s, "inches")
str_detect(s, "cm|inches")


yes <- c("5", "6", "5'10", "5 feet", "4'11")
no <- c("", ".", "Five", "six")
s <- c(yes, no)
pattern <- "\\d"
str_detect(s, pattern)

str_view(s, pattern)
str_view_all(s, pattern)


str_view(s, "[56]")

yes <- as.character(4:7)
no <- as.character(1:3)
s <- c(yes, no)
str_detect(s, "[4-7]")


pattern <- "^\\d$"
yes <- c("1", "5", "9")
no <- c("12", "123", " 1", "a4", "b")
s <- c(yes, no)
str_view(s, pattern)
str_detect(s, pattern)
str_view_all(s, pattern)


pattern <- "^\\d{1,2}$"
yes <- c("1", "5", "9", "12")
no <- c("123", "a4", "b")
s <- c(yes, no)
str_view(s, pattern)
str_detect(s, pattern)
str_view_all(s, pattern)


pattern <- "^[4-7]'\\d{1,2}\""
yes <- c("5'7\"", "6'2\"", "7'12\"")
no <- c("6,2\"", "6.2\"", "I am 5'11\"", "3'2\"", "64")
str_detect(yes, pattern)
str_detect(no, pattern)

pattern <- "^[4-7]'\\d{1,2}\""
sum(str_detect(problems, pattern))
problems[c(2, 10, 11, 12, 15)] %>% str_view_all(pattern)

str_subset(problems, "inches")
str_subset(problems, "''")

# changed pattern
pattern <- "^[4-7]'\\d{1,2}$"
problems %>%
  str_replace("feet|ft|foot", "'") %>%
  str_replace("inches|in|''|\"","") %>%
  str_detect(pattern)
problems

# changed pattern #2
pattern_2 <- "^[4-7]'\\s\\d{1,2}\"$"
str_subset(problems, pattern_2)

# * means 0 or more instances of a character
yes <- c("AB", "A1B", "A11B", "A111B", "A1111B")
no <- c("A2B", "A21B")
str_detect(yes, "A1*B")
str_detect(no, "A1*B")

# test how *, ? and + differ
data.frame(string = c("AB", "A1B", "A11B", "A111B", "A1111B"),
           none_or_more = str_detect(yes, "A1*B"),
           none_or_once = str_detect(yes, "A1?B"),
           once_or_more = str_detect(yes, "A1+B"))

# changed pattern #3
pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
problems %>%
  str_replace("feet|ft|foot", "'") %>%
  str_replace("inches|in|''|\"", "") %>%
  str_detect(pattern) %>%
  sum


# pattern without groups
pattern_without_groups <- "^[4-7],\\d*$"
pattern_with_groups <- "^([4-7]),(\\d*)$"

# create examples
yes <- c("5,9", "5,11", "6,", "6,1")
no <- c("5'9", ",", "2,8", "6.1.1")
s <- c(yes, no)

# demonstrate the effect of groups
str_detect(s, pattern_without_groups)
str_detect(s, pattern_with_groups)

str_match(s, pattern_with_groups)
str_extract(s, pattern_with_groups)

pattern_with_groups <- "^([4-7]),(\\d*)$"

# create examples
yes <- c("5,9", "5,11", "6,", "6,1")
no <- c("5'9", ",", "2,8", "6.1.1")
s <- c(yes, no)

str_replace(s, pattern_with_groups, "\\1'\\2")

# final pattern
pattern_with_groups <- "^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$"
str_subset(problems, pattern_with_groups) %>% head

str_subset(problems, pattern_with_groups) %>% 
  str_replace(pattern_with_groups, "\\1'\\2") %>% head


# function to detect entries with problems
not_inches_or_cm <- function(x, smallest = 50, tallest = 84){
  inches <- suppressWarnings(as.numeric(x))
  ind <- !is.na(inches) &
    ((inches >= smallest & inches <= tallest) |
       (inches/2.54 >= smallest & inches/2.54 <= tallest))
  !ind
}

problems <- reported_heights %>%
  filter(not_inches_or_cm(height)) %>%
  .$height

length(problems)

converted <- problems %>%
  str_replace("feet|foot|ft", "'") %>% #convert feet symbols to '
  str_replace("inches|in|''|\"", "") %>% #convert inches symbols
  str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2") #change format

pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
index <- str_detect(converted, pattern)
mean(index) * 100

converted[!index]


yes <- c("5", "6", "5")
no <- c("5'", "5''", "5'4")
s <- c(yes, no)
str_replace(s, "^([4-7])$", "\\1'0")
str_replace(s, "^([56])'?$", "\\1'0")

pattern <- "^[4-7]\\s*'\\s*(\\d+\\.?\\d*)$"
index <- str_detect(converted, pattern)
mean(index) * 100

converted

yes <- c("1,7", "1, 8", "2, " )
no <- c("5,8", "5,3,2", "1.7")
s <- c(yes, no)
str_replace(s, "^([12])\\s*,\\s*(\\d*)$", "\\1\\.\\2")

inches <- suppressWarnings(as.numeric(reported_heights$height))
inches >= 50 & inches <= 84
inches/2.54 >= 50 & inches/2.54 <= 84

ind <- !is.na(inches) &
  ((inches >= 50 & inches <= 84) |
     (inches/2.54 >= 50 & inches/2.54 <= 84))
!ind

library(tidyverse)
s <- c("5'10", "6'1")
tab <- data.frame(x=s)

tab %>% separate(x, c("feet", "inches"), sep = "'")
tab %>% extract(x, c("feet", "inches"), regex = "(\\d)'(\\d{1,2})")

s <- c("5'10", "6'1\"", "5'8inches")
tab <- data.frame(x=s)

tab %>% separate(x, c("feet", "inches"), sep = "'", fill = "right")
tab %>% extract(x, c("feet", "inches"), regex = "(\\d)'(\\d{1,2})")




# Case 1
yes <- c("5", "6", "5")
no <- c("5'", "5''", "5'4")
s <- c(yes, no)
str_replace(s, "^([4-7])$", "\\1'0")


# Case 2 and 4 (use the same strings as in case 1)
str_replace(s, "^([56])'?$", "\\1'0")


# Case 3
pattern <- "^[4-7]\\s*'\\s*(\\d+\\.?\\d*)$"
str_replace("5'7.5", pattern, "\\1'0")
str_detect("5'7.5", pattern)
str_view("5'7.5", pattern)


# Case 5
yes <- c("1,7", "1, 8", "2, " )
no <- c("5,8", "5,3,2", "1.7")
s <- c(yes, no)
str_replace(s, "^([12])\\s*,\\s*(\\d*)$", "\\1\\.\\2")



# Trimming
s <- "Hi "
cat(s)
identical(s, "Hi")
str_trim("5 ' 9 ")


# To upper and lower case
s <- c("Five feet eight inches")
str_to_lower(s)


# Putting it into a function
convert_format <- function(s){
  s %>%
    str_replace("feet|foot|ft", "'") %>%
    str_replace_all("inches|in|''|\"|cm|and", "") %>%
    str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2") %>%
    str_replace("^([56])'?$", "\\1'0") %>%
    str_replace("^([12])\\s*,\\s*(\\d*)$", "\\1\\.\\2") %>%
    str_trim()
}

words_to_numbers <- function(s){
  str_to_lower(s) %>%
    str_replace_all("zero", "0") %>%
    str_replace_all("one", "1") %>%
    str_replace_all("two", "2") %>%
    str_replace_all("three", "3") %>%
    str_replace_all("four", "4") %>%
    str_replace_all("five", "5") %>%
    str_replace_all("six", "6") %>%
    str_replace_all("seven", "7") %>%
    str_replace_all("eight", "8") %>%
    str_replace_all("nine", "9") %>%
    str_replace_all("ten", "10") %>%
    str_replace_all("eleven", "11")
}

converted <- problems %>% words_to_numbers %>% convert_format
remaining_problems <- converted[not_inches_or_cm(converted)]
pattern <- "^[4-7]\\s*'\\s*\\d+\\.?\\d*$"
index <- str_detect(remaining_problems, pattern)
remaining_problems[!index]


filename <- system.file("extdata/murders.csv", package = "dslabs")
lines <- readLines(filename)
lines %>% head

x <- str_split(lines, ",")
x %>% head
col_names <- x[[1]]
x <- x[-1]

library(purrr)
map(x, function(y) y[1]) %>% head
map(x, 1) %>% head

dat <- data.frame(map_chr(x, 1),
                  map_chr(x, 2),
                  map_chr(x, 3),
                  map_chr(x, 4),
                  map_chr(x, 5)) %>%
  mutate_all(parse_guess) %>%
  setNames(col_names)
dat %>% head

dat <- x %>%
  transpose() %>%
  map( ~ parse_guess(unlist(.))) %>%
  setNames(col_names) %>%
  as.data.frame()
dat %>% head


x <- str_split(lines, ",", simplify = TRUE)
col_names <- x[1,]
x <- x[-1,]
x %>% as_tibble() %>%
  setNames(col_names) %>%
  mutate_all(parse_guess)

x %>% head


# Recoding
library(dslabs)
data("gapminder")

gapminder %>% 
  filter(region=="Caribbean") %>%
  ggplot(aes(year, life_expectancy, color = country)) +
  geom_line()

# display long country names
gapminder %>% 
  filter(region=="Caribbean") %>%
  filter(str_length(country) >= 12) %>%
  distinct(country) 

# recode long country names and remake plot
gapminder %>% filter(region=="Caribbean") %>%
  mutate(country = recode(country, 
                          'Antigua and Barbuda'="Barbuda",
                          'Dominican Republic' = "DR",
                          'St. Vincent and the Grenadines' = "St. Vincent",
                          'Trinidad and Tobago' = "Trinidad")) %>%
  ggplot(aes(year, life_expectancy, color = country)) +
  geom_line()
