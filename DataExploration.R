# Load necessary libraries
#install.packages("readr")
#install.packages("dplyr")
#install.packages("naniar")
#install.packages("corrplot")
#install.packages("ggplot2")
#install.packages("car")

# Load libraries
library(readr)
library(dplyr)
library(naniar)
library(corrplot)
library(ggplot2)
library(car)

# Define variables
DATA_FILE <- "Data/data.csv"
MAX_MISSING_PROP <- 0.5

# Load data
data <- read_csv(DATA_FILE)
#View(data)

#############################################################
###########   1. Filter all countries & regions   ###########
#############################################################
datasets <- data %>% distinct(country, iso_code)
regions <- datasets %>% filter(is.na(iso_code))
countries <- datasets %>% filter(iso_code != "")
#View(regions)
#View(countries)

#############################################################
##########   2. Data exploration, world dataset    ##########
#############################################################
world_data <- data %>% filter(country == "World")

#################   2.1 Dataset overview    #################
#View(world_data)
head(world_data)
str(world_data)
summary(world_data)
dim(world_data)

# Remove all share (of world) variables since dataset only includes full world
columns_to_remove <- grep("share", names(world_data), ignore.case = TRUE)
world_data <- world_data[, -columns_to_remove]

################    2.2 Missing variables    ################
sapply(world_data, function(x) sum(is.na(x)))
gg_miss_var(world_data)

# Filter out variables with over threshold missing values
missing_prop <- colMeans(is.na(world_data))
world_data <- world_data[, missing_prop < MAX_MISSING_PROP]
dim(world_data)

# Remove growth variables
growth_columns <- grep("growth", names(world_data))
world_data <- world_data[, -growth_columns]
dim(world_data)

# Remove cumulative variables
cumulative_columns <- grep("cumulative", names(world_data))
world_data <- world_data[, -cumulative_columns]
dim(world_data)

# Remove per capita variables
per_capita_columns <- grep("per_capita", names(world_data))
world_data <- world_data[, -per_capita_columns]
dim(world_data)

##############    2.3 Variable distribution    ##############
for (col_name in names(world_data)) {
  # Skip the 'year' column
  if (col_name == "year") next
  
  # Get the column data
  col_data <- world_data[[col_name]]
  
  # Check if the column is numeric
  if (is.numeric(col_data)) {
    # Remove NA values for plotting
    valid_indices <- !is.na(col_data) & !is.na(world_data$year)
    
    # Check if there are any valid (non-NA) values to plot
    if (any(valid_indices)) {
      # Plot line plot for numeric columns over time
      plot(world_data$year[valid_indices], col_data[valid_indices], type = "l", col = "blue",
           xlab = "Year", ylab = "Value", 
           main = paste("Line Plot of", col_name, "Over Time"))
    }
  }
}

###################    2.4 Correlation    ###################
cor_matrix <- cor(world_data[, sapply(world_data, is.numeric)])
corrplot(cor_matrix, method="circle")

# Linear relationship
ggplot(world_data, aes(x=co2, y=temperature_change_from_co2)) + geom_point() + labs(title="Temperature change from CO2", x="CO2", y="Temperature change from CO2")



