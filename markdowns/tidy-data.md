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
