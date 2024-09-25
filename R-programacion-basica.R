

# R Base

## Objetos

a <- 1
b <- 1
c <- -1
a
print(a)


## El espacio de trabajo

ls()


## Funciones

log(8)
log(a)
help("log")
?log
args(log)
log(8, base = 2)
log(x = 8, base = 2)
log(8,2)
log(base = 2, x = 8)
2^3
help("+")
?"+"
help(">")
?">"


## Objetos predefinidos

data()
pi
Inf+1


## Nombres de variables

solution_1 <- (-b + sqrt(b^2 - 4*a*c))/ (2*a)
solution_1
solution_2 <- (-b - sqrt(b^2 - 4*a*c))/ (2*a)
solution_2


## Scripts

## Código para calcular la solución a la
## ecuación cuadrática de la forma ax^2 + bx + c
## definir las variables
a <- 3
b <- 2
c <- -1

## ahora calcule la solución
(-b + sqrt(b^2 - 4*a*c)) / (2*a)



# Tipos de Datos

## Clases

a <- 2
class(a)


## Data frames

library(dslabs)
data(murders)
class(murders)
str(murders)
head(murders)


## El operador de acceso: $

murders$population
names(murders)

pop <- murders$population
length(pop)
class(pop)
class(murders$state)
z <- 3 == 2
z
class(z)
?Comparison


## Factores

class(murders$region)
levels(murders$region)
region <- murders$region
value <- murders$total
region <- reorder(region, value, FUN = sum)
levels(region)


## Listas

record <- list(name = "Juan Perez",
               student_id = 1234,
               grades = c(95, 82, 91, 97, 93),
               final_grade = "A")
record
class(record)
record$student_id
record[["student_id"]]
record2 <- list("Juan Perez", 1234)
record2
record2[[1]]


## Matrices

mat <- matrix(1:12, 4, 3)
mat
mat[2, 3]
mat[2, ]
mat[, 3]
mat[, 2:3]
mat[1:2, 2:3]
as.data.frame(mat)
data("murders")
murders[25, 1]
murders[2:3, ]


## Vectores

codes <- c(380, 124, 818)
codes
country <- c("italy", "canada", "egypt")
country <- c('italy', 'canada', 'egypt')
country
codes <- c(italy = 380, canada = 124, egypt = 818)
codes
class(codes)
names(codes)
codes <- c("italy" = 380, "canada" = 124, "egypt" = 818)
codes
codes <- c(380, 124, 818)
country <- c("italy","canada","egypt")
names(codes) <- country
codes


## Secuencias

seq(1, 10)
seq(1, 10, 2)
1:10
class(1:10)
class(seq(1, 10, 0.5))


## Subconjuntos

codes[2]
codes[c(1,3)]
codes[1:2]
codes["canada"]
codes[c("egypt","italy")]


## Conversión forzada

x <- c(1, "canada", 3)
x
class(x)
x <- c(1, "canada", 3)
x <- 1:5
y <- as.character(x)
y
as.numeric(y)


## Not available (NA)

x <- c("1", "b", "3")
as.numeric(x)



# Ordenamientos

## sort

library(dslabs)
data(murders)
sort(murders$total)


## order

x <- c(31, 4, 15, 92, 65)
sort(x)
index <- order(x)
x[index]
x
order(x)
murders$state[1:6]
murders$abb[1:6]
ind <- order(murders$total)
murders$abb[ind]


## max y which.max

max(murders$total)
i_max <- which.max(murders$total)
murders$state[i_max]


## rank

x <- c(31, 4, 15, 92, 65)
rank(x)


## reciclaje

x <- c(1, 2, 3)
y <- c(10, 20, 30, 40, 50, 60, 70)
x+y



# Aritmética de vectores


library(dslabs)
data("murders")
murders$state[which.max(murders$population)]


## Re-escalar un vector

inches <- c(69, 62, 66, 70, 70, 73, 67, 73, 67, 70)
inches * 2.54
inches - 69


## Dos vectores

murder_rate <- murders$total/ murders$population * 100000
murders$abb[order(murder_rate)]



# Indexación

library(dslabs)
data("murders")


## Cómo crear subconjuntos con lógicos

murder_rate <- murders$total/ murders$population * 100000
ind <- murder_rate < 0.71
ind <- murder_rate <= 0.71
murders$state[ind]
sum(ind)


## operadores lógicos

TRUE & TRUE
TRUE & FALSE
FALSE & FALSE
west <- murders$region == "West"
safe <- murder_rate <= 1
ind <- safe & west
murders$state[ind]


## which

ind <- which(murders$state == "California")
murder_rate[ind]


## match

ind <- match(c("New York", "Florida", "Texas"), murders$state)
ind
murder_rate[ind]


## %in%

c("Boston", "Dakota", "Washington") %in% murders$state
match(c("New York", "Florida", "Texas"), murders$state)
which(murders$state%in%c("New York", "Florida", "Texas"))



# Gráficos básicos

## plot

x <- murders$population/ 10^6
y <- murders$total
plot(x, y)
with(murders, plot(population, total))


## hist

x <- with(murders, total/ population * 100000)
hist(x)
murders$state[which.max(x)]


## boxplot

murders$rate <- with(murders, total/ population * 100000)
boxplot(rate~region, data = murders)


## image

x <- matrix(1:120, 12, 10)
image(x)



#  Conceptos básicos de programación

## Expresiones condicionales

a <- 1

if(a!=0){
  print(1/a)
} else{
  print("No existe inverso multiplicativo para 0")
}

library(dslabs)
data(murders)
murder_rate <- murders$total/ murders$population*100000

ind <- which.min(murder_rate)

if(murder_rate[ind] < 0.5){
  print(murders$state[ind])
} else{
  print("Ningún estado tiene una tasa de homicidios tan baja.")
}

if(murder_rate[ind] < 0.25){
  print(murders$state[ind])
} else{
  print("Ningún estado tiene una tasa de homicidios tan baja.")
}

a <- 0
ifelse(a > 0, 1/a, NA)

a <- c(0, 1, 2, -4, 5)
result <- ifelse(a > 0, 1/a, NA)

data(na_example)
no_nas <- ifelse(is.na(na_example), 0, na_example)
sum(is.na(no_nas))

z <- c(TRUE, TRUE, FALSE)
any(z)
all(z)



## Cómo definir funciones

avg <- function(x){
  s <- sum(x)
  n <- length(x)
  s/n
}

x <- 1:100
identical(mean(x), avg(x))

s <- 3
avg(1:10)
s

avg <- function(x, arithmetic = TRUE){
  n <- length(x)
  ifelse(arithmetic, sum(x)/n, prod(x)^(1/n))
}



## Namespaces

search()
stats::filter
dplyr::filter



## Ciclos - for

compute_s_n <- function(n){
  x <- 1:n
  sum(x)
}

for(i in 1:5){
  print(i)
}

m <- 25
s_n <- vector(length = m) # crea un vector vacío
for(n in 1:m){
  s_n[n] <- compute_s_n(n)
}

n <- 1:m
plot(n, s_n)



## Vectorización y funcionales

x <- 1:10
sqrt(x)

y <- 1:10
x*y

n <- 1:25
compute_s_n(n)

x <- 1:10
sapply(x, sqrt)

n <- 1:25
s_n <- sapply(n, compute_s_n)
s_n

