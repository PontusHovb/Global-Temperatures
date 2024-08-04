# Global Temperatures
In this project the increasing global temperatures as a consequence of CO2-emissions are studied. 
- [DataExploration.R](https://github.com/PontusHovb/Global-Temperatures/blob/master/DataExploration.R) explores the dataset
- [RegressionAnalysis.R](https://github.com/PontusHovb/Global-Temperatures/blob/master/RegressionAnalysis.R) performs a regression analysis predicting temperature change with CO2-emissions as independent variables

A model with CO2 emissions from coal, gas, oil, cement and land use change has an adjusted R-squared of 0.993 of predicting temperature change.
The Normal QQ Plot shows no signs of extreme values outside what would be expected for normally distributed variables
<p align="center">
    <img src="https://github.com/PontusHovb/Global-Temperatures/blob/master/Plots/Normal%20QQ%20Plot.png" width="400"/>
</p>
<p align="center"><i>Normal QQ Plot</i></p>

The residuals vs fitted shows no signs of heteroscedasticity or non-linear relationship
<p align="center">
    <img src="https://github.com/PontusHovb/Global-Temperatures/blob/master/Plots/Residuals%20vs%20Fitted.png" width="400"/>
</p>
<p align="center"><i>Residuals vs Fitted</i></p>

From the Cook's distance plot, we can see that the most influential points are the latest observations (from most recent years) which is to be expected since these are the years where global emissions and temperature change have been the highest.
<p align="center">
    <img src="https://github.com/PontusHovb/Global-Temperatures/blob/master/Plots/Cook's%20Distance.png" width="400"/>
</p>
<p align="center"><i>Residuals vs Fitted</i></p>

## Source
Our World in Data
- [Website](https://ourworldindata.org/co2-and-greenhouse-gas-emissions)
- [GitHub](https://github.com/owid/co2-data)
