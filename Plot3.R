#Read in the data
NEI <- readRDS("~/Downloads/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/Downloads/exdata_data_NEI_data/Source_Classification_Code.rds")

#Call the tidyverse library to use ggplot and dplyr
library(tidyverse)

#Subset the NEI data to Baltimore data
NEI_baltimore <- subset(NEI, fips=="24510")

#Tibble the PM2.5 Emissions per year for Baltimore based on the four types of sources
baltimore_yearly_emissions_type <- NEI_baltimore %>%
  group_by(year, type) %>%
  summarize(totalEmissions = sum(Emissions))

#Create png
png('plot3.png')

#Create a line plot to visualize which type of source the total PM2.5 emissions have increased or decreased in Baltimore.
ggplot(baltimore_yearly_emissions_type, aes(x=year, y=totalEmissions, color=type)) +
  geom_line() +
  labs(x="Year", y="Total PM2.5 Emissions", title="Total Emissions in Baltimore from 1999 to 2008")

#Close png
dev.off()