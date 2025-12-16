## Tidy Data

**tidy data:** each row represents one observation and the columns represents the different variables that we have data on for those observations.

## Wide Data

**wide data:** each row includes several observations and one of the variables is stored in the header.

## pivot_longer(1st, 2nd)

**pivot_longer(1st, 2nd):** -- converts wide data into tidy data.

-   1st (first argument) is the data frame to be reshaped.
-   2nd (second argument) specifies the columns containing the values to be moved into a single column.

## pivot_wider(1st)

**pivot_wider(1st):** -- converts tidy data into wide data. Can be a useful intermediate step in data tidying.

-   1st (first argument) is the data frame to be reshaped.
-   `names_from` tells which variable will be used for the column names
-   `values_from` tells which variable to use to fill in the values.

![](images/reshape_data.png)

## Separate(1st, 2nd, 3th)

**separate(1st, 2nd, 3th)** — splits one column into two or more columns at a specified character that separates the variables.

-   1st - the name of the column to be separated.

-   2nd - the names to be used for the new columns.

-   3th - character that separates the variables.

If there is an extra separation, we can use `extra = "merge"` to merge the last two variables.

## Unite()

**unite(1st, 2nd, 3rd, 4th)** — joins to columns into one.

-   1st - is the name of the new column.

-   2nd - is the name of the first part of the new column.

-   3rd - is the name of the second part of the new column.

-   4th - is the separator to use between values.

## Combining Tables

The `join` functions in the **dplyr** package combine two tables such that matching rows are together.

-   `left_join()` - only keeps rows that have information in the first table.
-   `right_join()` - only keeps rows that have information in the second table.
-   `inner_join()` - only keep rows that have information in the both tables.
-   `full_join()` - keeps all rows from both tables.
-   `semi_join()` - keeps the part of the first tables for which we have information in the second.
-   `anti_join()` - keeps the elements of the first table for which we there is no information in the second.

![](images/joins.png)

### Binding

Unlike the join functions, the binding functions do not try to match by a variable, but rather just combine datasets.

-   `bind_cols()` - binds two objects by making them columns in a tibble.

    -   The R-base function `cbind()` bind columns but makes a data frame or matrix instead.

-   `bind_rows()` - function is similar but binds rows instead of a columns.

    -   The R-base function `rbind()` binds rows but makes a data frame or matrix instead.

### Set Operators

By default, the set operators in R-base work on vectors. If **tidyverse/dplyr** are loaded, they also work on data frames.

-   `intersect()` - take intersections of vectors. This returns the elements common to both sets.

-   `union()` - take union of vectors. This return the elements that are in either set.

-   `setdiff()` - set difference between a first and second argument.

    -   this function is not symmetric.

-   `set_equal()` - tells if two sets are the same, regardless of the order of elements.

## Web Scraping

**Web scraping** or **web harvesting** — are the term used to describe the process of extracting data from a website.

The `rvest` web harvesting package includes functions to extract nodes of an HTML document:

-   `html_nodes()` — extracts all nodes of different types

-   `html_node()` — extracts the first node.

The `html_table()` — converts an HTML table to a data frame.
