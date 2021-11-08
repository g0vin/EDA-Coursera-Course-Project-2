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

#Subset the appropriately for Baltimore and Los Angeles data
vehicle_subset_baltimore <- subset(vehicle_subset, fips=="24510")
vehicle_subset_baltimore$city <- "Baltimore"
vehicle_subset_la <- subset(vehicle_subset, fips=="06037")
vehicle_subset_la$city <- "Los Angeles"


#Combine the appropriately subsetted Los Angeles and Baltimore data
vehicle_subset2 <- rbind(vehicle_subset_baltimore, vehicle_subset_la)

#Tibble the PM2.5 Emissions per year from vehicles
yearly_vehicle_emissions <- vehicle_subset2 %>%
  group_by(city, year) %>%
  summarize(totalEmissions = sum(Emissions))

#Create png
png('plot6.png')

#Create a facet barplot by city to visualize the PM2.5 emissions
ggplot(vehicle_subset2, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(.~city) +
  labs(x="Year", y="PM2.5 Emissions")

#Close png
dev.off()