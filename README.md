## What
`usestata()` is a R function to read **Stata Manual's datasets** into R. 

The R **haven** package is used to achieve this goal.



## Usage

For users transitioning from Stata to R, it's natural to want to use the [datasets](https://www.stata-press.com/data/r18/) provided by Stata for practice. After all, we are quite familiar with data like **auto.dta** and **nlsw88.dta**.

To help with this, I've created a simple R function: `usestata()`, which allows you to quickly import example datasets available on Stata’s official website into R.

```r
usestata("auto")
```

This is equivalent to the following commands:

```r
library("haven")

data_url <- "https://www.stata-press.com/data/r18/auto.dta" # URL of 'auto.dta'
auto <- read_stata(data_url) # Download and read 'auto.dta' into R
```

### How to use the `usestata()` function?

1. Method 1: Add the following code to define the `usestata()` function in your **.Rprofile**;
2. Method 2: Add the following code at the bottom of your **.R** script or **.rmd** document and run it before using the function.

### What datasets can be imported?

All datasets listed under [Datasets for Stata 18 manuals](https://www.stata-press.com/data/r18/) can be imported into R using `usestata()`.

For instance, if you want to use the dataset [abdata.dta](https://www.stata-press.com/data/r18/xt.html) from the Stata manual that demonstrates dynamic panel estimation methods, and practice with R’s [fixest](https://lrberge.github.io/fixest/articles/fixest_walkthrough.html) package, you can import the **abdata.dta** dataset using the following command:

```r
# read as a data frame 'abdata'
usestata("abdata")
head(abdata)

# or, rename the data frame to 'df'
df <- usestata("abdata") |> head()
```

