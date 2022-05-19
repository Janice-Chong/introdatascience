install.packages("plotrix")
library(plotrix)
number <- c(10, 35, 18, 8, 3)
lecturer <- c("Professors", "Associate Professor",
               "Senior Lecturers", "Lecturers", "Tutors")

fan.plot(number, labels = paste(lecturer, number, sep = "-"), main = "Fan Plot: Number of Lecturer")
