#Read in the data
NEI <- readRDS("~/Downloads/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/Downloads/exdata_data_NEI_data/Source_Classification_Code.rds")

#Call the tidyverse library to do dplyr
library(tidyverse)

#Tibble the PM2.5 Emissions per year
yearly_total_emissions <- NEI %>%
  group_by(year) %>%
  summarize(totalEmissions = sum(Emissions))

#Create png
png('plot1.png')

#Create a barplot to visualize if the total PM2.5 emissions have decreased
barplot(yearly_total_emissions$totalEmissions, names.arg=yearly_total_emissions$year, ylab="Total PM2.5 Emissions", xlab="Year", main="Total PM2.5 Emissions from 1999 to 2008")

#Close png
dev.off()
