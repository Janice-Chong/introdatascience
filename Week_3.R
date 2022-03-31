#Week3

x <- 357
y <- 80L
z <- "fifty eight"

class(x)
class(y)
class(z)

x

x <- as.integer(x)
class(x)

A <- 20
B <- 3
A-B
A+B
A/B
A*B
A^B
A%%B

MarksTut1 <- c(15, 17, 10, 8, 19)
MarksTut2 <- c(5, 4, 3, 5, 4)
TutMarks <- MarksTut1 + MarksTut2
names(MarksTut1) <- c("Ali", "Ken", "Ahmad", "Bala", "Chong")
names(MarksTut2) <- c("Ali", "Ken", "Ahmad", "Bala", "Chong")
MarksTut1
MarksTut2

TotalMarks <- MarksTut1 + MarksTut2
TotalMarks
ahmad <- TotalMarks["Ahmad"]
ahmad
percentage <- TotalMarks/25*100
percentage

df <- data.frame(Percentage = paste(percentage, "%", sep=""))
df

per = paste(percentage, "%", sep="")
names(per) = c("Ali", "Ken", "Ahmad", "Bala", "Chong")
df = data.frame(Percentage = per)
df

library(scales)
Mark1 <- c(15, 17, 10, 8, 19)
Mark2 <- c(5, 4, 3, 5, 4)
Tot <- Mark1 + Mark2
names(Tot) <- c("Ali", "Ken", "Ahmad", "Bala", "Chong")
perc <- Tot/25 #no need *100
library = percent(perc)
library


x <- c(1, 3, 5)
y <- c(3, 2, 10)
cbind(x, y)
rbind(x, y)