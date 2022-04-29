# Lab 7


# ----------------------------------------------------------------------------------
# Q1 - Have total emissions from PM2.5 decreased in the United States from 1999 to 
# 2008? Using the base plotting system, make a plot showing the total PM2.5 emission # from all sources for each of the years 1999, 2002, 2005, and 2008.
# ----------------------------------------------------------------------------------

## R Script Title - Plot 1 

## Libraries needed: no special libraries needed.

# Reading the data
NEI <- readRDS("Data/summarySCC_PM25.rds")  # PM2.5 Emissions Data
SCC <- readRDS("Data/Source_Classification_Code.rds") # Source Classification Code

totalNEI<-tapply(NEI$Emissions, INDEX=NEI$year, sum)  # Sum of emissions per year

# Bar Plot 
png(filename="Plot1.png", width=480, height=480)
barplot(totalNEI, main = "Total Emissions From All Sources in US", xlab="Year", ylab=expression("Total" ~ PM[2.5] ~"Emissions (tons)"),col=rainbow(4))
dev.off()

# Conclusion (Answer to Q1) - Total emissions from PM2.5 have decreased in the 
# United States from 1999 to 2008

# ---------------------------------------------------------------------------------
# Q2 - Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot 
# answering this question.
# ---------------------------------------------------------------------------------

## R Script Title - Plot 2 

## Libraries needed: no special libraries needed.

# Reading the data
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

# Obtaing the subset data
baltimore <- subset (NEI, fips == "24510")
total.PM25yr <- tapply(baltimore$Emissions, baltimore$year, sum)

# Line plot
png("plot2.png")
plot(names(total.PM25yr), total.PM25yr, type ="o", xlab="Year", ylab= expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), main="Total Emissions for Baltimore City, Maryland", col = "dark blue")
dev.off()

# Conclusion (Answer to Q2) - Total emissions from PM2.5 have decreased in the 
# Baltimore City, Maryland from 1999 to 2008 however there was an increase of PM2.5 # between the year 2002 and 2006

# --------------------------------------------------------------------------------
# Q3 - Of the four types of sources indicated by the type (point, nonpoint,onroad 
# , nonroad) variable, which of these four sources have seen decreases in      
# emissions from 1999-2008 for Baltimore City? Which have seen increases in      
# emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer 
# this question.
# --------------------------------------------------------------------------------

# R Script Title - Plot 3

## Libraries needed
library(ggplot2)
library(plyr)

# Reading the data
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

# Obtaing the subset data
baltimore <- subset (NEI, fips == "24510")
typePM25.year <- ddply(baltimore, .(year, type), function(x) sum(x$Emissions))

# Renaming the column: Emissions
colnames(typePM25.year)[3] <- "Emissions"

# ggplot 
png("plot3.png") 
ggplot(data=typePM25.year, aes(x=year, y=Emissions, group=type, color=type)) + geom_line() + geom_point( size=4, shape=19 ) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)")) + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emmission by Type of Sources"))
dev.off()

# Conclusion (Answer to Q3)
## Decreases in emissions from 1999-2008 
# --------------------------------------
# The non-road, nonpoint, on-road source types have all seen decreased emissions 
# overall from 1999-2008 in Baltimore City.

## Increases in emissions from 1999-2008
# --------------------------------------
# The point source saw a slight increase overall from 1999-2008. Also note that the # point source saw a significant increase until 2005 at which point it decreases 
# again by 2008 to just above the starting values.

# --------------------------------------------------------------------------------
# Q4 - Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?
# --------------------------------------------------------------------------------

# R Script Title - Plot 4

## Libraries needed
library(lattice)
library(plyr)

# Reading the data
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

# Obtaining the subset data
SCC.coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
SCC.coal <- SCC[SCC.coal, ]
SCC.identifiers <- as.character(SCC.coal$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI.coal <- NEI[NEI$SCC %in% SCC.identifiers, ]

aggregate.coal <- with(NEI.coal, aggregate(Emissions, by = list(year), sum))
colnames(aggregate.coal) <- c("year", "Emissions")

# Line plot
png(filename="Plot4.png", width=480, height=480)
plot(aggregate.coal, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Emissions and Total Coal Combustion for the United States", 
     xlim = c(1999, 2008))
polygon(aggregate.coal, col = "purple", border = "yellow")
dev.off()

# Conclusion (Answer to Q4) - Emissions from coal combustion related sources have 
# decreased from 6 * 10^6 to below 4 * 10^6 from 1999-2008.

# --------------------------------------------------------------------------------
# Q5 - How have emissions from motor vehicle sources changed from 1999-2008 in   
# Baltimore City?
# --------------------------------------------------------------------------------

# R Script Title - Plot 5

## Libraries needed
library(ggplot2)
library(plyr)

# Reading the data
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

# Obtaining the subset data
baltimore.emissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
baltimore.emissions.aggr <- aggregate(Emissions ~ year, data=baltimore.emissions, FUN=sum)

# ggplot
png(filename="Plot5.png", width=480, height=480)
ggplot(baltimore.emissions.aggr, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity",fill="lightblue",colour="blue") +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emissions")) +
  ggtitle("Total Emissions from Motor Vehicle in Baltimore City, 1999 - 2008")
dev.off()

# Conclusion (Answer to Q5) - Emissions from motor vehicle sources have dropped from # 1999-2008 in Baltimore City!

# ---------------------------------------------------------------------------------
# Q6 - Compare emissions from motor vehicle sources in Baltimore City with 
# emissions from motor vehicle sources in Los Angeles County, California (fips == 
# "06037"). Which city has seen greater changes over time in motor vehicle 
# emissions?
# ---------------------------------------------------------------------------------

# R Script Title - Plot 6

## Libraries needed
library(ggplot2)

# Reading the data
vehiclesNEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

# Obtaining subset data for Baltimore
vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips == 24510,]
vehiclesBaltimoreNEI$city <- "Baltimore City"

# Obtaining subset data for Los Angeles
vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"

bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)

# ggplot
png(filename="Plot6.png", width=480, height=480)
ggp <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_grey() +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))
print(ggp)
dev.off()

# Conclusion (Answer to Q6)- Los Angeles County has seen the greatest changes over 
# time in motor vehicle emissions.