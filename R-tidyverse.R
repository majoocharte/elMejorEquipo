

library(tidyverse)

### Datos tidy


### Cómo manipular los data frames

## Cómo añadir una columna con mutate
library(dslabs)
data("murders")
murders <- mutate(murders, rate = total / population * 100000)
head(murders)

## Cómo crear subconjuntos con filter
filter(murders, rate <= 0.71)

## Cómo seleccionar columnas con select
new_table <- select(murders, state, region, rate)
filter(new_table, rate <= 0.71)

## El pipe: |> o %>%
murders |> select(state, region, rate) |> filter(rate <= 0.71)

16 |> sqrt()
16 |> sqrt() |> log2()
16 |> sqrt() |> log(base = 2)


### Cómo resumir datos

## summarize
library(dplyr)
library(dslabs)
data(heights)

s <- heights |>
  filter(sex == "Female") |>
  summarize(average = mean(height), standard_deviation = sd(height))
s
s$average
s$standard_deviation

murders <- murders |> mutate(rate = total/population*100000)
summarize(murders, mean(rate))
us_murder_rate <- murders |>
  summarize(rate = sum(total)/ sum(population) * 100000)
us_murder_rate

## Resúmenes múltiples
heights |>
  filter(sex == "Female") |>
  summarize(median_min_max = quantile(height, c(0.5, 0, 1)))

median_min_max <- function(x){
  qs <- quantile(x, c(0.5, 0, 1))
  data.frame(median = qs[1], minimum = qs[2], maximum = qs[3])
}
heights |>
  filter(sex == "Female") |>
  summarize(median_min_max(height))

## Cómo agrupar y luego resumir con group_by
heights |> group_by(sex)
heights |>
  group_by(sex) |>
  summarize(average = mean(height), standard_deviation = sd(height))

murders |>
  group_by(region) |>
  summarize(median_min_max(rate))

## pull
class(us_murder_rate)
us_murder_rate |> pull(rate)

us_murder_rate <- murders |>
  summarize(rate = sum(total)/ sum(population) * 100000) |>
  pull(rate)

us_murder_rate
class(us_murder_rate)

## Cómo ordenar los data frames
murders |>
  arrange(population) |>
  head()
murders |>
  arrange(rate) |>
  head()
murders |>
  arrange(desc(rate))

## Cómo ordenar anidadamente
murders |>
  arrange(region, rate) |>
  head()

## Los primeros
murders |> top_n(5, rate)


### Tibbles
murders |> group_by(region)
murders |> group_by(region) |> class()

## Los tibbles se ven mejor
as_tibble(murders)

## Los subconjuntos de tibbles son tibbles
class(murders[,4])
class(as_tibble(murders)[,4])
class(as_tibble(murders)$population)
murders$Population
as_tibble(murders)$Population

## Los tibbles pueden tener entradas complejas
tibble(id = c(1, 2, 3), func = c(mean, median, sd))

## Los tibbles se pueden agrupar: group_by()

## Cómo crear un tibble usando tibble en lugar de data.frame
grades <- tibble(names = c("John", "Juan", "Jean", "Yao"),
                 exam_1 = c(95, 80, 90, 85),
                 exam_2 = c(90, 85, 85, 90))
grades <- data.frame(names = c("John", "Juan", "Jean", "Yao"),
                     exam_1 = c(95, 80, 90, 85),
                     exam_2 = c(90, 85, 85, 90))
as_tibble(grades) |> class()


## El marcador de posición (palceholder)
log(8, base = 2)
2 |> log(8, base = _)
2 %>% log(8, base = .)

## el paquete purrr
compute_s_n <- function(n){
  x <- 1:n
  sum(x)
}
n <- 1:25
s_n <- sapply(n, compute_s_n)

library(purrr)
s_n <- map(n, compute_s_n)
class(s_n)

s_n <- map_df(n, compute_s_n)
compute_s_n <- function(n){
  x <- 1:n
  tibble(sum = sum(x))
}
s_n <- map_df(n, compute_s_n)


### Los condicionales de tidyverse

## case_when
x <- c(-2, -1, 0, 1, 2)
case_when(x < 0 ~ "Negative",
          x > 0 ~ "Positive",
          TRUE ~ "Zero")

murders |>
  mutate(group = case_when(
    abb %in% c("ME", "NH", "VT", "MA", "RI", "CT") ~ "New England",
    abb %in% c("WA", "OR", "CA") ~ "West Coast",
    region == "South" ~ "South",
    TRUE ~ "Other")) |>
  group_by(group) |>
  summarize(rate = sum(total)/ sum(population) * 10^5)

# between
x >= a & x <= b
between(x, a, b)
