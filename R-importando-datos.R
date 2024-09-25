
library(tidyverse)

### Las rutas y el directorio de trabajo

filename <- "murders.csv"
# dir <- system.file("extdata", package = "dslabs")
# fullpath <- file.path(dir, filename)
# file.copy(fullpath, "murders.csv")

dat <- read_csv(filename)

## El sistema de archivos

## Las rutas relativas y completas
system.file(package = "dslabs")

dir <- system.file(package = "dslabs")
list.files(path = dir)

## El directorio de trabajo
wd <- getwd()

## Cómo generar los nombres de ruta
dir <- system.file(package = "dslabs")
filename %in% list.files(file.path(dir, "extdata"))
dir <- system.file("extdata", package = "dslabs")
fullpath <- file.path(dir, filename)

## Cómo copiar los archivos usando rutas
file.copy(fullpath, "murders.csv")
list.files()


### Los paquetes readr y readxl

filename <- "murders.csv"
dir <- system.file("extdata", package = "dslabs")
fullpath <- file.path(dir, filename)
file.copy(fullpath, "murders.csv")

## readr
library(readr)
read_lines("murders.csv", n_max = 3)
dat <- read_csv(filename)
View(dat)
dat <- read_csv(fullpath)

## readxl
library(readxl)


### Cómo descargar archivos

url <- "https://raw.githubusercontent.com/rafalab/dslabs/master/inst/extdata/murders.csv"
dat <- read_csv(url)
download.file(url, "murders.csv")

tmp_filename <- tempfile()
download.file(url, tmp_filename)
dat <- read_csv(tmp_filename)
file.remove(tmp_filename)


### Las funciones de importación de base R

dat2 <- read.csv(filename)

## scan
path <- system.file("extdata", package = "dslabs")
filename <- "murders.csv"
x <- scan(file.path(path, filename), sep=",", what = "c")
x[1:10]

## Archivos de texto versus archivos binarios

## Unicode versus ASCII

## Cómo organizar datos con hojas de cálculo



