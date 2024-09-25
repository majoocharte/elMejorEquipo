

## Packages
#install.packages("tidyverse")


## Libraries

library(dplyr)
library(ggplot2)
library(ggthemes)
library(ggrepel)
library(dslabs)


# Objetos ggplot

data(murders)
head(murders)

# Se crea un objeto ggplot y se despliega un fondo gris
# (falta definir la geometría)
ggplot(data = murders)

# Usando un pipe
murders |> ggplot()

# Asignando a un objeto (no se despliega hasta imprimirlo con print o directo)
p <- ggplot(data = murders)
class(p)
print(p)
p


# Geometrías y mapeos estéticos

# Agregando la capa de geometría y mapeo estético
murders |> ggplot() +
  geom_point(aes(x = population/10^6, y = total))

# Agregando la capa de geometría y mapeo estético a un objeto ggplot)
p + geom_point(aes(population/10^6, total))

# Disposición clásica de un gráfico en ggplot2
ggplot(murders, aes(x = population/10^6, y = total)) +
  geom_point()


# Capas

# Agregando una etiqueta a cada punto para identificar el estado
p + geom_point(aes(population/10^6, total)) +
  geom_text(aes(population/10^6, total, label = abb))

# Equivalente al anterior
p_test <- p + geom_text(aes(population/10^6, total, label = abb))

# ERROR: debe estar label dentro de aes()
# p_test <- p + geom_text(aes(population/10^6, total), label = abb)


## Cómo probar varios argumentos

# Cambiar el tamaño de la etiqueta con size
p +
  geom_point(aes(population/10^6, total), size = 3) +
  geom_text(aes(population/10^6, total, label = abb))

# Mover la etiqueta con nudge_x
p +
  geom_point(aes(population/10^6, total), size = 3) +
  geom_text(aes(population/10^6, total, label = abb), nudge_x = 1.5)


# Mapeos estéticos globales versus locales

# Argumentos del objeto ggplot
args(ggplot)

# Se asigna el mapeo estético al objeto de manera global
p <- murders |> ggplot(aes(population/10^6, total, label = abb))
p +
  geom_point(size = 3) +
  geom_text(nudge_x = 1.5)

# Se anula el mapeo global definiendo un nuevo mapeo dentro de cada capa
p +
  geom_point(size = 3) +
  geom_text(aes(x = 10, y = 800, label = "!Hola¡"))


# Escalas

# Cambiar las escalas con scale_x_continuous
p + geom_point(size = 3) +
  geom_text(nudge_x = 0.05) +
  scale_x_continuous(trans = "log10") +
  scale_y_continuous(trans = "log10")

# Cambiar las escalas scale_x_log10
p + geom_point(size = 3) +
  geom_text(nudge_x = 0.05) +
  scale_x_log10() +
  scale_y_log10()


# Etiquetas y títulos

# Cambiar las etiquetas con xlab y el título con ggtitle
p +
  geom_point(size = 3) +
  geom_text(nudge_x = 0.05) +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Población en millones (escala log)") +
  ylab("Número total de asesinatos (escala log)") +
  ggtitle("Asesinatos en el año 2010 en USA con arma de fuego")


# Categorías como colores

p <- murders |> ggplot(aes(population/10^6, total, label = abb)) +
  geom_text(nudge_x = 0.05) +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Población en millones (escala log)") +
  ylab("Número total de asesinatos (escala log)") +
  ggtitle("Asesinatos en el año 2010 en USA con arma de fuego")

# Cambiar color de los puntos a azul
p + geom_point(size = 3, color ="blue")

# Cambiar color con la variable categórica region
p + geom_point(aes(col=region), size = 3)


# Anotación, formas y ajustes

# Añadir una línea que represente la tasa promedio de asesinatos en todo el país
r <- murders |>
  summarize(rate = sum(total)/ sum(population) * 10^6) |>
  pull(rate)

p + geom_point(aes(col=region), size = 3) +
  geom_abline(intercept = log10(r))

p <- p + geom_abline(intercept = log10(r), lty = 2, color = "darkgrey") +
  geom_point(aes(col=region), size = 3)

p <- p + scale_color_discrete(name = "Region")


# Paquetes complementarios

# Se establece un tema por defecto usando una función del paquete dslabs
ds_theme_set()

# Se aplica el tema economist
p + theme_economist()

# Se aplica el tema fivethirtyeight
p + theme_fivethirtyeight()


# Combinarlo todo

r <- murders |>
  summarize(rate = sum(total)/ sum(population) * 10^6) |>
  pull(rate)

murders |> ggplot(aes(population/10^6, total, label = abb)) +
  geom_abline(intercept = log10(r), lty = 2, color = "darkgrey") +
  geom_point(aes(col=region), size = 3) +
  geom_text_repel() +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Población en millones (escala log)") +
  ylab("Número total de asesinatos (escala log)") +
  ggtitle("Asesinatos en el año 2010 en USA con arma de fuego") +
  scale_color_discrete(name = "Region") +
  theme_solarized_2()


# Gráficos rápidos con qplot

data(murders)
x <- log10(murders$population)
y <- murders$total

data.frame(x = x, y = y) |>
  ggplot(aes(x, y)) +
  geom_point()

qplot(x, y)


# Cuadrículas de gráficos

library(gridExtra)
p1 <- qplot(x)
p2 <- qplot(x,y)
grid.arrange(p1, p2, ncol = 2)

