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
