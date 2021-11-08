#Read in the data
NEI <- readRDS("~/Downloads/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/Downloads/exdata_data_NEI_data/Source_Classification_Code.rds")

#Call the tidyverse library to do dplyr
library(tidyverse)

#Subset the NEI data to Baltimore data
NEI_baltimore <- subset(NEI, fips=="24510")

#Tibble the PM2.5 Emissions per year for Baltimore
baltimore_yearly_emissions <- NEI_baltimore %>%
  group_by(year) %>%
  summarize(totalEmissions = sum(Emissions))

#Create png
png('plot2.png')

#Create a barplot to visualize if the total PM2.5 emissions have decreased in Baltimore
barplot(baltimore_yearly_emissions$totalEmissions, names.arg=baltimore_yearly_emissions$year, xlab="Years", ylab="Total PM2.5 Emissions", main="Total PM2.5 Emissions in Baltimore from 1999 to 2008")

#Close png
dev.off()