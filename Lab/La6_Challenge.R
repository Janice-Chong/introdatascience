library(dplyr)

mydata <- read.csv("C:/Users/Janice/Documents/R/introdatascience/Lab/incomeData.csv")
sample_n(mydata,3)
sample_frac(mydata,0.1)
#elimate duplication row
x1 = distinct(mydata)
x1
#Example 4 : Remove Duplicate Rows based on a variable
x2 = distinct(mydata, Index, .keep_all= TRUE)
x2
x2 = distinct(mydata, Index, Y2010, .keep_all= TRUE)
x2
mydata2 = select(mydata, Index, State:Y2008)
mydata2
mydata = select(mydata, -Index, -State)
mydata
mydata = select(mydata, -c(Index,State))
mydata3 = select(mydata, starts_with("Y"))
mydata3
mydata33 = select(mydata, -starts_with("Y"))
mydata33
mydata4 = select(mydata, contains("I"))
mydata4
mydata5 = select(mydata, State, everything())
mydata5
mydata6 = rename(mydata, Index1=Index)
mydata6
mydata7 = filter(mydata, Index == "A")
mydata7
mydata7 = filter(mydata6, Index1 %in% c("A", "C"))
mydata7
