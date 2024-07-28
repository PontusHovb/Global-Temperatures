# Load necessary libraries
#install.packages("readr")
#install.packages("dplyr")

# Load libraries
library(dplyr)

# Define dataset paths
temp_file <- "Data/temp.txt"
co2_file <- "Data/co2.txt"
methan_file <- "Data/methan.txt"


######### Download data ######### 
# CO2 concentration (https://climate.nasa.gov/vital-signs/carbon-dioxide/?intent=121)
url <- "https://gml.noaa.gov/webdata/ccgg/trends/co2/co2_mm_mlo.txt"
download.file(url, destfile = co2_file)

# Global average temperature (https://climate.nasa.gov/vital-signs/global-temperature/?intent=121)
url <- "https://data.giss.nasa.gov/gistemp/graphs/graph_data/Global_Mean_Estimates_based_on_Land_and_Ocean_Data/graph.txt"
download.file(url, destfile = temp_file)

# Methane concentration (https://climate.nasa.gov/vital-signs/methane/?intent=121)
url <- "https://gml.noaa.gov/webdata/ccgg/trends/ch4/ch4_mm_gl.txt"
download.file(url, destfile = methan_file)


######### Create datasets ######### 
# Read temp data
lines <- readLines(temp_file)
data_lines <- lines[6:length(lines)]
temp_data <- read.table(text = data_lines, header = FALSE)
colnames(temp_data) <- c("year", "temp", "trend")

# Read CO2 data
lines <- readLines(co2_file)
data_lines <- lines[43:length(lines)]
co2_data <- read.table(text = data_lines, header = FALSE)
colnames(co2_data) <- c("year", "month", "decimal_date", "average", "interpolated", "no_days", "st.dev of days", "unc. of mon mean")

# Read methan data
lines <- readLines(methan_file)
data_lines <- lines[49:length(lines)]
methan_data <- read.table(text = data_lines, header = FALSE)
colnames(methan_data) <- c("year", "month", "decimal_date", "average", "average_unc", "trend", "trend_unc")

# Check data 
#View(temp_data)
#View(co2_data)
#View(methan_data)


######### Combine datasets ######### 
# Calculate yearly averages
co2_yearly_averages <- co2_data %>%
  group_by(year) %>%
  summarize(
    co2 = mean(average, na.rm = TRUE),
  )
methan_yearly_averages <- methan_data %>%
  group_by(year) %>%
  summarize(
    methan = mean(average, na.rm = TRUE),
  )

# Check data
#View(co2_yearly_averages)
#View(methan_yearly_averages)

# Left join with temperature data
data <- temp_data[, c("year", "temp")] %>%
  left_join(co2_yearly_averages, by = "year")
data <- data %>%
  left_join(methan_yearly_averages, by = "year")

View(data)