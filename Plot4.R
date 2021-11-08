#Read in the data
NEI <- readRDS("~/Downloads/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/Downloads/exdata_data_NEI_data/Source_Classification_Code.rds")

#Merged the NEI and SCC data sets
merged_data <- merge(NEI, SCC, by="SCC")

#Call the tidyverse library to use ggplot and dplyr
library(tidyverse)

#Use the grepl function to look up the data with the word "Coal" in the Short.Name variable
coal <- grepl("Coal", merged_data$Short.Name, ignore.case=T)

#Subset so that coal data shows
coal_subset <- merged_data[coal, ]

#Tibble the Coal Emissions per year
yearly_coal_emissions <- coal_subset %>%
  group_by(year) %>%
  summarize(totalEmissions = sum(Emissions))

#Create png
png('plot4.png')

#Create a barplot to visualize how emissions have changed
ggplot(yearly_coal_emissions, aes(x=year, y=totalEmissions, fill=year)) +
  geom_bar(stat="identity") +
  labs(x="Year", y="Total PM2.5 Coal Emissions", title="Total Coal Emissions from 1999 to 2008")

#Close png
dev.off()