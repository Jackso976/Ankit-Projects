7/4
library(tidyverse)

7+4
7*4
vec1 <- c(3, 7, 13, 21)
vec2 <- c(5, 5, 6, 6)
vec1 + vec2

vec1[3]
vec1[2:4]
vec1[c(2,4)]

vec3 <- seq(1, 10)
help(seq)
vec4 <- seq(from=1, to=15, by=0.25)


mat1 <- matrix(data = c(9, 2, 3, 4, 5, 6),
               nrow = 2)

mat2 <- matrix(data = c(9, 2, 3, 4, 5, 6),
               nrow = 2, byrow = TRUE)

mat3 <- matrix(data = c(9, 2, 3, 4, 5, 6),
               nrow = 4, byrow = TRUE)

mat3[3,2]

# Data Frames

df = data.frame(name = c("Pete", "Mary","Joe"),
                age = c(23, 34, 65),
                salary = c(34000, 56765, 32453))

df

df$name

mean(df$salary)

#Lists

mylist <- list(one=1, three=c(1,2),
               seven=seq(0, 1, length=5))

mylist$three
mylist[[3]]
mylist[[3]][4]
mylist[[3]][2:4]


rnorm(10)
runif(8, 1, 10)
round(runif(8, 1, 10))
round(runif(8, 1, 10), 2)


#Exercise 1.1
#a) Put the numbers 31 to 60 in a vector named P and in a matrix with 6 rows and 5 columns named Q.

P <- seq(31, 60)
Q <- matrix(data = P, nrow = 6)


#b) Create a matrix Qt where you fill first the first row, then the second, and so on.

Qt <- matrix(data = P, nrow = 6, byrow = TRUE)
#Exercise 1.2
#a) Construct three random normal vectors of length 100. Call these vectors x1, x2 and x3.

x1 <- rnorm(100)
x2 <- rnorm(100)
x3 <- rnorm(100)

#b) Make a data frame called t with three columns (called a, b and c) containing respectively x1, x1+x2 and x1+x2+x3.

t = data.frame( a= x1, b= x1+x2, c=x1+x2+x3)
#c) Call the following functions for this data frame: plot(t) and sd(t). Can you understand the results? (Shoment strt comarting with # is welcome.)

plot(t)

#sdt <- sd(t)
#d) Modify sd(t) to get the expected results about the three variables in data frame t.

coulmn_sd <- apply(t, 2, sd)

#Exercise 1.3
#Create a vector using a sequence going from 21 to 120. Give it the name “a”.

a <- seq(21, 120)

#Define b as the length of a.

b <- length(a)
#Define d the 5th element of the vector a.

d <- a[5]
#Define f the vector containing the elements from the 2nd until the 6th.

f <- a[2:6]

#Define g the vector containing the 1st , 3rd and 7th elements of a.

g <- a[c(1, 3, 7)]

#Create a vector, call it h, containing the sequence of values of “a” from 1 until 100 every 4 observations.


Define i the vector containing the elements bigger than 24 and smaller than 29.
Create a matrix (give it the name l) with 25 rows and 4 columns containing the element of the vector a.
Define m the vector containing the elements of the second column of l.
Define n the vector containing the elements of the third row of l.
Define o the vector containing the elements included from row 6 until row 12 and from column 2 until
column 3 of l.