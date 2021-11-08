#Read in the data
NEI <- readRDS("~/Downloads/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/Downloads/exdata_data_NEI_data/Source_Classification_Code.rds")

#Merge the NEI and SCC data
merged_data <- merge(NEI, SCC, by="SCC")

#Call the tidyverse library to use ggplot and dplyr
library(tidyverse)

#Use the grepl function to look up the data with the word "Vehicle" in the Short.Name variable
vehicle <- grepl("Vehicle", merged_data$SCC.Level.Two, ignore.case=T)

#Subset so that vehicle data shows
vehicle_subset <- merged_data[vehicle, ]

#Subset so that Baltimore data is shown
vehicle_subset <- subset(vehicle_subset, fips=="24510")

#Tibble the PM2.5 Emissions per year from vehicles
yearly_vehicle_emissions_baltimore <- vehicle_subset %>%
  group_by(year) %>%
  summarize(totalEmissions = sum(Emissions))

#Create png
png('plot5.png')

#Create a barplot to show how emissions from vehicles have changed from 1999 to 2008
ggplot(yearly_vehicle_emissions_baltimore, aes(x=factor(year), y=totalEmissions, fill=year)) +
  geom_bar(stat="identity") +
  labs(x="Year", y="Total PM2.5 Vehicle Emissions", title="Total Emissions from Vehicles in Baltiore from 1999 to 2008")

#Close png
dev.off()