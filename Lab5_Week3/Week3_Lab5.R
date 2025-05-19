#' ---
#' title: "Lab 5 Data Visualization Lab"
#' author: "Griffin Norwood"
#' date: "April 15, 2025"
#' ---

#Week 3 Data Visualization Lab

#Install the package ggplot2
#install.packages("ggplot2")

#Anytime I want to use this package I need to load it 
library(ggplot2)

View(cars)

#A quick base R plot - this is not ggplot
plot(cars)

#Our first ggplot
#we need data + aes + geoms
ggplot(data=cars)+aes(x=speed, y=dist) + geom_point()

p <- ggplot(data=cars)+aes(x=speed, y=dist) + geom_point()

#Add a line geom with geom_line()
p + geom_line()

#Add a trend line close to the data
p + geom_smooth()

p + geom_smooth(method = "lm")

#-----------------------------------------------------#

#Read in our drug expression data
url <- "https://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
genes <- read.delim(url)
head(genes)

#Q. How many genes are in the data set?
nrow(genes)

#Q.How many upregulated genes?
table(genes$State)

#Q.What fraction of total genes is up-regulated?
(table(genes$State)/nrow(genes))*100

#First Plot Attempt
q <- ggplot(data = genes) + aes(x=Condition1, y=Condition2)+geom_point()

#Add some color
g <-ggplot(data = genes) + aes(x=Condition1, y=Condition2, col=State)+geom_point()
g + scale_color_manual(values=c("blue", "gray", "red"))+labs(title="Gene Expression Changes", x="Control (No Drugs)", y=" With Drugs")+theme_bw()
  
#"Going Further"
#install.packages("gapminder")
library(gapminder)
#install.packages("dplyr")
library(dplyr)
gapminder_2007 <- gapminder %>% filter(year==2007)

#GGplot of mpaminder
ggplot(gapminder_2007) + aes(x=gdpPercap, y=lifeExp) + geom_point()

#With the alpha point 
ggplot(gapminder_2007) + aes(x=gdpPercap, y=lifeExp) + geom_point(alpha=0.5)

#Adding more variables to aes()
ggplot(gapminder_2007) + aes(x=gdpPercap, y=lifeExp, color=continent, size=pop) + geom_point()

#Contrast Graph 
ggplot(gapminder_2007) + aes(x=gdpPercap, y=lifeExp, color=pop) + geom_point()

#Adjusting Point Size
ggplot(gapminder_2007) + aes(x=gdpPercap, y=lifeExp, size=pop) + geom_point() + scale_size_area(max_size=10)

#1957
gapminder_1957 <- gapminder %>% filter(year==1957)

ggplot(gapminder_1957) + aes(x = gdpPercap, y = lifeExp, color=continent, size = pop) + geom_point(alpha=0.7) + scale_size_area(max_size = 10) 

#BOTH 1957 and 2007
gapminder_1957 <- gapminder %>% filter(year==1957 | year==2007)

ggplot(gapminder_1957) + geom_point(aes(x = gdpPercap, y = lifeExp, color=continent, size = pop), alpha=0.7) + scale_size_area(max_size = 10) + facet_wrap(~year)

#Extensions: Anitmation 
#install.packages("gifski")
#install.packages("gganimate")
library(gapminder)
library(gganimate)

#Animation portion
#this is actually so cool to fiddle with, but I keep breaking the code, hA!)
ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  # Facet by continent
  facet_wrap(~continent) +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  shadow_wake(wake_length = 0.1, alpha = FALSE)

#Combining plots Example!
#install.packages("patchwork")
library(patchwork)

# Setup some example plots 
p1 <- ggplot(mtcars) + geom_point(aes(mpg, disp))
p2 <- ggplot(mtcars) + geom_boxplot(aes(gear, disp, group = gear))
p3 <- ggplot(mtcars) + geom_smooth(aes(disp, qsec))
p4 <- ggplot(mtcars) + geom_bar(aes(carb))

# Use patchwork to combine them here:
(p1 | p2 | p3) /
  p4