# Run data exploration to create dataset
source("DataExploration.R")

# Plot temperature change over time
ggplot(world_data, aes(x=year, y=temperature_change_from_co2)) + geom_point() + labs(title="Temperature change from CO2", x="Year", y="Temperature change from CO2")

# Build regression model
model <- lm(temperature_change_from_co2 ~ coal_co2 + gas_co2 + oil_co2 + cement_co2 + land_use_change_co2, data=world_data)
summary(model)

# Check residuals
residuals <- resid(model)
hist(residuals, main="Histogram of Residuals", xlab="Residuals", col="lightblue")
qqnorm(residuals)
qqline(residuals, col = "red")

# Residuals vs Fitted plot
plot(model$fitted.values, residuals,
     main = "Residuals vs Fitted",
     xlab = "Fitted values",
     ylab = "Residuals")
abline(h = 0, col = "red", lty = 2)

# Cook's Distance plot
cooksd <- cooks.distance(model)
plot(cooksd, type = "h",
     main = "Cook's Distance",
     xlab = "Observation",
     ylab = "Cook's Distance")
abline(h = 4/(nrow(world_data)-length(model$coefficients)-2), col = "red")

# Check for multicollinearity
vif_values <- vif(model)
print(vif_values)