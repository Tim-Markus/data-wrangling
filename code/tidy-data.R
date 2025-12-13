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







